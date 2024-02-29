// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContratoInteligente {
    address public owner;
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function transfer(address to, uint256 value) external {
        require(balances[msg.sender] >= value, "Insufficient balance");
        require(to != address(0), "Invalid address");

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
    }

    function deposit() external payable {
        require(msg.value > 0, "You must send some ether");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
}
