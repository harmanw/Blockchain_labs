pragma solidity 0.4.13;

contract IntegerOverflow {
    
    event logExplain(uint256 INTEGER, uint UINT8);
    
    string answer;
    
    function Overflow() {
        answer = "WrongAnswer";
    }
    
    function explain() {
        for (uint256 i=250; i<260; i++) {
            logExplain(i, uint8(i));
        }
    }
    
    function myanswer (string x) public {
        answer = x;
    }
    
}
