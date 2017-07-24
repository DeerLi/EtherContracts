pragma solidity ^0.4.11;

import {SafeMath} from './zeppelin-solidity/contracts/math/SafeMath.sol';
import {Ownable} from './zeppelin-solidity/contracts/ownership/Ownable.sol';
import {PullPayment} from './zeppelin-solidity/contracts/payment/PullPayment.sol';


/**
 * @title Bonus contract is an experimental contract for distributing bonus
 *
 */
contract Bonus is PullPayment, Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public bonus;

    uint public totalTokens;
    uint remainingTokens;
    uint weiPerToken;
    uint public effectiveAfter;

    modifier onlyAfter() {
      require(effectiveAfter < now);
      _;
    }

    function Bonus(uint _totalToken, uint _payTime){
        require(_totalToken > 0);
        totalTokens = _totalToken;
        remainingTokens = _totalToken;
        effectiveAfter = _payTime;
        weiPerToken = this.balance / _totalToken;
    }

    // Fallback function, it allows others send ether to this contract
    function () payable {}

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
        //onlyAfter
    {
        address _member = msg.sender;

        require(bonus[_member] != 0 && this.balance > 0);

        uint payment = weiPerToken * bonus[_member];
        bonus[_member] = 0;   // the payment has been claimed, reset the value to 0

        assert(_member.send(payment));
    }
}
