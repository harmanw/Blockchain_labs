var essay = artifacts.require("./essay.sol");
var strings = artifacts.require("./string.sol");
var user = artifacts.require("./user.sol");

module.exports = function(deployer) {
    deployer.deploy(string);
    deployer.deploy(essay);    

};