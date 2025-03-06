# state_management.nim

import tables

type
  StateDB* = ref object
    state*: Table[string, int] # Simplified key-value store

proc initializeState*(): StateDB =
  StateDB(state: initTable[string, int]())

proc updateState*(db: StateDB, key: string, value: int) =
  db.state[key] = value

proc getState*(db: StateDB, key: string): int =
  db.state.getOrDefault(key, 0)
