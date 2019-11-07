var bank = artifacts.require("./bank.sol");
var attacker = artifacts.require("./attacker.sol");


module.exports = function(deployer) {
    deployer.deploy(bank, {value : 10000000000000000000 });
    deployer.deploy(attacker, {value : 3000000000000000000  });

};