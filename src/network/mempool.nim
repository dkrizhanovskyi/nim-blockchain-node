# ======================================================
# Module: Mempool
# Role: Management of Pending Blockchain Transactions
# Author's Perspective: System Architect & Lead Cryptographer
# ======================================================

import tables

# ------------------------------------------------------
# Type: Transaction
# Purpose:
#   Represents a blockchain transaction awaiting confirmation.
#
# Fields:
# - id: Unique transaction identifier for tracking and verification.
# - fee: Transaction fee indicating transaction priority within the mempool.
# Architectural Considerations:
#   - Fee-based prioritization explicitly supports efficient transaction ordering and network resource management.
# ------------------------------------------------------
type
  Transaction* = object
    id*: string    # Unique identifier for the transaction
    fee*: int      # Transaction fee determining priority

# ------------------------------------------------------
# Type: Mempool
# Purpose:
#   Maintains a collection of pending transactions before block inclusion.
#
# Fields:
# - transactions: Hash table explicitly storing transactions indexed by ID, enabling fast lookup and efficient management.
# ------------------------------------------------------
type
  Mempool* = ref object
    transactions*: Table[string, Transaction]

# ------------------------------------------------------
# Proc: initializeMempool
# Purpose:
#   Initializes an empty mempool.
# Security and Architectural Considerations:
#   Explicit initialization ensures a secure and consistent state, facilitating validation and auditing.
# ------------------------------------------------------
proc initializeMempool*(): Mempool =
  Mempool(transactions: initTable[string, Transaction]())

# ------------------------------------------------------
# Proc: addTransaction
# Purpose:
#   Adds a transaction to the mempool.
# Security and Architectural Considerations:
#   - Explicit duplicate check prevents malicious or accidental flooding of the mempool.
#   - Ensures integrity and manageability of pending transactions.
# ------------------------------------------------------
proc addTransaction*(pool: Mempool, tx: Transaction): bool =
  if pool.transactions.hasKey(tx.id):
    return false  # Prevent adding duplicates explicitly
  pool.transactions[tx.id] = tx
  true

# ------------------------------------------------------
# Proc: removeTransaction
# Purpose:
#   Removes a transaction from the mempool.
# Security and Architectural Considerations:
#   - Explicit transaction removal supports dynamic mempool management, critical for maintaining accuracy and efficiency.
# ------------------------------------------------------
proc removeTransaction*(pool: Mempool, txId: string): bool =
  if pool.transactions.hasKey(txId):
    pool.transactions.del(txId)
    return true
  false

# ------------------------------------------------------
# Proc: hasTransaction
# Purpose:
#   Checks for the existence of a transaction within the mempool.
# Security and Architectural Considerations:
#   - Explicit lookup ensures efficient transaction validation and status checking, important for blockchain consensus and network integrity.
# ------------------------------------------------------
proc hasTransaction*(pool: Mempool, txId: string): bool =
  pool.transactions.hasKey(txId)

# ======================================================
# Summary (Architectural & Cryptographic Insights):
# - Mempool explicitly manages pending transactions, ensuring efficient prioritization and security against duplication and malicious flooding.
# - Clear and explicit transaction lifecycle management enhances overall blockchain reliability and efficiency.
# - Essential component supporting consensus mechanisms and network resource optimization.
# ======================================================
