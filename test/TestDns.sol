pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DNS.sol";

contract TestDns {
    function testClaimNewName() public {
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

    function testSetNamesIPAddress() public {
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

    function testListNamesOwnedBy() public {
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

    function testGetNameByID() public {
        DNS dns = DNS(DeployedAddresses.DNS());
        string memory name = "name5";
        dns.claimNewName(name);
        Assert.equal(
            name,
            dns.getNameByID(5),
            "getNameByID did not match expected name"
        );
        name = "name6";
        dns.claimNewName(name);
        Assert.equal(
            name,
            dns.getNameByID(6),
            "getNameByID did not match expected name"
        );
        name = "name7";
        dns.claimNewName(name);
        Assert.equal(
            name,
            dns.getNameByID(7),
            "getNameByID did not match expected name"
        );
    }
}
