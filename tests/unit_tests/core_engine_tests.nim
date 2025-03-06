import unittest
import ../../src/core_engine/consensus
import ../../src/core_engine/vm
import ../../src/core_engine/state_management

suite "Core Engine Tests":

  test "Consensus: quorum calculation and validation":
    let validators = @[Validator(id: "val1", stake: 1000, isActive: true),
                       Validator(id: "val2", stake: 2000, isActive: true),
                       Validator(id: "val3", stake: 1500, isActive: true)]
    let consensus = initializeConsensus(validators)
    check consensus.quorumSize == 3 # (3 validators -> quorum = 2/3 + 1 = 3)
    check validateBlock(consensus, 3) == true
    check validateBlock(consensus, 2) == false

  test "VM: gas metering":
    let vm = initializeVM(1000)
    check executeTransaction(vm, 500) == true
    check vm.gasUsed == 500
    check executeTransaction(vm, 600) == false # exceeds gas limit
    check vm.gasUsed == 500 # unchanged after failed transaction

  test "State Management: basic state updates":
    let stateDb = initializeState()
    updateState(stateDb, "account1", 100)
    check getState(stateDb, "account1") == 100
    check getState(stateDb, "nonexistent") == 0 # default value check