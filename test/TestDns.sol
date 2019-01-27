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
            "Claimed name should be owned"
        );
    }
    
    function testsetNamesIPAddressUsingDeployedContract() public {
        DNS dns = DNS(DeployedAddresses.DNS());
        string memory expected = "1.1.1.1";

        dns.setNamesIPAddress(expected);

        // Assert.equal(
        //     expected,

        // );
    }
}
