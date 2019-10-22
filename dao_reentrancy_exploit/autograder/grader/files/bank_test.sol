pragma solidity ^0.4.20;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/attacker.sol";
import "../contracts/bank.sol";

contract bank_test {

    event LOG(string message, uint256 value);

    bank mybank;
    attacker atker;
    bool r;

    uint bank_bal = 10000000000000000000;
    uint atker_bal = 3000000000000000000;

    function testSetup() public {
        mybank = bank(DeployedAddresses.bank());
        Assert.equal(address(mybank).balance, bank_bal, "Balance not right");
        atker = attacker(DeployedAddresses.attacker());
        Assert.equal(address(atker).balance, atker_bal, "Balance not right");
    }
    
    

    function testAttackBank() public {
        atker.startAttack(address(mybank));
        Assert.equal(address(mybank).balance , bank_bal, "atker received some money");
    }

    function testSafeAgainstReentrancy() public {
        Assert.equal(address(mybank).balance , bank_bal, "atker received some money");
    }

}

