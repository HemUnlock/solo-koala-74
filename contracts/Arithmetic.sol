
pragma solidity ^0.4.8;

// Arithmetic library
library Arithmetic {
    function mul256By256(uint a, uint b)
        constant
        returns (uint ab32, uint ab1, uint ab0)
    {
        uint ahi = a >> 128;
        uint alo = a & 2**128-1;
        uint bhi = b >> 128;
        uint blo = b & 2**128-1;
        ab0 = alo * blo;
        ab1 = (ab0 >> 128) + (ahi * blo & 2**128-1) + (alo * bhi & 2**128-1);
        ab32 = (ab1 >> 128) + ahi * bhi + (ahi * blo >> 128) + (alo * bhi >> 128);
        ab1 &= 2**128-1;
        ab0 &= 2**128-1;
    }

    // I adapted this from Fast Division of Large Integers by Karl Hasselström
    // Algorithm 3.4: Divide-and-conquer division (3 by 2)
    // Karl got it from Burnikel and Ziegler and the GMP lib implementation