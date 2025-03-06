# ======================================================
# Module: Peer-to-Peer (P2P) Network
# Role: Management of Network Connections and Peer States
# Author's Perspective: System Architect & Lead Cryptographer
# ======================================================

# ------------------------------------------------------
# Type: Peer
# Purpose:
#   Represents a network peer node within the blockchain network.
#
# Fields:
# - address: Network address (e.g., IP address or URL), critical for peer discovery and communication.
# - isConnected: Explicit connection status ensuring active network management.
# Architectural Considerations:
#   - Explicit tracking of connectivity status enhances network robustness and security.
# ------------------------------------------------------
type
  Peer* = object
    address*: string       # Network address of peer node
    isConnected*: bool     # Active connection status indicator

# ------------------------------------------------------
# Type: Network
# Purpose:
#   Maintains a collection of network peers and manages their state.
#
# Fields:
# - peers: List of peer nodes participating in network activities, explicitly tracked for efficient management and discovery.
# ------------------------------------------------------
type
  Network* = ref object
    peers*: seq[Peer]

# ------------------------------------------------------
# Proc: initializeNetwork
# Purpose:
#   Initializes an empty peer network.
# Security and Architectural Considerations:
#   Explicit initialization ensures a controlled starting state for managing secure peer connections.
# ------------------------------------------------------
proc initializeNetwork*(): Network =
  Network(peers: @[])

# ------------------------------------------------------
# Proc: addPeer
# Purpose:
#   Adds a new peer to the network.
# Security and Architectural Considerations:
#   - Explicitly manages new peer addition, supporting robust peer discovery and network expansion.
#   - Ensures peers are immediately available for network communication and synchronization.
# ------------------------------------------------------
proc addPeer*(network: Network, address: string) =
  network.peers.add(Peer(address: address, isConnected: true))

# ------------------------------------------------------
# Proc: disconnectPeer
# Purpose:
#   Disconnects a peer from the network by updating its connectivity status.
# Security and Architectural Considerations:
#   - Explicit disconnection management mitigates risks from compromised or malfunctioning peers.
#   - Enhances network security by promptly isolating problematic nodes.
# ------------------------------------------------------
proc disconnectPeer*(network: Network, address: string): bool =
  for peer in network.peers.mitems:
    if peer.address == address:
      peer.isConnected = false
      return true
  false

# ======================================================
# Summary (Architectural & Cryptographic Insights):
# - Explicit management of network peers enhances blockchain network security, stability, and efficiency.
# - Clearly defined peer states support reliable peer-to-peer interactions and timely response to potential threats or disruptions.
# - Essential infrastructure component for maintaining robust and secure blockchain consensus.
# ======================================================
