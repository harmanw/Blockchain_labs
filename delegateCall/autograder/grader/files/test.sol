pragma solidity ^0.4.21;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/string.sol";
import "../contracts/essay.sol";


contract attacker_test {

    event LOG(string message);

    strings lib;
    essay work;

    function beforeAll() public {
        lib = strings(DeployedAddresses.strings());
        work = essay(DeployedAddresses.essay());
    }

    function testAttack() public {
        work.find("abcd");
    }

    function testExport() public {
        string dummy = "bitcoin is garbage!!";
        work.makeRevision(dummy);
        Assert.equal(work.export(), dummy, "Export not working correctly !")
    }

}

