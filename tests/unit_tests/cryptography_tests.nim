import unittest
import ../../src/cryptography/key_management
import ../../src/cryptography/signature_verification
import ../../src/cryptography/zk_proofs

suite "Cryptography Layer Tests":

  test "Key Management: generate and sign":
    let keyPair = generateKeyPair()
    check keyPair.publicKey == "pub_dummy"
    let signature = signMessage(keyPair, "test_message")
    check signature == "signed_test_message"

  test "Signature Verification: basic validation":
    let message = "secure_message"
    let signature = "signed_secure_message"
    check verifySignature("pub_dummy", message, signature) == true
    check verifySignature("pub_dummy", message, "invalid_signature") == false

  test "Zero-Knowledge Proofs: proof generation and verification":
    let data = "confidential_data"
    let proof = generateProof(data)
    check proof == "zk_proof_confidential_data"
    check verifyProof(data, proof) == true
    check verifyProof(data, "invalid_proof") == false
