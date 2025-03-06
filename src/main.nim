# ======================================================
# Main Module: Nim Blockchain Node Initialization
# Role: Entry point and integration of blockchain system components
# Perspective: System Architect & Lead Cryptographer
# ======================================================

import core_engine/consensus
import storage/blockchain_db
import network/mempool
import network/block_propagation

# ------------------------------------------------------
# Procedure: main
# Purpose:
#   Entry point procedure that initializes and starts the blockchain node.
# Security & Architectural Considerations:
#   - Explicitly initializes critical subsystems (consensus, blockchain database, mempool).
#   - Clearly defined execution flow ensures modularity, maintainability, and secure operation.
# ------------------------------------------------------
proc main() =
  echo "🚀 Starting Nim Blockchain Node..."

  # Initialize Consensus Engine with validators
  let validators = @[Validator(id: "validator1", stake: 1000, isActive: true)]
  let consensusEngine = initializeConsensus(validators)
  echo "✅ Consensus Engine initialized with validators: ", consensusEngine.validators.len

  # Initialize Blockchain Database explicitly
  var blockchainDB = initializeBlockchainDB()
  echo "✅ Blockchain Database initialized."

  # Initialize Mempool for managing incoming transactions
  var mempool = initializeMempool()
  echo "✅ Mempool initialized."

  # Simulate transaction management: Add a transaction explicitly
  let tx = Transaction(id: "tx_main", fee: 100)
  if mempool.addTransaction(tx):
    echo "✅ Transaction added to mempool: ", tx.id
  else:
    echo "⚠️ Transaction could not be added (duplicate or error)."

  # Create, propagate, and store a new block explicitly
  let blk = Block(id: "block100", data: "tx100 included")
  if propagateBlock(blk):
    if addBlock(blockchainDB, 1, blk.data):  
      echo "✅ Block stored successfully."
    else:
      echo "⚠️ Failed to store block (possible duplicate)."
  else:
    echo "⚠️ Block propagation failed."

  echo "🎉 Node initialized successfully and operational."

# ------------------------------------------------------
# Main execution trigger
# Ensures that 'main' procedure is executed explicitly when the module is run directly.
# ------------------------------------------------------
when isMainModule:
  main()

# ======================================================
# Summary:
# - The module clearly initializes and manages blockchain core components with explicit checks and informative logging.
# - Enhances readability, maintainability, and security through explicit initialization and return-value handling.
# - Adheres to best practices for Nim programming and blockchain architecture design.
# ======================================================
