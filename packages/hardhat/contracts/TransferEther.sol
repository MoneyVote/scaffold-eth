// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./SetupVoting.sol";
import "./MoneyVote.sol";

contract TransferEther {

    SetupVoting public setupVoting;
    MoneyVote public moneyVote;

    uint amount;

    function buyIn() public payable {
        require(msg.value == setupVoting.getVoteValue());
    }

    function withdrawBalance() public payable {
        require(block.timestamp > setupVoting.endTime(), "Voting still in progress.");
        require(moneyVote.getWithdrawn(msg.sender) == false);
        require(moneyVote.getVotedFor(msg.sender) == moneyVote.getWinnerName());
        moneyVote.setWithdrawnTrue(msg.sender);
        payable(msg.sender).transfer(amount);
    }

    function calculateWinnings() public {
        require(block.timestamp > setupVoting.endTime(), "Voting still in progress.");
        uint _votes = moneyVote.getWinnerVotes();
        uint _contractBal = address(this).balance;
        amount = _contractBal/_votes;
    }

    event Received(address, uint);

    receive () external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback () external payable {

    }
}