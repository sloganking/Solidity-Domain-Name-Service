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

    enum OfferState {NotOffering, PrivateOffering, PublicOffering}

    struct DomainName {
        address owner;
        string name;
        string IPAddress;
        OfferState offerState;
        uint OfferPrice;
    }

    uint numberOfClaimedNames;

    //
    // Events - publicize actions to external listeners
    //

    event NewNameClaimed(address accountAddress, string acquiredString);
    event NamesIPAddressChanged(string name, string IPAddress);
    event OwnershipTransfered(string name, address newOwner);

    // 
    // Modifiers
    // 

    modifier ownsName(string memory _name){
        require(domainNames[_name].owner == msg.sender, "You are not this name's owner");
        _;
    }
    modifier notClaimed(string memory _name){
        require(claimed[_name] != true, "Domain name has already been claimed");
        _;
    }
    modifier isClaimed(string memory _name){
        require(claimed[_name] == true, "Domain name not yet been claimed");
        _;
    }
    modifier idExists(uint _id){
        require(_id < numberOfClaimedNames, "Requested ID is higher than current number of claimed names, or less than 0");
        _;
    }

    //
    // Functions
    //

    /** @notice Set the owner to the creator of this contract */
    constructor() public {
        owner = msg.sender;
        numberOfClaimedNames = 0;
    }

    /** @notice Gives msg.sender ownership of Domain Name if it's unclaimed
        @param _name name of the domain which is attempting to be claimed
     */
    function claimNewName(string memory _name)
        public
        notClaimed(_name)
    {
        claimed[_name] = true;
        numberOfClaimedNames++;
        numberToName[numberOfClaimedNames] = _name;
        domainNames[_name].owner = msg.sender;
        domainNames[_name].name = _name;
        domainNames[_name].offerState = OfferState.NotOffering;
        ownerNameCount[msg.sender]++;   
        emit NewNameClaimed(msg.sender, _name);
    }

    /** @notice Sets name's corresponding IP address.
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

    /** @notice Returns list of uints, corresponding to all of msg.sender's owned Names */
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
        require(count == ownerNameCount[msg.sender], "Internal Error: Number of names retrieved != known owned names");
        return owned;
    }

    /** @notice returns the name of a corresponding ID
        @param _id uint ID which corresponds to a name
    */
    function getNameByID(uint _id)
        external
        view
        idExists(_id)
        returns(string memory)
    {
        return numberToName[_id];
    }

    /** @notice lets msg.sender transfer ownership of one of their names to another address
        @param _name name of the address you are transfering ownership of
        @param _receiver address you are transfering ownership of name to
    */
    function transferOwnershipForFree(string memory _name, address _receiver)
        public
        ownsName(_name)
    {
        domainNames[_name].owner = _receiver;
        ownerNameCount[msg.sender] = ownerNameCount[msg.sender] - 1;
        ownerNameCount[_receiver] = ownerNameCount[_receiver] + 1;
        emit OwnershipTransfered(_name, _receiver);
    }

    /** @notice Sets name to NotOffered for sale
        @param _name Name who's offerStatus is being changed
    */
    function makeNameNotOffered(string memory _name) public
        isClaimed(_name)
        ownsName(_name)
    {
        domainNames[_name].offerState = OfferState.NotOffering;  
    }

    /** @notice offers ownership of a name to specific address in exchange for specified amount of funds.
        @param _name The Name who's ownership is being offered
        @param _address The address who the name is being offered to
        @param _eth The amount of Ether required for transfer of ownership
    */
    function makeNamePrivatlyOffered(string memory _name, address _address, uint _eth) public
        isClaimed(_name)
        ownsName(_name)
    {
        domainNames[_name].offerState = OfferState.NotOffering;     //assure no one can buy while contract changes price
        domainNames[_name].OfferPrice = _eth;
        domainNames[_name].offerState = OfferState.PrivateOffering;
    }

    function acceptPrivateOffer() public
    {

    }

    function makeNamePubliclyOffered() public
    {

    }

    function acceptPublicOffer() public
    {

    }
}
