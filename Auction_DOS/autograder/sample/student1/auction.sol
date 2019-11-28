pragma solidity ^0.4.21;

contract auction {
    address currentLeader;
    uint highestBid;
    address owner;
    bool auctionOpen = true;
    
    mapping (address => uint) public withdrawable;                    // ---!
    
    function auction() public onlyUninitialised {
        owner = msg.sender;
        highestBid = 0;
        auctionOpen = true;
    }
    
    function bid() payable public onlyGreaterValueBids acceptingBids {
        //require(currentLeader.send(highestBid));
        currentLeader = msg.sender;
        highestBid = msg.value;
        
        withdrawable[currentLeader] = highestBid;                    // ---!
    }
    
    function withdraw() public onlyLosingBidders {                         // ---!
        require(withdrawable[msg.sender] > 0);
        uint val = withdrawable[msg.sender];
        withdrawable[msg.sender] = 0;
        msg.sender.transfer(val);

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
    
    modifier onlyLosingBidders {                                  // ---!
        if (msg.sender != currentLeader) revert();
        _;
    }
    
}