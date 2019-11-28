pragma solidity ^0.4.10;

import "./auction.sol";

contract attacker {
    auction auc;
    
    function attack(address addr) {
        auc = auction(addr);
    }
    
    function() payable public {}
    
}