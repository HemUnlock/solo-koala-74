
var Exchange = artifacts.require("./Exchange.sol");

contract('Exchange', function(accounts) {
  // it("should put 10000 Exchange in the first account", function() {
  //   return Exchange.deployed().then(function(instance) {
  //     return instance.getBalance.call(accounts[0]);
  //   }).then(function(balance) {
  //     assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
  //   });
  // });
  // it("should call a function that depends on a linked library", function() {
  //   var meta;
  //   var metaCoinBalance;
  //   var metaCoinEthBalance;
  //
  //   return Exchange.deployed().then(function(instance) {
  //     meta = instance;
  //     return meta.getBalance.call(accounts[0]);
  //   }).then(function(outCoinBalance) {
  //     metaCoinBalance = outCoinBalance.toNumber();
  //     return meta.getBalanceInEth.call(accounts[0]);
  //   }).then(function(outCoinBalanceEth) {
  //     metaCoinEthBalance = outCoinBalanceEth.toNumber();
  //   }).then(function() {
  //     assert.equal(metaCoinEthBalance, 2 * metaCoinBalance, "Library function returned unexpected function, linkage may be broken");
  //   });
  // });