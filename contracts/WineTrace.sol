// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract WineTracer {
    struct Stage {
        string description;
        string date;
    }

    string public grapeType;
    string public harvestYear;
    uint public quantityKg;
    address public owner;

    Stage[] public stages;

    event NewStage(string description, string date);

    modifier onlyOwner() {
        require(msg.sender == owner, "Permission denied. You are not the owner.");
        _;
    }

    constructor(
        string memory _grapeType,
        string memory _harvestYear,
        uint _quantityKg,
        address _creator
    ) {
        grapeType = _grapeType;
        harvestYear = _harvestYear;
        quantityKg = _quantityKg;
        owner = _creator;
    }

    function addStage(string memory _description, string memory _date) external onlyOwner {
        stages.push(Stage(_description, _date));
        emit NewStage(_description, _date);
    }
}