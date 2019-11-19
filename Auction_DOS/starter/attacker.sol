pragma solidity ^0.4.10;

import "./auction.sol";

contract Attacker {
    Auction auc;
    
    function attack(address addr) {
        auc = Auction(addr);
    }
    
    function() payable public {}
    
}