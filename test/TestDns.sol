pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DNS.sol";

contract TestDns {
    function claimNewNameUsingDeployedContract() public {
    //MetaCoin meta = MetaCoin(DeployedAddresses.MetaCoin());
    DNS dns = DNS(DeployedAddresses.DNS());

    string memory expected = "consensys.net";

    dns.claimNewName(expected);

    uint test1 = 1;
    uint test2 = 2;

    uint[] memory ownedNames = dns.listNamesOwnedBy();
    Assert.equal(
        // expected,
        // dns.getNameByID(ownedNames[0]),
        test1,
        test2,
        "Claimed name should be owned"
    );

    }
}