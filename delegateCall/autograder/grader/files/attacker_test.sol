pragma solidity ^0.4.21;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/attacker.sol";
import "../contracts/auction.sol";
import "../contracts/user.sol";

contract attacker_test {

    event LOG(string message);
    event LOG1(uint i);


    attacker atker;
    user usr;
    auction auc;
    uint bal; 
     

    function beforeAll() public {
        auc = auction(DeployedAddresses.auction());
        bal = 100;
        usr = user(DeployedAddresses.user());
        usr.linkToAuc(address(auc));

    }

    function testAttackerDeployment() public {
        atker = attacker(DeployedAddresses.attacker());
        Assert.equal(address(atker).balance, bal, "Balance not right");
    }

    function testAttackExec() public {
        usr.bid();
        //atker.attack(address(auc));
        LOG("Attack Executed !");
    }

    function testOtherUserBid() public {
        usr.bidHighest();
        LOG("Other User Can BID, DOS Attack not successful.");
    }

    function testAttackSuccess() public {
        LOG1(address(usr).balance);
        Assert.equal(address(usr).balance, bal-10, "DOS attack failed. User can bid!!");

    }

}

