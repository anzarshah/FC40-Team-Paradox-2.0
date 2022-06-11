const Coalesce = artifacts.require('Coalesce');

module.exports =  function issueRewards(callback){

    let coalesce =  Coalesce.deployed()
    Coalesce.issueToken();
    console.log('Tokens have been issueed successfully')
    callback()
}