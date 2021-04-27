// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./SetupVoting.sol";

contract TransferEther is SetupVoting {
    mapping (address => uint256) userBalance;

    function buyIn() public payable {
        require(msg.value == super.getVoteValue());
    }

    function withdrawBalance() public payable {
        uint _amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
       payable( msg.sender).transfer(_amount);
    }

    function calculateWinnings() public {
        
    }

    event Received(address, uint);

    receive () external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback () external payable {

    }
}