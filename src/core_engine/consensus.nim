# consensus.nim

type
  Validator* = object
    id*: string
    stake*: uint64
    isActive*: bool

  Consensus* = ref object
    validators*: seq[Validator]
    currentRound*: int
    quorumSize*: int

proc initializeConsensus*(validators: seq[Validator]): Consensus =
  Consensus(
    validators: validators,
    currentRound: 0,
    quorumSize: validators.len div 3 * 2 + 1 # BFT quorum calculation
  )

proc advanceRound*(consensus: Consensus) =
  consensus.currentRound.inc()

proc validateBlock*(consensus: Consensus, votes: int): bool =
  votes >= consensus.quorumSize
