// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract WineTracer {
    struct Stage {
        string description;
        string date;
    }

    struct Batch {
        string grapeType;
        string harvestYear;
        uint quantityKg;
        address owner;
        Stage[] stages;
    }

    mapping(uint => Batch) public batches;
    uint public batchCounter;

    

    modifier onlyOwner(uint _id) {
        require(msg.sender == batches[_id].owner, "You are not the owner of this batch.");
        _;
    }
}