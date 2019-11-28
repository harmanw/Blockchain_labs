var auction = artifacts.require("./auction.sol");
var attacker = artifacts.require("./attacker.sol");
var user = artifacts.require("./user.sol");

module.exports = function(deployer) {
    deployer.deploy(auction);
    deployer.deploy(attacker, {value : 100  });    
    deployer.deploy(user, {value : 100  });

};