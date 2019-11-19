pragma solidity ^0.4.8;

import "./SmartFinances.sol";

contract Wallet {
    address public owner;
    bool initialised = false;
    uint[] deposits;
    uint[] withdrawals;
    
    SmartFinances lib;

    function Wallet() public payable uninitialised {
        lib.delegatecall(bytes4(keccak256("initwallet()", msg.sender)));
        initialised = true;  
    }
    
    function withdraw(uint amount) public returns (bool success)  {
        return lib.delegatecall(bytes4(keccak256("withdraw()", amount)));
    }
    
    function SendTo(uint amount, address to) public returns (bool success)  {
        return lib.delegatecall(bytes4(keccak256("sendTo()", amount, to)));
    }
    
    function deposit() public returns (bool) {
        return lib.delegatecall(bytes4(keccak256("deposit()")));
    }
    
    function () public payable {}

    modifier uninitialised() {  
        if (initialised) throw;
        _;
    } 
}