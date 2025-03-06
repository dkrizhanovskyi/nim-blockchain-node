# Getting Started with Nim Blockchain Node

## Introduction
This guide provides clear instructions to quickly set up your development environment and start running your Nim Blockchain Node. Follow these straightforward steps to get your node operational.

## 🚀 Environment Setup
Ensure you have the following prerequisites installed and configured:

### 1. Nim Programming Language
Download and install Nim from the official [Nim website](https://nim-lang.org/install.html).

### 2. Git
Install Git from the [official Git website](https://git-scm.com/).

### 3. Development Tools
- Install Visual Studio Code or your preferred IDE for Nim development.
- Install [Nim extension](https://marketplace.visualstudio.com/items?itemName=kosz78.nim) for syntax highlighting and Nim support.

## 🛠️ Project Setup
Clone the repository and initialize dependencies:
```shell
git clone https://github.com/dkrizhanovskyi/nim-blockchain-node.git nim-blockchain-node
cd nim-blockchain-node
nimble install
```

## ✅ Build and Run
Build and run the blockchain node:
```shell
nimble build
.\main.exe
```

You should see a confirmation message indicating the node has successfully started:
```shell
🚀 Starting Nim Blockchain Node...
✅ Block stored successfully.
🎉 Node initialized successfully.
```

## 🧪 Running Tests
Execute the suite of unit and integration tests:
```shell
nimble test
```
Verify all tests pass to ensure system stability.

## 📖 Next Steps
After successfully setting up and testing your node, consider:
- Reviewing the detailed architecture documentation (`docs/architecture.md`).
- Exploring further implementation details provided in `docs/overview.md`.

### 🛡️ Security Considerations
Regularly review cryptographic practices and keep dependencies updated. Pay attention to cryptographic library versions and potential vulnerabilities.

For further information or to contribute, see [contributing.md](contributing.md).
