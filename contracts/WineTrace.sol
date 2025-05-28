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
}