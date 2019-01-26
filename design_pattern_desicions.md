# Design-Pattern-Desicions

## Project goals

For this project I wanted to create a contract that acted as a domain name service. This means users need to be able to 
- claim names
- set the corresponding IP address of their names
- transfer names to other users
- Get information about what names they own and their current state.

## Claiming names
To claim names, I created function "claimNewName". This function allows users to claim names that have not been claimed. a succesful claiming adds a new DomainName Struct to the domainNames mapping, assignes the name a unique integer ID in the "numberToName" mapping, and increments the "numberOfClaimedNames" variable, allowing us to loop over all names later.

## Setting the corresponding IP address of names

function "setNamesIPAddress" takes a name and an IP address, and set's that name struct's corresponding IP address, assuming msg.sender is the owner of that name.
