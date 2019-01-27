pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DNS.sol";

contract TestDns {
    function testClaimNewNameUsingDeployedContract() public {
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
    
    function testSetNamesIPAddressUsingDeployedContract() public {
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

    function testListNamesOwnedByUsingDeployedContract() public {
        DNS dns = DNS(DeployedAddresses.DNS());
        dns.claimNewName("name0");
        dns.claimNewName("name1");
        dns.claimNewName("name2");
        uint[] memory listOfOwnedNames = dns.listNamesOwnedBy();
        Assert.equal(
            0,
            listOfOwnedNames[0],
            "Claimed names with IDs 0-2 but 0-2 was not listed by listNamesOwnedBy()"
        );
        Assert.equal(
            1,
            listOfOwnedNames[1],
            "Claimed names with IDs 0-2 but 0-2 was not listed by listNamesOwnedBy()"
        );
        Assert.equal(
            2,
            listOfOwnedNames[2],
            "Claimed names with IDs 0-2 but 0-2 was not listed by listNamesOwnedBy()"
        );
    }
}
