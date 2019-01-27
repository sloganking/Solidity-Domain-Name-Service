const dns = artifacts.require("DNS");
const ownable = artifacts.require("Ownable");

module.exports = function(deployer) {
    deployer.deploy(dns);
    deployer.deploy(ownable);
};