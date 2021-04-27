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
        require(moneyVote.voters(msg.sender).withdrawn == false);
        require(moneyVote.voters(msg.sender).votedFor == moneyVote.candidateList(moneyVote.winner).name);
        moneyVote.voters(msg.sender).withdrawn = true;
        payable(msg.sender).transfer(amount);
    }

    function calculateWinnings() public{
        uint _votes = moneyVote.candidateList[moneyVote.winner].totalVotes;
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