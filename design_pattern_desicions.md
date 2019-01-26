# Design-Pattern-Desicions

## Project goals

For this project I wanted to create a contract that acted as a domain name service. This means users need to be able to 

## Claim names
To claim names, I created function "claimNewName". This function allows users to claim names that have not been claimed. a succesful claiming adds a new DomainName Struct to the domainNames mapping, assignes the name a unique integer ID in the "numberToName" mapping, and increments the "numberOfClaimedNames" variable, allowing us to loop over all names later.

## Set the corresponding IP address of names

function "setNamesIPAddress" takes a name and an IP address, and set's that name struct's corresponding IP address, assuming msg.sender is the owner of that name.

## Transfer names to other users

There are three methods of transfering ownership of names:

### ForFree

Transfers ownership of a name to a specified address

### Publicly

Offers ownership of a name for specified amount of Wei. Any address can accept this offer and gain ownership of the offered name, provided they pay the required Wei.

### Privately

Offers ownership of a name to a specified user for a specified amount of Wei. Only the specified user can take ownership of the privately offered name, provided they pay the requested Wei.

### Additional information

Users can also revoke offers if they decide to before the offer has been fulfilled.

## Get information about what names they own and their current state.
