pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DNS.sol";

contract TestDns {
    /** @notice BurnsOwnedTokens before function execution. Uses on tests which rely on having no owned tokens*/
    modifier burnOwnedTokens()
    {
        DNS dns = DNS(DeployedAddresses.DNS());
        uint[] memory allOwnedNames = dns.listNamesOwnedBy();
        for(uint i = 0; i < allOwnedNames.length; i++){
            dns.transferOwnershipForFree(dns.getNameByID(allOwnedNames[i]), 0x0000000000000000000000000000000000000000);
        }
        _;
    }

    /** @notice Tests ListNamesOwnedBy() in DNS.sol */
    function testListNamesOwnedBy()
        public
        burnOwnedTokens()
    {
        DNS dns = DNS(DeployedAddresses.DNS());
        dns.claimNewName("name0");
        dns.claimNewName("name1");
        dns.claimNewName("name2");
        uint[] memory listOfOwnedNames = dns.listNamesOwnedBy();
        for(uint i = 0; i < 3; i++){
            Assert.equal(
            i,
            listOfOwnedNames[i],
            "Claimed names with IDs 0-2 but 0-2 was not listed by listNamesOwnedBy()"
            );
        }
    }

    /** @notice Tests getNameByID() in DNS.sol */
    function testGetNameByID()
        public
        burnOwnedTokens()
    {
        DNS dns = DNS(DeployedAddresses.DNS());
        dns.claimNewName("name00");
        dns.claimNewName("name01");
        dns.claimNewName("name02");
        uint[] memory listOfOwnedNames = dns.listNamesOwnedBy();
        Assert.equal(
            "name00",
            dns.getNameByID(listOfOwnedNames[0]),
            "getNameByID did not match expected name"
        );
        Assert.equal(
            "name01",
            dns.getNameByID(listOfOwnedNames[1]),
            "getNameByID did not match expected name"
        );
        Assert.equal(
            "name02",
            dns.getNameByID(listOfOwnedNames[2]),
            "getNameByID did not match expected name"
        );
    }

    /** @notice Tests claimNewName() in DNS.sol */
    function testClaimNewName()
        public
        burnOwnedTokens()
    {    //leave as second function
        DNS dns = DNS(DeployedAddresses.DNS());
        string memory expected = "consensys.net";
        dns.claimNewName(expected);
        uint[] memory ownedNames = dns.listNamesOwnedBy();
        Assert.equal(
            expected,
            dns.getNameByID(ownedNames[0]),
            "The name retrieved by getNameByID() was not the same as the name given to claimNewName"
        );
    }

    /** @notice Tests setNamesIPAddress() in DNS.sol */
    function testSetNamesIPAddress()
        public
    {
        DNS dns = DNS(DeployedAddresses.DNS());
        string memory expectedIP = "1.1.1.1";
        string memory name = "RandomName";
        dns.claimNewName(name);
        dns.setNamesIPAddress(name,expectedIP);
        Assert.equal(
            expectedIP,
            dns.viewNamesIPAddress(name),
            "Could not set and read IP Address of a name"
        );
    }
    
    /** @notice Tests viewNamesIPAddress() in DNS.sol */
    function testViewNamesIPAddress()
        public
    {
        DNS dns = DNS(DeployedAddresses.DNS());
        string memory expectedIP = "1.1.1.2";
        string memory name = "name10";
        dns.claimNewName(name);
        dns.setNamesIPAddress(name,expectedIP);
        Assert.equal(
            expectedIP,
            dns.viewNamesIPAddress(name),
            "Could not set and read IP Address of a name"
        );
    }
}