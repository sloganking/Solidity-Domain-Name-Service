const dns = artifacts.require("DNS");

module.exports = function(deployer) {
    deployer.deploy(dns);
};