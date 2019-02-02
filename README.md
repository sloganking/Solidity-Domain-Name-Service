# Solidity-Domain-Name-Service

## What does this project do?

This project runs a smart contract made in Solidity which allows users to:
- claim Domain Names
- Set a Domain Name's corresponding IP address
- Read a Domain Name's corresponding IP address
- Retrieve a list of user's owned Domain Names
- Transfer ownership of Domain Names to other users for free
- Offer ownership of Domain Names for specified price
  - Publicly (transfer ownership to any address in exchange for funds)
  - Privately (transfer ownership to specific address in exchange for funds)
- Accept offers of Domain Names (Payable)
  - Public
  - Private

A web page front end allows users to interact with the smart contract (Currently a work in progress)

## How to set it up

### Install Truffle

```Bash
npm install -g truffle
```

### Install Ganache-cli

Using npm:

```Bash
npm install -g ganache-cli
```

or, if you are using [Yarn](https://yarnpkg.com/):

```Bash
yarn global add ganache-cli
```
### Run Ganache-cli

```Bash
ganache-cli
```

This will start a private development blockchain on your machine. It is set up to be connected to through 127.0.0.1:8545

### Compile and migrate project smart contracts

Open a new command line in this project's file directory and run 

```Bash
truffle compile
```

and

```Bash
truffle migrate
```

This will have compiled and moved our smart contracts to our local development blockchain.

[Save the address of your deployed DNS contract](https://i.imgur.com/i9WtZ1G.png) as you will need it later.

### Run front end application

To start the front end application, go to the app/ folder

```Bash
cd app/
```

install all project dependancies. (only needs to be done once)

```Bash
npm i
```

Give index.html (located in app/) our deployed contract's address by opening it and replacing the address [on line 51](https://i.imgur.com/YB7Fp9A.png) with the address of our newly deployed DNS contract given to us earlier by ganache-cli

Now manually open index.html and the project's front end application will load into your default browser

For assistance with program evaluateion, please read the notice below.

## Notice

- Front end application for this project does not yet allow users to use all available smart contract functions.
- Problem: front end successfuly calls contract funtions but claimNewName() currently fails due to web3's default gasLimit.
- Workaround: it is possible to deploy the contract's to the local ganache blockchain through remix, and call claimNewNames() using Remix. This will put claimedNames in the contract. One can then call the other functions of this project's front end (index.html) (remember to link contract address) to verify that they successfuly interact with the contract.
- Here is a [video going through the instructions above.](https://streamable.com/v8wj5)
- Any Contract functions not yet exposed by this project's front end can be readily tested using the environment found at https://remix.ethereum.org
