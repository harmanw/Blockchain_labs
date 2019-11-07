pragma solidity ^0.4.8;

contract wallet_vuln {
    address public owner;
    bool initialised = false;

    function wallet_vuln() uninitialised {
        initWallet(msg.sender);
        initialised = true;  // ------------ !!!
    }
    
    function withdraw(uint amount) onlyOwner returns (bool success)  {
        return owner.send(amount);
     }

    function deposit() payable {}
    
    function initWallet(address _owner){
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

    modifier uninitialised() {   // ------------- !!!
        if (initialised) throw;
        _;
    } 
}
