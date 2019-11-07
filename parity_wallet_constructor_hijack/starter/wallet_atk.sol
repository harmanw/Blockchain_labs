pragma solidity ^0.4.8;

import "./wallet_vuln.sol";

contract Wallet_atk {
    address public owner;
    wallet_vuln victim;
    
    function Wallet() {
        initWallet(msg.sender);
    }
    
    function withdraw(uint amount) onlyOwner returns (bool success)  {
        return owner.send(amount);
    }

    function deposit() payable {}


    function attack(address vic) {
        // Your code goes here !!!
        
    }
    
    function initWallet(address _owner) {
         owner = _owner;
    }

    function kill(address _to) onlyOwner {
         suicide(_to);
    }
    
    function getBalance() returns (uint) {
        return address(this).balance;
    }
     
    modifier onlyOwner() {
        if (owner != msg.sender) throw;
        _;
    } 
}
