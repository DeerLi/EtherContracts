pragma solidity ^0.4.0;

import SafeMath from './zeppelin-solidity/contracts/safeMath.sol';
import Ownable from '/zeppelin-solidity/contracts/ownership/Ownable.sol';
import PullPayment from './zeppelin-solidity/contracts/payment/PullPayment.sol';


/**
 * @title Bonus contract is an experimental contract for distributing bonus
 *
 */
contract Bonus is PullPayment, Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public bonus;

    uint public totalToken;
    uint remainingTokens;
    uint public payTime;
    uint weiPerToken;

    function Bonus(uint _totalToken, uint _payTime){
        require(_totalToken > 0);
        totalTokens = _totalToken;
        remainingTokens = _totalToken;
        payTime = _payTime;
        weiPerToken = this.balance / _totalToken;
    }

    function register(address _member, uint _token)
        onlyOwner
    {
        require(_member != 0 && _token < remainingTokens);

        bonus[_member] = _token;
        remainingTokens -= _token;
    }

    /**
     * @dev Called by the employee to claim the bonus. The caller must be registered. Transaction can be done
     *  only after a specific time.
     */
    function claimBonus()
        onlyAfter
    {
        address _member = msg.sender;

        require(bonus[_member] != 0 && this.balance > 0);

        payment = weiPerToken * bonus[_member];
        bonus[_member] = 0;

        assert(_member.send(payments));
    }

}
