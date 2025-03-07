import nimcrypto, nimcrypto/utils, nimcrypto/sysrand, nimcrypto/sha2

type
  KeyPair* = object
    publicKey*: string
    privateKey*: string

proc generateKeyPair*(): KeyPair =
  var privKey: array[32, byte]
  discard randomBytes(privKey)
  let pubKey = sha256.digest(privKey)
  KeyPair(
    publicKey: toHex(pubKey.data),
    privateKey: toHex(privKey)
  )

proc signMessage*(privateKeyHex, message: string): string =
  let
    privKey = fromHex(privateKeyHex)
    messageBytes = cast[seq[byte]](message.toOpenArrayByte(0, message.high))
    msgHash = sha256.digest(privKey & messageBytes)
  toHex(msgHash.data)

proc verifySignature*(publicKeyHex, message, signatureHex: string): bool =
  let
    pubKey = fromHex(publicKeyHex)
    messageBytes = cast[seq[byte]](message.toOpenArrayByte(0, message.high))
    expectedHash = sha256.digest(pubKey & messageBytes)
    actualSig = fromHex(signatureHex)
  expectedHash.data == actualSig
