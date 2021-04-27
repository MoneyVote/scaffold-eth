// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TransferEther {
    mapping (address => uint256) userBalance;

    function buyIn(address _user) public {

    }

    function withdrawBalance() public payable {
        uint _amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
       payable( msg.sender).transfer(_amount);
    }

    event Received(address, uint);

    receive () external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback () exnternal payable {
        
    }
}