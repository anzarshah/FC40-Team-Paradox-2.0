pragma solidity ^0.5.0;


import './RWD.sol';
import './Tether.sol';
contract Coalesce {
    string public name = 'Coalesce';
    address public owner;
    Tether public tether;
    RWD public rwd;

    address[] public stakers;

    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;


constructor(RWD _rwd, Tether _tether)public{

        rwd = _rwd;
        tether = _tether;
        owner = msg.sender;
    }

function depositTokens(uint _amount) public{
    require(_amount > 0, 'amount cannot be 0');

    //transfer tokens to contract address for staking
    tether.transferFrom(msg.sender, address(this), _amount);

    //update staking balance
    stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

    if(!hasStaked[msg.sender]){

        stakers.push(msg.sender);

    }

    //updating staking balancces
      isStaking[msg.sender] = true;
      hasStaked[msg.sender] = true;

}
 function unstakeTokens() public {
		// fetch staking balance
		uint balance = stakingBalance[msg.sender];

		// require amount greter than 0
		require(balance > 0, "staking balance cannot be 0");

		// transfer Mock Dai tokens to this contract for staking
		tether.transfer(msg.sender, balance);

		// reset staking balance
		stakingBalance[msg.sender] = 0;

		// update staking status
		isStaking[msg.sender] = false;
	}

      /*
    function issue() public {
           
           require(msg.sender == owner , 'caller must be owner');

         
          for(uint i = 0; i<stakers.length; i++)

          {

              address recipient = stakers[i];
             uint balance = stakingBalance[recipient] / 9;

            if(balance>0)
            {
                rwd.transfer(recipient, balance);
            }


          }
        
            
             
          
    }

 */
}
    
