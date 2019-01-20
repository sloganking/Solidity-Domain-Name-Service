pragma solidity ^0.5.0;
contract DNS {

    //
    // State variables
    //

    address public owner;

    mapping (address => uint) ownerNameCount;   //number of names in existance
    mapping (uint => string) numberToName;   //(used to sort through all names)
    mapping (string => DomainName) domainNames; //gets name items from name
    mapping (string => bool) private claimed;   //stors wether a name has been claimed yet

    struct DomainName {
        address owner;
        string name;
        string IPAddress;
    }

    uint numberOfClaimedNames;

    //
    // Events - publicize actions to external listeners
    //

    event NewNameClaimed(address accountAddress, string acquiredString);
    event NamesIPAddressChanged(string name, string IPAddress);
    event OwnershipTransfered(string name, address newOwner);

    // 
    // Modifieers
    // 

    modifier ownsName(string memory _name){
        require(domainNames[_name].owner == msg.sender, "You are not this name's owner");
        _;
    }
    modifier isClaimed(string memory _name){
        require(claimed[_name] != true, "Domain name has already been claimed");
        _;
    }
    modifier idExists(uint _id){
        require(_id < numberOfClaimedNames, "Requested ID is higher than current number of claimed names");
        _;
    }

    //
    // Functions
    //

    /** @dev Set the owner to the creator of this contract */
    constructor() public {
        owner = msg.sender;
        numberOfClaimedNames = 0;
    }

    /** @dev Gives msg.sender ownership of Domain Name if it's unclaimed
        @param _name name of the domain which is attempting to be claimed
     */
    function claimNewName(string memory _name)
        public
        isClaimed(_name)
    {
        numberToName[numberOfClaimedNames] = _name;
        numberOfClaimedNames++;
        claimed[_name] = true;
        domainNames[_name].name = _name;
        domainNames[_name].owner = msg.sender;
        ownerNameCount[msg.sender]++;   
        emit NewNameClaimed(msg.sender, _name);
    }

    /** @dev Sets name's corresponding IP address.
        @param _name Name which is having it's corresponding IP address set.
        @param _address IP Address which will be stored under specified name.
     */
    function setNamesIPAddress(string memory _name, string memory _address)
        public
        isClaimed(_name)
        ownsName(_name)
    {
        domainNames[_name].IPAddress = _address;
        emit NamesIPAddressChanged(_name, _address);
    }

    /** @dev Returns list of uints, corresponding to all of msg.sender's owned Names */
    function listNamesOwnedBy()
        external
        view
        returns(uint[] memory)
    {
        uint[] memory owned = new uint[](ownerNameCount[msg.sender]);
        uint count = 0;
        for(uint i = 0; i < numberOfClaimedNames; i++){
            if(domainNames[numberToName[i]].owner == msg.sender){
                owned[count] = i;
                count++;
            }
        }
        return owned;
    }

    function getNameByID(uint ID)
        external
        view
        idExists(ID)
        returns(string memory)
    {
        return numberToName[ID];
    }

    function transferOwnershipForFree(string memory _name, address _receiver)
        public
        ownsName(_name)
    {
        domainNames[_name].owner = _receiver;
        ownerNameCount[msg.sender] = ownerNameCount[msg.sender]--;
        ownerNameCount[_receiver] = ownerNameCount[_receiver]++;
        emit OwnershipTransfered(_name, _receiver);
    }
}
