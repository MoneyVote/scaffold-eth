// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./SetupVoting.sol";

contract MoneyVote {
    /* mapping field below is equivalent to an associative array or hash.
    The key of the mapping is candidate name stored as type bytes32 and value is
    an unsigned integer to store the vote count
    */

    SetupVoting public setupVoting;

    mapping (bytes32 => uint256) public votesReceived;

    mapping (address => bool) public hasVoted;

    /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
    We will use an array of bytes32 instead to store the list of candidates
    */

    bytes32[] public candidateList;

    /* This is the constructor which will be called once when you
    deploy the contract to the blockchain. When we deploy the contract,
    we will pass an array of candidates who will be contesting in the election
    */
    constructor(bytes32[] memory _candidateNames, uint _endTime, unit8 _buyInValue) {
        //console.log("in Voting Dapp constructor");
        candidateList = _candidateNames;
        setupVoting.setVoteValue(_buyInValue);
        setupVoting.setEndTime(_endTime);

    }

    // This function returns the total votes a candidate has received so far
    function totalVotesFor(bytes32 _candidate) view public returns (uint256) {
        require(validCandidate(candidate));
        return votesReceived[candidate];
    }

    // This function increments the vote count for the specified candidate. This
    // is equivalent to casting a vote
    function voteForCandidate(bytes32 _candidate) public {
        require(validCandidate(_candidate));
        require(hasVoted[msg.sender] == false);
        votesReceived[_candidate] += 1;
        hasVoted[msg.sender] = true;
    }

    function validCandidate(bytes32 _candidate) view public returns (bool) {
        for(uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == _candidate) {
                return true;
            }
        }
        return false;
    }
}
