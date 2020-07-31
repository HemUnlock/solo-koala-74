
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
    mapping (bytes32 => Exchange) exchanges;

    // Exchange structure
    struct Exchange {
        address[2] tokens; // token pair in exchange
        uint[2] supplies;  // amount held by exchange of each token type
        uint[2] lastPricePoint;
        uint lastUpdateTimestamp;
    }

    /// @param exchangeIdentifier The ID of the exchange
    /// @return tokens The addresses of the tokens handled by the requested exchange
    /// @return supplies How much of each of the currencies the exchange holds for providing liquidity
    function getExchange(bytes32 exchangeIdentifier)
        constant
        returns (address[2] tokens, uint[2] supplies)
    {
        Exchange ex = exchanges[exchangeIdentifier];
        tokens = ex.tokens;
        supplies = ex.supplies;
    }

    /// @param exchangeIdentifier The ID of the exchange
    /// @return A pair that indicates price
    function getPricePoint(bytes32 exchangeIdentifier)
        constant
        returns (uint[2])
    {
        Exchange ex = exchanges[exchangeIdentifier];
        uint param = 0;
        if(now > ex.lastUpdateTimestamp + priceLockDuration)
            param = now - ex.lastUpdateTimestamp - priceLockDuration;
            if(param > priceRampDuration)
                param = priceRampDuration;

        return [
            Arithmetic.overflowResistantFraction((ex.supplies[0] - ex.lastPricePoint[0]), param, priceRampDuration) + ex.lastPricePoint[0],
            Arithmetic.overflowResistantFraction((ex.supplies[1] - ex.lastPricePoint[1]), param, priceRampDuration) + ex.lastPricePoint[1]
        ];
    }

    /// @notice Send amount `supplies[i]` of token `tokens[i]` to this contract to create exchange for token pair
    /// @param tokens The token pair to be handled by the exchange