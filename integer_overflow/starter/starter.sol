pragma solidity 0.4.8;

contract TotalEarnings {
    
    string answer = "";
    uint8 revenue;
    
    function TotalEarnings() {
        revenue = 0;
    }
    
    function AddRevenue (uint8 val) public {
        // Add your code here
        
        // --
        
        revenue += val;
    }
    
    function getRevenue() returns (uint8) {
        return revenue;
    }
    
    function myanswer (string x) public {
        answer = x;
    }
    
}