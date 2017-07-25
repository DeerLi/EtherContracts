# EtherContracts
This is a Ethereum smart contracts test project. In this project we build some smart contracts to demostrate an automated Ether/Token distribution DApp.

# Development Tools

We use [Truffle](https://github.com/trufflesuit/truffle) and [TestRPC](https://github.com/ethereumjs/testrpc) as the compile tools.
`zeppelin-solidity` is a library of writing Ethereum SmartContracts.
In Ubuntu environment, install the tools using the following commands:

```
npm install -g ethereumjs-testrpc truffle
```

# Compile and Test the contract

## Create the project 
Use Truffle package to create the basic project structure:
```
truffle init
npm install zeppelin-solidity
```
Write the contract `.sol` file in the `contracts` directory.

Note: 

1. create a symbol link to point to the `zeppelin-solidity` contracts.
```bash
cd contracts; ln -s ../node_modules/zeppelin-solidity .
```
2. import the zeppelin-solidity contracts in  


## Compile the project

```bash
truffle compile
```


## Deploy and test the project

1. Run a test local blockchain network by `TestRPC`
```bash
testrpc -a 10 --debug
```

2. Change the deploy javascript file `2_deploy_contract.js`, for example,
```
var HelloWorld = artifacts.require('./HelloWorld.sol');

module.exports = function(deployer) {
    deployer.deploy(HelloWorld);
};
```
The code above will deploy a `HelloWorld` contract instance when do `truffle migrate`.

3. deploy the contract
```bash
truffle migrate --reset
truffle console
```

4. in the truffle console, there is `web3.eth` objects embedded which can be used to access 10 accounts created by `testrpc`. Those default accounts have some ether that can be spent and transferred. Using the `HelloWorld` contract as an example:
```
> web3.eth.accounts
[ '0xa85813b27c4edf598b6fe78970d65ae102e8ac82',
  '0x5f718320f434fb2b9a8f633ca26e7d852721e65d',
  '0xc79c819df5f331c8390ac5ab7157ebfa793e23ba',
  '0xcffe9fb0375c26322788332349fa3cf734d03976',
  '0x1f07cbe6c698973b054bfd2d1a8969a385ed5916',
  '0xe222b26fad85bb2e224443f464c2d748c2a0433b',
  '0x5cce2b35cad2019aa79e346e21a74476134ba8e6',
  '0xf7c0e3ae847585f4c9f3f94eb1c1d2cda62160f3',
  '0xb0b9d4dcb8bb13b696735f7bfa698a2a7d4a1443',
  '0x5c5c943cdec3387379344df10265c5e78336b0de' ]
> account1 = web3.eth.accounts[0]

> var helleWorld;
> HelloWorld.deployed().then(function(v){ helloWorld = v; })
> helloWorld.address

> web3.eth.getBalance(account1);
{ [String: '99843556399999928949'] s: 1, e: 19, c: [ 998435, 56399999928949 ] }

//transfer some ether from account1 to account2
> web3.eth.sendTransaction({from:acc1, to:web3.eth.accounts[1], value: web3.toWei(1, "ether)});

// get the balance of the account2
> web3.eth.getBalance(web3.eth.accounts[1]);

// transfer some ether from account1 to the helloworld contract
> web3.eth.sendTransaction({from:acc1, to:helloWorld.address, value: web3.toWei(1, "ether")});

> web3.eth.getBalance(helloWorld.address)

```
 

 

