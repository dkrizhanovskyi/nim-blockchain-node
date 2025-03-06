# ======================================================
# Module: IndexDB
# Role: Transaction Indexing for Blockchain Storage
# Author's Perspective: System Architect & Lead Cryptographer
# ======================================================

import tables

# ------------------------------------------------------
# Type: IndexDB
# Purpose:
#   Maintains an index of transactions mapped to their corresponding block heights, facilitating rapid data retrieval.
#
# Fields:
# - txIndex: Explicit mapping between transaction identifiers and block heights for efficient lookup.
#
# Architectural Considerations:
#   - Provides quick access to transaction data, essential for efficient validation and consensus verification.
# ------------------------------------------------------
type
  IndexDB* = ref object
    txIndex*: Table[string, int]  # Transaction-to-block height mapping

# ------------------------------------------------------
# Proc: initializeIndexDB
# Purpose:
#   Initializes an empty transaction index database.
# Security and Architectural Considerations:
#   - Explicit initialization of indices enhances integrity and data consistency from inception.
# ------------------------------------------------------
proc initializeIndexDB*(): IndexDB =
  IndexDB(txIndex: initTable[string, int]())

# ------------------------------------------------------
# Proc: updateTxIndex
# Purpose:
#   Inserts or updates the block height for a given transaction ID.
# Security and Architectural Considerations:
#   - Explicit indexing enables quick and secure transaction validation, crucial for blockchain auditing and security analysis.
# ------------------------------------------------------
proc updateTxIndex*(db: IndexDB, txId: string, blockHeight: int) =
  db.txIndex[txId] = blockHeight

# ------------------------------------------------------
# Proc: getTxIndex
# Purpose:
#   Retrieves the block height associated with a transaction ID.
# Security and Architectural Considerations:
#   - Explicit default handling (-1 indicates absence) ensures clear differentiation between existing and nonexistent transactions, promoting data reliability.
# ------------------------------------------------------
proc getTxIndex*(db: IndexDB, txId: string): int =
  db.txIndex.getOrDefault(txId, -1)

# ======================================================
# Summary (Architectural & Cryptographic Insights):
# - Explicit and efficient transaction indexing is critical for performance, data integrity, and blockchain traceability.
# - Clearly structured data management aligns with secure data handling best practices, facilitating robust cryptographic verification.
# - Essential component in ensuring timely, secure transaction verification and auditing within blockchain systems.
# ======================================================
