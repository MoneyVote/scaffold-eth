// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Ownable.sol";

contract SetupVoting is Ownable {

    uint8 public voteValue;
    uint public endTime;

    function setVoteValue(uint8 _value) public onlyOwner {
        voteValue = _value;
    }

    function setEndTime(uint _endTime) public onlyOwner {
        endTime = _endTime;
    }

    function getVoteValue() public view returns (uint8) {
        return voteValue;
    }

}