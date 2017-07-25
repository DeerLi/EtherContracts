# Bonus Contract

The `Bonus` contract is a simple smart contract for distributing some bonus in the form of 
ethereum to an owner specified group. One can create a `Bonus` contract and send some ether
to this contract. The person who creates this contract becomes the owner of this contract, 
he/she can then register people who will receive the distributed bonus. After a certain point
of time, which is specified during the creation of contract, people can claim their bonus.
 
 
The following is an example of using `Bonus` contract in `truffle` suite:

## Preparation
Prerequisites of running this project:
```bash
npm install
alias truffle=$(pwd)/node_modules/truffle/build/cli.bundled.js
truffle init
truffle compile
``` 

## Change deployed contract
Change the `migrations/2_deploy_contracts.js` file to, suppose we have 100 total tokens and 
people can claim their bonus 5 minutes after the creation:
```
var Bonus = artifacts.require('./Bonus.sol')

module.exports = function(deployer) {
    deployer(Bonus, 100, 300)
};
```

## Deploy a Bonus contract
We use the test local blockchain by `testrpc`. In one console, run the `testrpc` by
```bash
testrpc
```

## Interact with the contract
In another console, we use `truffle` console to interact with the test blockchain.
```bash
truffle console
> var bonus
> Bonus.deployed().then(function(inst){bonus = inst; console.log(inst.address)});

> account1 = web3.eth.accounts[0]

> account2 = web3.eth.accounts[1]

> account3 = web3.eth.accounts[2]

// check the owner's balance
> web3.eth.getBalance(account1)

// check the bonus contract's balance
> web3.eth.getBalance(bonus.address)

// send some ether from the owner of this contract (account1 by default)
> web3.eth.sendTransaction({from:acc1, to:bonus.address, value: web3.toWei(1, 'ether')})

// register account2 to receive bonus, e.g. 10% of the share
> bonus.register(account2, 10)

// Check account2's entitled bonus amount in ether
> bonus.getMemberBonus(account2)

// Account2 claim bonus
> bonus.claim({from: account2})

// Check Account2's balance
> web3.eth.getBalance(account2)
// You should see 0.1 ether being added to account2's balance
```


