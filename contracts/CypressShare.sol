pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

//contract Owned {
//  address public owner;
//
//  modifier onlyOwner() {
//    require(msg.sender == owner);
//    _;
//  }
//
//  function Owned(){
//    owner = msg.sender;
//  }
//
//  function changeOwnship(address _to) onlyOwner {
//    require(_to != 0x0);
//    owner = _to;
//  }
//
//  function kill() onlyOwner {
//    selfdestruct(owner);
//  }
//}


contract CypressOrganization is Ownable {

    address owner;  // Organization owner
    uint public creationTime; // The contract organization creation time.
    uint public balancesOfEther; // balances of ether received
    uint public totalTokens; // Total supply of Tokens

    struct Member {
      bytes name;
      uint   token;
      address account;
    }

    /// Keep record of registered account
    mapping(address => bool) registered;

    Member[] members;   // Organization members
    uint totalMembers;  //total number of members


    /// Guard the transition after a specific time
    modifier onlyAfter(uint _time) {
        require(now >= _time);
        _;
    }


    function CypressOrganization(bytes _name, uint _amount) onlyOwner payable {
        require(_amount > 100);
        totalTokens = _amount;  // initialize the total amount of tokens (shares)
        balancesOfEther = msg.value;    // the contract Ether balance
        owner = msg.sender;
        members.push(Member({
            name: _name,
            account: owner,
            token: _amount
        }));
        registered[owner] = true;
        totalMembers = 1;
        creationTime = now;
    }

    ///
    function isRegistered(address _account) constant returns (bool yes) {
//        if (registered[_account].length == 0) return false;
        return registered[_account];
    }


    /// Get the contract account Ether balance
    function getBalances() constant returns(uint balance) {
        return balancesOfEther;
    }

    /// Register a member, assign tokens to him.
    function registerMember(address _member, bytes _name, uint _token)
      onlyOwner
      returns (bool success) {
        // validate the input parameter
        require(_member != 0x0 && _token > 0);
        // check if the member is already registered
        require(!isRegistered(_member));

        // check if there is enough tokens to assign to the member.
        require(members[0].token > _token);

        members.push(Member({name: _name, token: _token, account: _member}));
        members[0].token -= _token;

        totalMembers += 1;

        registered[_member] = true;
        return true;
    }

    /// Distribute Ether balance to all the members in the Organization
    function distributeEther() onlyOwner returns (bool success){
      // TODO:

        return true;
    }
}
