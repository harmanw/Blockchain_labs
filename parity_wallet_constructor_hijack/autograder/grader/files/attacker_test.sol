pragma solidity ^0.4.20;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/attacker.sol";
import "../contracts/bank.sol";

contract attacker_test {

    event LOG(string message, uint256 value);

    bank mybank;
    attacker atker;
    uint bank_bal = 10000000000000000000;
    uint atker_bal = 3000000000000000000;

    function testBankDeployment() public {
        mybank = bank(DeployedAddresses.bank());
        Assert.equal(address(mybank).balance, bank_bal, "Balance not right");
    }

    function testAttackerDeployment() public {
        atker = attacker(DeployedAddresses.attacker());
        Assert.equal(address(atker).balance, atker_bal, "Balance not right");
    }

    function testAttack() public {
        atker.startAttack(address(mybank));
    }

    function testBankMoneyDrained() public {
        Assert.equal(address(mybank).balance , 0, "atker received some money");
    }

    function testAttackerMoneyReceived() public {
        Assert.equal(address(atker).balance , bank_bal + atker_bal, "atker received some money");
    }

}

