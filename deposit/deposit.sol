// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SavingAccount {

    address owner;

    mapping(address => uint256) public balances;

    event Deposit(address indexed account, uint256 amount);

    event Withdrawal(address indexed account, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amo_unt) external {
        require(amo_unt > 0, "Amount must be greater than zero");

        require(amo_unt <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amo_unt;
        payable(msg.sender).transfer(amo_unt);
        emit Withdrawal(msg.sender, amo_unt);
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function contractBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    
    function withdrawAll() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
