import unittest
import ../../src/storage/blockchain_db
import ../../src/storage/state_db
import ../../src/storage/index_db

suite "Storage Layer Tests":

  test "BlockchainDB: block storage and retrieval":
    let chainDB = initializeBlockchainDB()
    check chainDB.addBlock(1, "BlockData1") == true
    check chainDB.addBlock(1, "BlockDataDuplicate") == false  # duplicates prevented
    check chainDB.getBlock(1) == "BlockData1"
    check chainDB.getBlock(2) == ""  # returns empty string if not found

  test "StateDB: state update and retrieval":
    let stateDB = initializeStateDB()
    updateState(stateDB, "account1", 100)
    check getState(stateDb, "account1") == 100
    check getState(stateDb, "unknown") == 0  # default value when not found

  test "IndexDB: indexing transactions":
    let indexDB = initializeIndexDB()
    indexDB.updateTxIndex("tx123", 10)
    check indexDB.getTxIndex("tx123") == 10
    check indexDB.getTxIndex("tx999") == -1  # non-existent tx returns -1 explicitly
