var auction = artifacts.require("./auction.sol");
var attacker = artifacts.require("./attacker.sol");
var user = artifacts.require("./user.sol");

module.exports = function(deployer) {
    deployer.deploy(auction, {value : 10000000000000000000 });
    deployer.deploy(attacker, {value : 10000000000000000000  });
    deployer.deploy(user, {value : 10000000000000000000  });

};