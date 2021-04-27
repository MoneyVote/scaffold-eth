// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./SetupVoting.sol";

contract TransferEther is SetupVoting {
    
    mapping (address => bool) hasWithdrawn;
    uint amount;

    function buyIn() public payable {
        require(msg.value == super.getVoteValue());
    }

    function withdrawBalance() public payable {
        require(hasWithdrawn[msg.sender] == false);
        hasWithdrawn[msg.sender] = true;
        payable( msg.sender).transfer(amount);
    }

    function calculateWinnings(uint _totalVotes) public{
        uint _contractBal = address(this).balance;
        amount = _contractBal/_totalVotes;
    }

    event Received(address, uint);

    receive () external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback () external payable {

    }
}