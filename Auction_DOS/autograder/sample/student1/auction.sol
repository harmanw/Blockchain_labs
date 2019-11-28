pragma solidity ^0.4.21;

contract auction {
    address currentLeader;
    uint highestBid;
    address owner;
    bool auctionOpen = true;
    
    mapping (address => uint) public withdrawable;                    // ---!
    
    function auction() onlyUninitialised {
        owner = msg.sender;
        highestBid = 0;
    }
    
    function bid() payable onlyGreaterValueBids acceptingBids {
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
    
    modifier onlyLosingBidders {                                  // ---!
        if (msg.sender != currentLeader) throw;
        _;
    }
    
}