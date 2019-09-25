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
    
    function attack(address victim) {
    // Your code goes here !!
    
    }

    // fallback function gets called if no other function matches call
    function () payable {
        _walletLibrary.call(msg.data);
    }
}
