import tables

type
  Validator* = object
    id*: int
    stake*: int
    active*: bool

  Consensus* = object
    validators*: Table[int, Validator]

proc newConsensus*(): Consensus =
  Consensus(validators: initTable[int, Validator]())

proc addValidator*(c: var Consensus, id, stake: int) =
  if stake <= 0 or c.validators.hasKey(id):
    return
  c.validators[id] = Validator(id: id, stake: stake, active: true)

proc deactivateValidator*(c: var Consensus, id: int) =
  if c.validators.hasKey(id):
    c.validators[id].active = false

proc activateValidator*(c: var Consensus, id: int) =
  if c.validators.hasKey(id):
    c.validators[id].active = true

proc removeValidator*(c: var Consensus, id: int) =
  c.validators.del(id)

proc calculateQuorum*(c: Consensus): int =
  var activeCount = 0
  for v in c.validators.values:
    if v.active:
      inc activeCount
  if activeCount == 0:
    return 0
  (activeCount div 2) + 1

proc hasQuorum*(c: Consensus, votes: seq[int]): bool =
  var count = 0
  for id in votes:
    if c.validators.hasKey(id) and c.validators[id].active:
      inc count
  count >= c.calculateQuorum()

proc validatorStake*(c: Consensus, id: int): int =
  if c.validators.hasKey(id):
    c.validators[id].stake
  else:
    0

proc totalActiveStake*(c: Consensus): int =
  var total = 0
  for v in c.validators.values:
    if v.active:
      total += v.stake
  total

proc validatorExists*(c: Consensus, id: int): bool =
  c.validators.hasKey(id)

proc isValidatorActive*(c: Consensus, id: int): bool =
  c.validators.hasKey(id) and c.validators[id].active
