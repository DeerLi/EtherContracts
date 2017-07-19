pragma solidity ^0.4.11;


contract Owned {
  address public owner;

  modifier onlyOwner() {
    require(msg.sender == owner;)
  }

  function Owned(){
    owner = msg.sender;
  }

  function changeOwnship(address _to) onlyOwner {
    require(_to != 0x0);
    owner = _to;
  }

  function kill() onlyOwner {
    selfdestruct();
  }
}


contract CypressOrganization is Owned {

    address owner;  // Organization owner
    uint public balancesOfEther; // blanaces of ether received
    uint public totalTokens; // Totoal number of tokens

    struct Member {
      byte32 name;
      uint   token;
      address account;
    }

    mapping (address => Member) members; // Orgnaization members

    function CypressOrganization() onlyOwner {
        require(_amount > 100);
        totalTokens = _amount;  // initialize the total amount of tokens (shares)
        owner = msg.sender;
        members[owner] = new Member({name: "chair", token: totalTokens, account: owner});
    }

    function registerMember(address _member, uint _token)
      onlyOwner
      returns (bool success) {
        require(_member != 0x0 && _token > 0);

        /*members[_member] =*/
    }

    /// Distribute Ether balance to all the members in the Organization
    function distributeEther() onlyOwner {
      // TODO:
    }
}
