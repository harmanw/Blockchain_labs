pragma solidity 0.4.8;

contract TotalEarnings {
    
    
    string answer = "";
    uint256 revenue;
    
    function TotalEarnings() {
        revenue = 0;
    }
    
    function AddRevenue (uint256 val) public {
        // Add your code here
        
        // if (revenue + val > 255) { throw; }
        // require(revenue + val < 256)

        // --
        
        revenue += val;
    }
    
    function getRevenue() returns (uint256) {
        return revenue;
    }
    
    function myanswer (string x) public {
        answer = x;
    }
    
}