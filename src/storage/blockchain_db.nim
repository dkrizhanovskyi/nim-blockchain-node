# ======================================================
# Module: BlockchainDB
# Role: Management and retrieval of blockchain blocks
# Author's Perspective: System Architect & Lead Cryptographer
# ======================================================

import tables

# ------------------------------------------------------
# Type: BlockchainDB
# Purpose:
#   Manages storage and retrieval of blockchain blocks explicitly indexed by their block height.
#
# Fields:
# - blocks: Hash table explicitly mapping block heights to their associated data, ensuring fast access and efficient storage management.
# Security and Architectural Considerations:
#   - Simplified model clearly represents block storage logic; production implementations should use cryptographically secure storage mechanisms.
# ------------------------------------------------------
type
  BlockchainDB* = ref object
    blocks*: Table[int, string]  # Block data storage explicitly indexed by height

# ------------------------------------------------------
# Proc: initializeBlockchainDB
# Purpose:
#   Initializes a new, empty blockchain database.
# Security and Architectural Considerations:
#   - Explicit initialization ensures clear and secure blockchain data management from genesis.
# ------------------------------------------------------
proc initializeBlockchainDB*(): BlockchainDB =
  BlockchainDB(blocks: initTable[int, string]())

# ------------------------------------------------------
# Proc: addBlock
# Purpose:
#   Adds a new block to the blockchain database.
# Security and Architectural Considerations:
#   - Clear block addition procedure supports reliable block management and secure state tracking.
# ------------------------------------------------------
proc addBlock*(db: BlockchainDB, height: int, data: string): bool =
  if db.blocks.hasKey(height):
    return false  # explicitly handle duplicates
  db.blocks[height] = data
  true  # explicit success indicator

# ------------------------------------------------------
# Proc: getBlock
# Purpose:
#   Retrieves block data at a given height.
# Security and Architectural Considerations:
#   - Explicit block retrieval ensures efficient and secure access, essential for validation, consensus, and auditing.
# ------------------------------------------------------
proc getBlock*(db: BlockchainDB, height: int): string =
  db.blocks.getOrDefault(height, "")

# ======================================================
# Summary (Architectural & Cryptographic Insights):
# - Explicit block storage mechanism ensures data integrity and availability critical for maintaining blockchain consensus.
# - Simplified architecture supports clear, maintainable data management, facilitating integration with cryptographically secure storage solutions in production.
# - Explicit and secure data access promotes transparency, auditability, and resilience against common blockchain attacks.
# ======================================================
