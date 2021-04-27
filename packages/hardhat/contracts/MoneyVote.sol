// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./SetupVoting.sol";

import "./TransferEther.sol";

contract MoneyVote is SetupVoting{
    /* mapping field below is equivalent to an associative array or hash.
    The key of the mapping is candidate name stored as type bytes32 and value is
    an unsigned integer to store the vote count
    */

    //SetupVoting public setupVoting;

    struct Voter {
        bool voted;
        bool withdrawn;
        bytes32 votedFor;
    }

    struct Candidate {
        bytes32 name;
        uint totalVotes;
    }

    uint winner;

    mapping (address => Voter) public voters;

    /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
    We will use an array of bytes32 instead to store the list of candidates
    */

    Candidate[] public candidateList;

    /* This is the constructor which will be called once when you
    deploy the contract to the blockchain. When we deploy the contract,
    we will pass an array of candidates who will be contesting in the election
    */
    constructor(bytes32[] memory _candidateNames, uint _endTime, uint8 _buyInValue) {
        //console.log("in Voting Dapp constructor");
        for (uint i = 0; i < _candidateNames.length; i++) {
            candidateList.push(Candidate({
                name: _candidateNames[i],
                totalVotes: 0
            }));
        }
        super.setVoteValue(_buyInValue);
        super.setEndTime(_endTime);
    }

    function findWinner() public {
        uint _maxVotes = 0;
        uint _winner;
        for (uint i = 0; i < candidateList.length; i++) {
            uint _currentVotes = candidateList[i].totalVotes;
            if (_currentVotes > _maxVotes) {
                _maxVotes = _currentVotes;
                _winner = i;
            }
        }

        winner =  _winner;
    }

    // This function increments the vote count for the specified candidate. This
    // is equivalent to casting a vote
    function voteForCandidate(uint _candidate) public {
        require(validCandidate(candidateList[_candidate].name));
        require(voters[msg.sender].voted == false);
        TransferEther.buyIn();
        candidateList[_candidate].totalVotes += 1;
        voters[msg.sender] = Voter({
            voted: true,
            withdrawn: false,
            votedFor: candidateList[_candidate].name
        });
    }

    function validCandidate(bytes32 _candidate) view public returns (bool) {
        for(uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i].name == _candidate) {
                return true;
            }
        }
        return false;
    }
}
