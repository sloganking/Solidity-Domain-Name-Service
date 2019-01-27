pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DNS.sol";

contract TestDns {
    function testGetNameByID() public {     //leave as first function
        DNS dns = DNS(DeployedAddresses.DNS());
        string memory name = "name00";
        dns.claimNewName(name);
        Assert.equal(
            name,
            dns.getNameByID(0),
            "getNameByID did not match expected name"
        );
        name = "name01";
        dns.claimNewName(name);
        Assert.equal(
            name,
            dns.getNameByID(1),
            "getNameByID did not match expected name"
        );
        name = "name02";
        dns.claimNewName(name);
        Assert.equal(
            name,
            dns.getNameByID(2),
            "getNameByID did not match expected name"
        );
    }

    function testClaimNewName() public {    //leave as second function
        DNS dns = DNS(DeployedAddresses.DNS());
        string memory expected = "consensys.net";
        dns.claimNewName(expected);
        uint[] memory ownedNames = dns.listNamesOwnedBy();
        Assert.equal(
            expected,
            dns.getNameByID(ownedNames[3]),
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
    
    function testViewNamesIPAddress() public {
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
}
