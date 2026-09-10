# BIP-39 Mnemonic Generator

A simple Bash script for Linux that generates a cryptographically secure 12-word BIP-39 mnemonic using Python and the `mnemonic` library.

The script automatically checks for Python 3, creates an isolated Python virtual environment, installs the required dependency, generates 128 bits of entropy, and validates the resulting BIP-39 mnemonic.

## Features

- Bash-based execution
- Python 3 dependency
- Isolated Python virtual environment
- 128 bits of entropy
- Generates a 12-word English BIP-39 mnemonic
- Validates the BIP-39 checksum
- No external API or network service is required for generation
- Simple and lightweight

## Requirements

The following packages are required on Debian, Ubuntu, or Kali Linux:

```bash
sudo apt update
sudo apt install python3 python3-venv
