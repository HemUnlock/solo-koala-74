
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
    function div256_128By256(uint a21, uint a0, uint b)
        constant
        returns (uint q, uint r)
    {
        uint qhi = (a21 / b) << 128;
        a21 %= b;

        uint shift = 0;
        while(b >> shift > 0) shift++;
        shift = 256 - shift;
        a21 = (a21 << shift) + (shift > 128 ? a0 << (shift - 128) : a0 >> (128 - shift));
        a0 = (a0 << shift) & 2**128-1;
        b <<= shift;
        var (b1, b0) = (b >> 128, b & 2**128-1);

        uint rhi;
        if(a21 >> 128 < b1) {
            q = a21 / b1;
            rhi = a21 % b1;