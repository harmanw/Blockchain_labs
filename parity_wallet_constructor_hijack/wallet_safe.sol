pragma solidity ^0.4.8;

contract WalletLibrary {
     address public owner;
     bool private initialized = false;

     // called by constructor
     function WalletLibrary(address _owner) {
         initWallet(_owner);    // ------------- !!!
         // ... more setup ...
     }
     
     function initWallet(address _owner) firstInit {
         initialized = true;
         owner = _owner;
     }

     function changeOwner(address _new_owner) external onlyOwner{
         if (msg.sender == owner) {
             owner = _new_owner;
         }
     }

     function () payable {
         // ... receive money, log events, ...
     }

     function withdraw(uint amount) external onlyOwner returns (bool success)  {
         if (msg.sender == owner) {
             return owner.send(amount);
         } else {
             return false;
         }
     }
     
     function kill(address _to) payable external onlyOwner {
         suicide(_to);
     }
     
     modifier firstInit(){
         if (initialized) throw;
         _;
     }
     
     modifier onlyOwner() {
        if (owner != msg.sender) throw;
        _;
    }   
}