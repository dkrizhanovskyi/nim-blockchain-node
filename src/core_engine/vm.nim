import state_management

type
  Transaction* = object
    sender*: string
    receiver*: string
    amount*: int
    fee*: int
    nonce*: int

  VM* = object
    state*: StateDB
    gasLimit*: int
    gasUsed*: int

proc newVM*(state: StateDB, gasLimit: int): VM =
  VM(state: state, gasLimit: gasLimit, gasUsed: 0)

proc validateTx*(vm: VM, tx: Transaction): bool =
  if tx.amount <= 0 or tx.fee < 0:
    return false
  if vm.state.getBalance(tx.sender) < tx.amount + tx.fee:
    return false
  if tx.nonce != vm.state.getNonce(tx.sender) + 1:
    return false
  true

proc applyTx*(vm: var VM, tx: Transaction): bool =
  const gasPerTx = 21000
  if vm.gasUsed + gasPerTx > vm.gasLimit or not vm.validateTx(tx):
    return false
  if not vm.state.decreaseBalance(tx.sender, tx.amount + tx.fee):
    return false
  vm.state.increaseBalance(tx.receiver, tx.amount)
  discard vm.state.incrementNonce(tx.sender)
  vm.gasUsed += gasPerTx
  true

proc resetGas*(vm: var VM, gasLimit: int) =
  vm.gasLimit = gasLimit
  vm.gasUsed = 0

proc gasRemaining*(vm: VM): int =
  vm.gasLimit - vm.gasUsed

proc executeBatch*(vm: var VM, txs: seq[Transaction]): seq[bool] =
  result = newSeq[bool](txs.len)
  for i, tx in txs:
    result[i] = vm.applyTx(tx)

proc commitState*(vm: VM): StateDB =
  vm.state
