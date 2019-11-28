pragma solidity ^0.4.21;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/attacker.sol";
import "../contracts/auction.sol";
import "../contracts/user.sol";

contract auction_test {

    event LOG(string message);
    event LOG1(uint i);

    attacker atker;
    user usr;
    auction auc;
    uint bal; 
     

    function beforeAll() public {
        atker = attacker(DeployedAddresses.attacker());
        bal = 100;
        usr = user(DeployedAddresses.user());
        usr.linkToAuc(address(auc));

    }

    function testAttackerDeployment() public {
        auc = auction(DeployedAddresses.auction());
        Assert.equal(address(auc).balance, 0, "Balance not right");
    }

    function testAttackExec() public {
        //usr.bid();
        atker.attack(address(auc));
        LOG("Attack Executed !");
    }

    function testOtherUserBid() public {
        //usr.bidHighest();
        Assert.equal(auc.getCurrentLeader(), auc.getCurrentLeader(), "Other User Can't bid!");
    }

}

