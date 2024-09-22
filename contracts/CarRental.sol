//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Escrow.sol";

contract CarRental {
    address public owner;
    mapping (address => Escrow) public escrows;

    constructor() {
        owner = msg.sender;
    }

    function rentCar(address _buyer, uint _amount) public {
        require(msg.sender == owner, "Only owner can rent car");
        Escrow escrow = new Escrow(_buyer, owner, _amount);
        escrows[_buyer] = escrow;
    }

    function confirmCarReceived(address _buyer) public {
        require(msg.sender == _buyer, "Only buyer can confirm");
        Escrow escrow = escrows[_buyer];
        escrow.confirmCarReceived();
    }

    function sendAmountToSeller(address _buyer) public {
        Escrow escrow = escrows[_buyer];
        escrow.sendAmountToSeller();
    }

    function sendAmountBackToBuyer(address _buyer) public {
        Escrow escrow = escrows[_buyer];
        escrow.sendAmountBackToBuyer();
    }
}