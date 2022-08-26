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

    receive() override payable external {}
    fallback() override payable external {}

    address public ICOAdmin;
    address payable public deposit;
    uint ICOPrice;
    uint public ICOHardcap;
    uint public ICOMinInvestment;
    uint public ICOMaxInvestment;
    uint public saleStarts = block.timestamp;
    uint public saleEnds = block.timestamp + 50000;
    uint public ICORaisedAmount;
    uint public tokenLockPeriods;
    enum State { beforeICOStart, ICORunning, afterICOEnds, ICOHalted}
    State public ICOState;
    mapping (address => mapping(uint => bool)) ICOBalance;

    constructor(address payable _depositor) {
        deposit = _depositor;
        ICOAdmin = msg.sender;
        ICOPrice = 0.01 ether;
        ICOHardcap = 500 ether;
        ICOMinInvestment = 0.1 ether;
        ICOMaxInvestment = 2 ether;
        ICOState = State.beforeICOStart;
        
    }






 }