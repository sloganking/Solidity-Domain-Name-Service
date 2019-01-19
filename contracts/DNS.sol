pragma solidity ^0.5.0;
contract DNS {

    //
    // State variables
    //

    address public owner;

    mapping (string => bool) private claimed;
    mapping (string => DomainName ) domainNames;

    struct DomainName {
        address owner;
        string name;
        string IPAddress;
    }

    //
    // Events - publicize actions to external listeners
    //

    event NewNameClaimed(address accountAddress, string acquiredString);
    event NamesIPAddressChanged(string name, string IPAddress);

    //
    // Functions
    //

    /** @dev Set the owner to the creator of this contract */
    constructor() public {
        owner = msg.sender;
    }

    /** @dev Gives msg.sender ownership of Domain Name if it's unclaimed
        @param _name name of the domain which is attempting to be claimed
     */
    function claimNewName(string memory _name) public {
        require(claimed[_name] != true, "Domain name has already been claimed");
        claimed[_name] = true;
        domainNames[_name].name = _name;
        domainNames[_name].owner = msg.sender;
        emit NewNameClaimed(msg.sender, _name);
    }

    /** @dev Sets name's corresponding IP address.
        @param _name Name which is having it's corresponding IP address set.
        @param _address IP Address which will be stored under specified name.
     */
    function setNamesIPAddress(string memory _name, string memory _address) public {
        require(claimed[_name] == true, "Domain Name has not yet been claimed");
        require(domainNames[_name].owner == msg.sender, "You are not this name's owner");
        //require(keccak256(domainNames[_name].IPAddress) != keccak256(_address), "This name already has that IPAddress");
        domainNames[_name].IPAddress = _address;
        emit NamesIPAddressChanged(_name, _address);
    }
}
