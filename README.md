# Solidity-Domain-Name-Service

## What does this project do?

This project runs a smart contract using Solidity which allows users to:
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

## Project requirements
### Completed requirements

- A project README.md that explains your project
- Your project should be a truffle project
- Smart Contract code should be commented according to the specs in the documentation

### Incomplete requirments

- Create at least 5 tests for each smart contract
- A development server to serve the front end interface of the application
- Finish design_pattern_desicions.md
- Finish avoiding_common_attacks.md
- Implement/ use a library or an EthPM package in your project

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

### Run front end application

To start the front end application, go to the app/ folder

```Bash
cd app/
```

and run

```Bash
npm run dev
```
