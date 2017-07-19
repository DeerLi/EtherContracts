# Purpose of this contract

This contract is created to distribute Ether in the Cypress Ether group.

# Basic ideas

A Cypress Organization contract is created. Owner of this contract can register members of the organization. When the organization is created,
an initial amount of token (1000) is created and assigned to the owner. A member will be allocated a certain amount of tokens when the
member is registered. The cypress organization contract has an Ether receiving function and a function to execute a `distributeEther` function,
which will transfer a certain amount of Ether to each member's account. Member's receiving amount is determined by the total amount of Ether
in the main contract and the member's token share.

## Cypress Organization Contract
