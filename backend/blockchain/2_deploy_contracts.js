const Tether = artifacts.require('Tether.sol')
const RWD = artifacts.require('RWD.sol')
const Coalesce  = artifacts.require('Coalesce.sol')

module.exports =  function (deployer,accounts){
//deploy mock tether contract
  deployer.deploy(Tether)
  const tether = Tether.deployed()

 // deploy reward conytract
    deployer.deploy(RWD)
    const rwd = RWD.deployed()

// //deploy colasence - bank 
     deployer.deploy(Coalesce, rwd.address, tether.address)
     const coalesce =  Coalesce.deployed()

// transfer all reward coins to colasce
     rwd.transfer(coalesce.address , '100000000000000000000000')

//distribute 100 tether tokens to investirs 

     tether.transfer(accounts[1],'100000000000000000')



    
};