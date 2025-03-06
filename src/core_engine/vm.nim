# vm.nim

type
  VM* = ref object
    gasLimit*: int
    gasUsed*: int

proc initializeVM*(gasLimit: int): VM =
  VM(gasLimit: gasLimit, gasUsed: 0)

proc executeTransaction*(vm: VM, gasCost: int): bool =
  if vm.gasUsed + gasCost > vm.gasLimit:
    return false # Prevent exceeding gas limit
  vm.gasUsed += gasCost
  true
