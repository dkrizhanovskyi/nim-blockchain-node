# ======================================================
# Module: StateDB
# Role: State Management and Storage for Blockchain Nodes
# Author's Perspective: System Architect & Lead Cryptographer
# ======================================================

import tables

# ------------------------------------------------------
# Type: StateDB
# Purpose:
#   Stores and manages blockchain state information as key-value pairs.
#
# Fields:
# - states: Explicit key-value store tracking blockchain state data, critical for transaction verification and state consistency.
# Architectural Considerations:
#   - Provides efficient access and modification of blockchain state to ensure integrity and consistency.
# ------------------------------------------------------
type
  StateDB* = ref object
    states*: Table[string, int]  # State data storage for efficient lookup and updates

# ------------------------------------------------------
# Proc: initializeStateDB
# Purpose:
#   Initializes a new, empty blockchain state database.
# Security and Architectural Considerations:
#   - Explicit initialization ensures consistent, secure baseline for blockchain state management.
# ------------------------------------------------------
proc initializeStateDB*(): StateDB =
  StateDB(states: initTable[string, int]())

# ------------------------------------------------------
# Proc: updateState
# Purpose:
#   Updates or inserts state information for a given key.
# Security and Architectural Considerations:
#   - Explicit state updates ensure accurate state management and secure transactions, essential for maintaining blockchain consensus.
# ------------------------------------------------------
proc updateState*(db: StateDB, key: string, value: int) =
  db.states[key] = value

# ------------------------------------------------------
# Proc: getState
# Purpose:
#   Retrieves the state value associated with a specific key.
# Security and Architectural Considerations:
#   - Default handling (0 for non-existent keys) explicitly indicates state absence, improving clarity and reliability of blockchain operations.
# ------------------------------------------------------
proc getState*(db: StateDB, key: string): int =
  db.states.getOrDefault(key, 0)

# ======================================================
# Summary (Architectural & Cryptographic Insights):
# - Explicit and secure state management is crucial for blockchain reliability, integrity, and consensus accuracy.
# - Clearly structured data management facilitates cryptographic validation and secure state transitions.
# - Essential module supporting robust transaction validation and secure blockchain operations.
# ======================================================
