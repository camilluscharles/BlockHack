//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address public seller;
    uint public amount;
    bool public carReceived;

    constructor(address _buyer, address _seller, uint _amount) {
        buyer = _buyer;
        seller = _seller;
        amount = _amount;
        carReceived = false;
    }

    function sendAmountToSeller() public {
        require(carReceived, "Car has not been received");
        payable(seller).transfer(amount);
    }

    function sendAmountBackToBuyer() public {
        require(!carReceived, "Car has been received");
        payable(buyer).transfer(amount);
    }

    function confirmCarReceived() public {
        require(msg.sender == buyer, "Only buyer can confirm");
        carReceived = true;
    }
}