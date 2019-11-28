pragma solidity ^0.4.21;

import "./auction.sol";

contract user {
    auction auc;
    
    function user() public payable {}
    
    function linkToAuc(address addr) public {
        auc = auction(addr);
    }

    function bid() public {
        auc.bid.value(10)();
    }

    function bidHighest() public {
        uint val = auc.getHighestBid();
        auc.bid.value(val+1)();
    }
    
    function() payable public {
        if (auc.getCurrentLeader() == address(this)) revert();
    }
    
}