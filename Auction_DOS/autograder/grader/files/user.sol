pragma solidity ^0.4.21;

import "./auction.sol";

contract user {
    auction auc;
    
    function linkToAuc(address addr) public {
        auc = auction(addr);
    }

    function bid(){
        auc.bid.value(10)();
    }

    function bidHighest(){
        uint val = auc.getHighestBid();
        auc.bid.value(val+1)();
    }
    
    function() payable public {
        if (auc.getCurrentLeader() == address(this)) throw;
    }
    
}