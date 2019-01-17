pragma solidity ^0.5.0;
contract SimpleBank {

    //
    // State variables
    //

    address public owner;

    mapping (address => string) private domainNames;
    mapping (string => bool) private claimed;
    mapping (string => string) private ipAddresses;

    //
    // Events - publicize actions to external listeners
    //

    event NewNameClaimed(address accountAddress, string acquiredString);

    //
    // Functions
    //

    constructor() public {
        /* Set the owner to the creator of this contract */
        owner = msg.sender;
    }

    function claimNewName(string memory _name) public {
        require(claimed[_name] != true, "Domain name has already been claimed");
        domainNames[msg.sender] = _name;
        emit NewNameClaimed(msg.sender, _name);
    }
}
