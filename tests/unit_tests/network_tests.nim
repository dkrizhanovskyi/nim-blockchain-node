import unittest
import ../../src/network/p2p
import ../../src/network/mempool
import ../../src/network/block_propagation

suite "Network Layer Tests":

  test "P2P: peer addition and disconnection":
    let network = initializeNetwork()
    network.addPeer("192.168.1.10")
    check network.peers.len == 1
    check network.peers[0].isConnected == true
    check network.disconnectPeer("192.168.1.10") == true
    check network.peers[0].isConnected == false

  test "Mempool: transaction management":
    let mempool = initializeMempool()
    let tx = Transaction(id: "tx1", fee: 100)
    check mempool.addTransaction(tx) == true
    check mempool.hasTransaction("tx1") == true
    check mempool.addTransaction(tx) == false  # Duplicate insertion
    check mempool.removeTransaction("tx1") == true
    check mempool.hasTransaction("tx1") == false

  test "Block Propagation: basic propagation":
    let blk = Block(id: "block123", data: "block_data")
    check propagateBlock(blk=blk) == true
