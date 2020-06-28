
pragma solidity ^0.4.8;

import "tokens/Token.sol"; // Use audited ERC20 interface
import "./Arithmetic.sol";

/// @title Currency exchange backed by holdings
contract Exchange {
    // Duration of price ramp
    uint constant priceRampDuration = 24 * 60 * 60;
    // Duration of price lock (See: http://ethereum.stackexchange.com/a/6796)
    uint constant priceLockDuration = 15 * 60;

    // A mapping from exchange identifiers to their corresponding Exchange struct instances