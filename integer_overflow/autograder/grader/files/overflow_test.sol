pragma solidity ^0.4.20;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/starter.sol.sol";

contract overflow_test {

    event LOG(string message, uint256 value);

    TotalEarnings te;

    function testSetup() public {
        te = TotalEarnings(DeployedAddresses.bank());
    }

    function test_overflow() public {
        uint a = te.getRevenue;
        uint x = 300;
        te.addRevenue(x)
        Assert.True(address(te).getRevenue == a + 300 || address(te).getRevenue == 255);
    }

}

