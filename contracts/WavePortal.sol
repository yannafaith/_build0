// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave  {
        address sender;
        string message;
        uint256 timestamp;
    }

    uint256 totalWaveCnt;
    uint256 private seed;
    Wave[] waves;

    /*
 * This is an address => uint mapping, meaning I can associate an address with a number!
 * In this case, I'll be storing the address with the last time the user waved at us.
 */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function newWave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        lastWavedAt[msg.sender] = block.timestamp;


        totalWaveCnt += 1;
        waves.push(Wave(msg.sender, _message, block.timestamp));
        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 50) {
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            console.log("%s won %k!", msg.sender, prizeAmount);
            require(success, "Failed to withdraw money from contract.");
        }
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaveCnt;
    }
}