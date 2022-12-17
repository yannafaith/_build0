// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaveCnt;
    struct Wave  {
        address sender;
        string message;
    }

    Wave wave = Wave(msg.sender,"Hello World");

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function newWave() public {
        totalWaveCnt += 1;
        console.log("%d has waved and sent message %s!", wave.sender, wave.message);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaveCnt);
        return totalWaveCnt;
    }
}