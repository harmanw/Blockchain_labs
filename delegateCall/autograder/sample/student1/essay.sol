pragma solidity ^0.4.8;

import "./string.sol";

contract Essay {

    address public owner;
    bool initialised = false;
    string myessay;
    string title;
    string[] authors;
    
    strings lib;
    
    function Essay() public payable uninitialised {
        myessay = "";
        initialised = true;
    }
    
    function isPresent(string word) public returns (bool) {
        return address(lib).delegatecall(bytes4(keccak256("find", myessay, word)));
    }
    
    function append(string newtext) public returns (bool success) {
        success = address(lib).delegatecall(bytes4(keccak256("strConcat", myessay, newtext)));
    }
    
    function makeRevision(string newtext) public returns (bool success) {
        success = address(lib).delegatecall(bytes4(keccak256("strConcat", "", newtext)));
    }
    
    function addAuthor(string name) public  {
        authors.push(name);
    }

    // ----------------------------------------------------------------------
    function export() public returns (string) {
        return myessay;
    }
    // ----------------------------------------------------------------------

    function () public payable {}

    modifier uninitialised() {  
        if (initialised) throw;
        _;
    } 
}