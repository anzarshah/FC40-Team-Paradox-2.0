pragma solidity >=0.7.0 <0.9.0;

contract sjbCoin{
     address public creator;
     mapping(address => uint) public balances;
     event sent(address from, address to, uint amount);

     constructor(){
         creator = msg.sender;
     }

     function mint(address reciever, uint amount)public{

         require(msg.sender == creator);
         balances[reciever] += amount;
     }

     error insufficientbalances(uint requested, uint available);

     function send(address reciever, uint amount)public{
         if (amount > balances[msg.sender])
         revert insufficientbalances({
             requested: amount,
             available: balances[msg.sender]
         });
         balances[msg.sender] -= amount;
         balances[reciever] += amount;
         emit sent(msg.sender, reciever, amount);
     }

     


}