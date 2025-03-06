import unittest
import ../../src/core_engine/consensus
import ../../src/core_engine/vm
import ../../src/core_engine/state_management

suite "Core Engine Tests":

  test "Consensus: quorum calculation and validation":
    let validators = @[Validator(id: "validator1", stake: 1000, isActive: true)]
    let consensus = initializeConsensus(validators)
    check consensus.calculateQuorum() == 1

  test "VM: gas metering":
    let vm = initializeVM(1000)
    check executeTransaction(vm, 500) == true
    check vm.gasLimit == 500
    check executeTransaction(vm, 600) == false

  test "State Management: basic state updates":
    let stateDB = initializeStateDB()
    updateState(stateDB, "testKey", 123)
    check getState(stateDB, "testKey") == 123
    check getState(stateDB, "unknownKey") == 0
