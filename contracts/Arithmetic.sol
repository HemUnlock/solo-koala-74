
pragma solidity ^0.4.8;

// Arithmetic library
library Arithmetic {
    function mul256By256(uint a, uint b)
        constant
        returns (uint ab32, uint ab1, uint ab0)