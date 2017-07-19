# EtherContracts
This is a Ethereum smart contracts test project. In this project we build some smart contracts to demostrate an automated Ether/Token distribution DApp.

# Development Tools

We use [Truffle](https://github.com/trufflesuit/truffle) and [TestRPC](https://github.com/ethereumjs/testrpc) as the compile tools.
`zeppelin-solidity` is a library of writing Ethereum SmartContracts.
In Ubuntu environment, install the tools using the following commands:

```
npm install -g ethereumjs-testrpc truffle zeppelin-solidity
```

# Compile and Test the contract

## Create the project 

```
truffle init
```
Write the contract `.sol` file in the `contracts` directory.


## Compile the project

```
truffle compile
```


## Deploy and test the project

1. Run a test local blockchain network by `TestRPC`
```
testrpc -a 10 --debug
```

2. Change the deploy javascript file: 
```js

```


3. deploy the contract
```
truffle migrate --reset
truffle console
```

 

