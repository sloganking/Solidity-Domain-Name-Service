const dns = artifacts.require("DNS");
const ownable = artifacts.require("Ownable");

module.exports = function(deployer) {
    deployer.deploy(ownable);
    //deployer.link(ownable, dns);
    deployer.deploy(dns);
};