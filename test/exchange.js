
var Exchange = artifacts.require("./Exchange.sol");

contract('Exchange', function(accounts) {
  // it("should put 10000 Exchange in the first account", function() {
  //   return Exchange.deployed().then(function(instance) {
  //     return instance.getBalance.call(accounts[0]);
  //   }).then(function(balance) {