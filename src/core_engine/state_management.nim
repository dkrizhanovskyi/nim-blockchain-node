import tables

type
  Account* = object
    balance*: int
    nonce*: int

  StateDB* = object
    accounts*: Table[string, Account]

proc newStateDB*(): StateDB =
  StateDB(accounts: initTable[string, Account]())

proc createAccount*(s: var StateDB, address: string) =
  if not s.accounts.hasKey(address):
    s.accounts[address] = Account(balance: 0, nonce: 0)

proc accountExists*(s: StateDB, address: string): bool =
  s.accounts.hasKey(address)

proc getBalance*(s: StateDB, address: string): int =
  if s.accounts.hasKey(address):
    s.accounts[address].balance
  else:
    0

proc setBalance*(s: var StateDB, address: string, amount: int) =
  if amount < 0:
    return
  s.createAccount(address)
  s.accounts[address].balance = amount

proc increaseBalance*(s: var StateDB, address: string, amount: int) =
  if amount <= 0:
    return
  s.createAccount(address)
  s.accounts[address].balance += amount

proc decreaseBalance*(s: var StateDB, address: string, amount: int): bool =
  if amount <= 0 or not s.accounts.hasKey(address):
    return false
  let acc = s.accounts[address]
  if acc.balance < amount:
    return false
  s.accounts[address].balance -= amount
  true

proc getNonce*(s: StateDB, address: string): int =
  if s.accounts.hasKey(address):
    s.accounts[address].nonce
  else:
    0

proc incrementNonce*(s: var StateDB, address: string): int =
  s.createAccount(address)
  s.accounts[address].nonce += 1
  s.accounts[address].nonce

proc resetAccount*(s: var StateDB, address: string) =
  if s.accounts.hasKey(address):
    s.accounts[address] = Account(balance: 0, nonce: 0)

proc deleteAccount*(s: var StateDB, address: string) =
  s.accounts.del(address)

proc totalSupply*(s: StateDB): int =
  var total = 0
  for acc in s.accounts.values:
    total += acc.balance
  total
