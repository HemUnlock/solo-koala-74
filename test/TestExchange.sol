pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "tokens/StandardToken.sol";
import "../contracts/Exchange.sol";
import "../contracts/Arithmetic.sol";

contract TestExchange {
    using Assert for *;

    function testExchangePairIdentifiersSymmetric() {
        address toka = address(new StandardToken());
        address tokb = address(new StandardToken());
     