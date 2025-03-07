import unittest
import ../../src/core_engine/consensus
import ../../src/core_engine/state_management
import ../../src/core_engine/vm

suite "Core Engine Tests":

  test "Consensus - Validator Management":
    var cons = newConsensus()
    cons.addValidator(1, 100)
    cons.addValidator(2, 200)
    check cons.validatorExists(1)
    check cons.validatorExists(2)
    cons.deactivateValidator(1)
    check not cons.isValidatorActive(1)
    cons.removeValidator(2)
    check not cons.validatorExists(2)
    check cons.calculateQuorum() == 1

  test "State Management - Account Operations":
    var state = newStateDB()
    state.createAccount("0xA")
    check state.accountExists("0xA")
    state.setBalance("0xA", 500)
    check state.getBalance("0xA") == 500
    check state.decreaseBalance("0xA", 200)
    check state.getBalance("0xA") == 300
    state.increaseBalance("0xA", 100)
    check state.getBalance("0xA") == 400
    discard state.incrementNonce("0xA")
    check state.getNonce("0xA") == 1
    check state.totalSupply() == 400

  test "VM - Transaction Execution":
    var state = newStateDB()
    state.setBalance("Alice", 1000)
    state.setBalance("Bob", 500)
    var vm = newVM(state, 100000)
    let tx1 = Transaction(sender: "Alice", receiver: "Bob", amount: 100, fee: 10, nonce: 1)
    let tx2 = Transaction(sender: "Alice", receiver: "Bob", amount: 900, fee: 10, nonce: 2)
    check vm.applyTx(tx1)
    check state.getBalance("Alice") == 890
    check state.getBalance("Bob") == 600
    check not vm.applyTx(tx2)
    check state.getBalance("Alice") == 890
    check vm.gasUsed == 21000

