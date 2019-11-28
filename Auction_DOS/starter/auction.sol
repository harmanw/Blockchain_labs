pragma solidity ^0.4.21;

contract auction {
    address currentLeader;
    uint highestBid;
    address owner;
    bool auctionOpen = true;
    
    function auction() public onlyUninitialised {
        owner = msg.sender;
        highestBid = 0;
        auctionOpen = true;
    }
    
    function bid() payable public  acceptingBids {
        if (currentLeader == address(0)){
            currentLeader = msg.sender;
            highestBid = msg.value;
        } else {
            require(currentLeader.send(highestBid));
            currentLeader = msg.sender;
            highestBid = msg.value;
        }
        
    }
    
    function endAuction() public onlyOwner {
        auctionOpen = false;
    }
    
    function getHighestBid() public view returns (uint) {
        return highestBid;
    }
    
    function getCurrentLeader() public view returns (address) {
        return currentLeader;
    }
    
    modifier onlyGreaterValueBids {
        if (msg.value <= highestBid) revert();
        _;
    }
    
    modifier onlyUninitialised {
        if (owner != address(0)) revert();
        _;
    }
    
    modifier acceptingBids {
        if (!auctionOpen) revert();
        _;
    }
    
    modifier onlyOwner {
        if (msg.sender != owner) revert();
        _;
    }
    
}