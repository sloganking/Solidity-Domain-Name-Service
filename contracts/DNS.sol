pragma solidity ^0.4.21;
contract SimpleBank {

    //
    // State variables
    //

    address public owner;

    mapping (address => string) private domainNames;

    //
    // Events - publicize actions to external listeners
    //

    event NameAcquired(address accountAddress, string acquiredString);

    //
    // Functions
    //

    constructor() public {
        /* Set the owner to the creator of this contract */
        owner = msg.sender;
    }

}