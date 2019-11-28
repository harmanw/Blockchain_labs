pragma solidity ^0.4.21;

contract auction {
    address currentLeader;
    uint highestBid;
    address owner;
    bool auctionOpen = true;
    
    function auction() onlyUninitialised {
        owner = msg.sender;
        highestBid = 0;
    }
    
    function bid() payable onlyGreaterValueBids acceptingBids {
        require(currentLeader.send(highestBid)); 
        currentLeader = msg.sender;
        highestBid = msg.value;
    }
    
    function endAuction() onlyOwner {
        auctionOpen = false;
    }
    
    function getHighestBid() public returns (uint) {
        return highestBid;
    }
    
    function getCurrentLeader() public returns (address) {
        return currentLeader;
    }
    
    modifier onlyGreaterValueBids {
        if (msg.value <= highestBid) throw;
        _;
    }
    
    modifier onlyUninitialised {
        if (owner != address(0)) throw;
        _;
    }
    
    modifier acceptingBids {
        if (!auctionOpen) throw;
        _;
    }
    
    modifier onlyOwner {
        if (msg.sender != owner) throw;
        _;
    }
    
}