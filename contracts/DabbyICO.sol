// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "./dabi.sol";
import "./IERC20.sol";

contract DabbyICO is Dabby {
    /**
     * ICO smart Contract Creation
     *
     * What are the key things we are exploring?
     * 1. ICO Admin
     * 2. ICO Price
     * 3. ICO Hardcap
     * 4. ICO Start Time
     * 5. ICO End Time
     * 6. Minimum Investment
     * 7. Maximum Investment
     * 8. Address Payable
     * 9. Balance of raised amount
     * 10. Function to halt/resume ICO
     * 11. ICO enum to determine the state of the ICO
     */

    address public ICOAdmin;
    address payable public deposit;
    uint256 ICOTokenPrice;
    uint256 public ICOHardcap;
    uint256 public ICOMinInvestment;
    uint256 public ICOMaxInvestment;
    uint256 public saleStarts = block.timestamp;
    uint256 public saleEnds = block.timestamp + 50000;
    uint256 public ICORaisedAmount;
    uint256 public tokenLockPeriods = saleEnds + 604800;
    enum State {
        beforeICOStart,
        ICORunning,
        afterICOEnds,
        ICOHalted
    }
    State public ICOState;
   
    mapping(address => mapping(uint256 => bool)) ICOBalance;

    event Invest(address investor, uint256 value, uint256 tokens);

    modifier onlyICOAdmin() {
        require(msg.sender == ICOAdmin, "Sorry you are not the ICO Admin");
        _;
    }

    modifier ICOEntryPrice() {
        require(
            msg.value >= ICOMinInvestment && msg.value <= ICOMaxInvestment,
            "Insufficient Balance"
        );
        _;
    }
    modifier ICOCurrentState() {
        require(ICOState == State.ICORunning, "ICO Has not Started");
        _;
    }
    modifier tradeStart() {
        require(block.timestamp > tokenLockPeriods, "Token is Still Locked");
        _;
    }

    //    receive() external payable {
    //     invest();
    //    }
    constructor(address payable _depositor) {
        deposit = _depositor;
        ICOAdmin = msg.sender;
        ICOTokenPrice = 0.01 ether;
        ICOHardcap = 500 ether;
        ICOMinInvestment = 0.1 ether;
        ICOMaxInvestment = 2 ether;
        
    }

    // Function to halt the ICO
    function haltICO() public onlyICOAdmin {
        ICOState = State.ICOHalted;
    }

    // Function to resume ICO

    function resumeICO() public onlyICOAdmin {
        ICOState = State.ICORunning;
    }

    // Should the initial smart contract is attacked, we can comfortable chane the address

    function changeDepositAddress(address payable _newDeposit)
        public
        onlyICOAdmin
    {
        deposit = _newDeposit;
    }

    // We can use this to check the state of the ICO

    function getCurrentICOState() public view returns (State) {
        if (ICOState == State.ICOHalted) {
            return State.ICOHalted;
        } else if (block.timestamp < saleStarts) {
            return State.beforeICOStart;
        } else if (
            block.timestamp >= saleStarts && block.timestamp <= saleEnds
        ) {
            return State.ICORunning;
        } else {
            return State.afterICOEnds;
        }
    }

    function invest()
        public
        payable
        ICOCurrentState
        ICOEntryPrice
        returns (bool)
    {
        ICOState = getCurrentICOState();
        ICORaisedAmount += msg.value;
        uint256 tokens = msg.value / ICOTokenPrice;
        tokenBalance[tokenCreator] -= tokens;
        tokenBalance[msg.sender] += tokens;
        deposit.transfer(msg.value);
        emit Invest(msg.sender, msg.value, tokens);
        return true;
    }

    function transfer(address to, uint256 tokens)
        public
        override
        tradeStart
        returns (bool success)
    {
        super.transfer(to, tokens);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokens
    ) public tradeStart virtual override  returns (bool success) {
        super.transferFrom(from, to, tokens);
        return true;
    }
}

// 0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B ICO SMART CONTRACT ADDRESS
