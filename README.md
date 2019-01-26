# Solidity-Domain-Name-Service

## What does this project do?

This project runs a smart contract using Solidity which allows users to:
- claim Domain Names
- Set a Domain Name's corresponding IP address
- Read a Domain Name's corresponding IP address
- Transfer ownership of Domain Names to other users
  - For Free
  - Priavatly (transfer ownership to specific address in exchange for funds)
  - Publicly (transfer ownership to any address in exchange for funds)

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
$ ganache-cli
```

This will start a private development blockchain on your machine. It is set up to be connected to through 127.0.0.1:8545

### Compile and migrate project smart contracts

In this project's file directory run 

```Bash
$ truffle compile
```

and

```Bash
$ truffle migrate
```

This will have compiled and moved our smart contracts to our local development blockchain.
