# nim_blockchain_node.nimble

version       = "0.1.0"
author        = "arec1b0"
description   = "A high-performance blockchain node implementation in Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["main"]

task build, "Compile blockchain node executable":
  exec "nim c -d:release src/main.nim"

# Dependencies here if needed, e.g.:
# requires "nim >= 2.2.2"
task test, "Run all tests":
  exec "nim c -r tests/unit_tests/core_engine_tests.nim"
  exec "nim c -r tests/unit_tests/cryptography_tests.nim"
  exec "nim c -r tests/unit_tests/network_tests.nim"
  exec "nim c -r tests/unit_tests/storage_tests.nim"
  exec "nim c -r tests/integration_tests/node_integration_tests.nim"
