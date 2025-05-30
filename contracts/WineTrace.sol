// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract WineTrace {
    struct Stage {
        string description;
        string date;
    }

    string public grapeType;
    string public harvestYear;
    uint public quantityKg;
    address public owner;

    Stage[] private stages;
    uint public totalSponsorship;

    event NewStage(string description, string date);
    event WineSponsored(address indexed sponsor, uint amount);

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
        require(_quantityKg > 0, "Quantity must be greater than 0.");
        grapeType = _grapeType;
        harvestYear = _harvestYear;
        quantityKg = _quantityKg;
        owner = _creator;
    }

    function addStage(string memory _description, string memory _date) external onlyOwner {
        stages.push(Stage(_description, _date));
        emit NewStage(_description, _date);
    }

    function getStage(uint index) public view returns (string memory, string memory) {
        require(index < stages.length, "Invalid index");
        Stage memory s = stages[index];
        return (s.description, s.date);
    }

    function getStageCount() public view returns (uint) {
        return stages.length;
    }

    function sponsorWine() external payable {
        require(msg.value > 0, "Sponsorship must be greater than 0.");
        totalSponsorship += msg.value;
        emit WineSponsored(msg.sender, msg.value);
    }

    function withdrawSponsorship() external onlyOwner {
        require(totalSponsorship > 0, "No funds to withdraw.");
        uint amount = totalSponsorship;
        totalSponsorship = 0;
        (bool sent, ) = owner.call{value: amount}("");
        require(sent, "Withdrawal failed.");
    }
}