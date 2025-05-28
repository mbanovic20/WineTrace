// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./WineTrace.sol";

contract WineTraceFactory {
    address[] public wineContracts;

    event WineTraceCreated(address indexed wineContract, address indexed owner);

    function createWineTrace(
        string memory _grapeType,
        string memory _harvestYear,
        uint _quantityKg
    ) external {
        WineTrace wine = new WineTrace(_grapeType, _harvestYear, _quantityKg, msg.sender);
        wineContracts.push(address(wine));
        emit WineTraceCreated(address(wine), msg.sender);
    }

    function getAllWineContracts() public view returns (address[] memory) {
        return wineContracts;
    }
}
