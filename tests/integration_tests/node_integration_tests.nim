import unittest
import ../../src/core_engine/consensus
import ../../src/core_engine/vm
import ../../src/storage/blockchain_db
import ../../src/storage/state_db
import ../../src/network/mempool
import ../../src/network/block_propagation

suite "Blockchain Node Integration Tests":

  test "End-to-end block creation and propagation":
    # Initialize Core Components
    let validators = @[Validator(id: "validator1", stake: 1000, isActive: true)]
    discard initializeConsensus(validators)  # used explicitly if needed
    discard initializeVM(1000)               # VM initialized explicitly if needed

    # Initialize Storage and Network Components
    let stateDB = initializeStateDB()
    let blockchainDB = initializeBlockchainDB()
    let mempool = initializeMempool()

    # Simulate adding transaction to mempool
    let tx = Transaction(id: "tx999", fee: 200)
    check mempool.addTransaction(tx) == true

    # Create and propagate block
    let blk = Block(id: "blk999", data: "tx999 included")
    check propagateBlock(blk) == true

    # Save block to BlockchainDB explicitly
    check blockchainDB.addBlock(1, blk.data) == true
    check blockchainDB.getBlock(1) == "tx999 included"

    # Update StateDB explicitly
    stateDB.updateState("accountA", 500)
    check stateDB.getState("accountA") == 500
