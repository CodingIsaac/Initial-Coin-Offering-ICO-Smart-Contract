// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./IERC20.sol";

contract Dabby is ERC20Interface {
    string public name = "Dabby";
    string public symbol = "DAB";
    uint256 public decimals = 0;
    uint256 public override totalSupply;

    address public tokenCreator;
    mapping(address => uint256) public tokenBalance;
    mapping(address => mapping(address => uint256)) allowedTokens;

    constructor() {
        totalSupply = 2100000;
        tokenCreator = msg.sender;
        tokenBalance[tokenCreator] = totalSupply;
    }

    receive() external payable {}

    fallback() external payable {}

    function balanceOf(address tokenOwner)
        external
        view
        override
        returns (uint256 balance)
    {
        return tokenBalance[tokenOwner];
    }

    function transfer(address to, uint256 tokens)
        external
        virtual
        override
        returns (bool success)
    {
        require(tokenBalance[msg.sender] >= tokens);
        tokenBalance[msg.sender] -= tokens;
        tokenBalance[to] += tokens;

        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender)
        external
        view
        override
        returns (uint256 remaining)
    {
        return allowedTokens[tokenOwner][spender];
    }

    function approve(address spender, uint256 tokens)
        public
        override
        returns (bool success)
    {
        require(tokenBalance[msg.sender] >= tokens, "Insufficient Token Balance");
        require(tokens > 0, "Insufficient Tokens");

        allowedTokens[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokens
    ) public override returns (bool success) {
        require(allowedTokens[from][to] >= tokens, "Token Insufficient");
        require(tokenBalance[from] >= tokens, "Poor Man, Buy More TOkens");
        tokenBalance[from] -= tokens;
        tokenBalance[to] += tokens;
        allowedTokens[from][to] -= tokens;
        return true;
    }

    // 0x34B63B19C5b10201a360DdF06c52f0922785F5A8 Token Smart Contract Address
}
