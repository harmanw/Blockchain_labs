pragma solidity ^0.4.21;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/attacker.sol";
import "../contracts/auction.sol";
import "../contracts/user.sol";

contract attacker_test {

    event LOG(string message, uint256 value);

    attacker atker;
    user usr;
    uint bal = 10000000000000000000;

    auction auc = auction(DeployedAddresses.auction());



    function testBefore(){
        usr = user(DeployedAddresses.user());
        usr.linkToAuc(address(auc));
    }

    function testAttackerDeployment() public {
        atker = attacker(DeployedAddresses.attacker());
        Assert.equal(address(atker).balance, bal, "Balance not right");
    }

    function testAttack() public {
        usr.bid();
        atker.attack(address(auc));
    }

    function testOtherUserBid() public {
        usr.bidHighest();
        Assert.equal(address(usr).balance, bal-10, "DOS Successful!");
    }

}

