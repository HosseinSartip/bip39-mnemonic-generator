# BIP-39 Mnemonic Generator

A simple cross-platform tool for generating and validating 12-word BIP-39 mnemonic phrases using Bash/PowerShell and Python.

The project supports both Linux and Windows environments and uses a local Python virtual environment to keep dependencies isolated from the system Python installation.

## Features

* Generates a 12-word English BIP-39 mnemonic
* Uses 128 bits of entropy
* Validates the BIP-39 checksum
* Linux support through Bash
* Windows support through PowerShell
* Uses an isolated Python virtual environment
* No external API or online service is required for mnemonic generation
* Simple and lightweight

## Project Structure

```text
bip39-mnemonic-generator/
├── generate_mnemonic.sh
├── generate-mnemonic.ps1
├── README.md
├── LICENSE
└── .gitignore
```

## Requirements

### Linux

Python 3 and the Python virtual environment package are required.

On Debian, Ubuntu, or Kali Linux:

```bash
sudo apt update
sudo apt install python3 python3-venv
```

### Windows

Install Python 3 and make sure Python is available in the system `PATH`.

Verify the installation:

```powershell
python --version
```

## Linux / Bash

Make the Bash script executable:

```bash
chmod +x generate_mnemonic.sh
```

Run the script:

```bash
./generate_mnemonic.sh
```

The script automatically:

1. Checks for Python 3.
2. Creates a `.venv` directory if it does not already exist.
3. Updates `pip` inside the virtual environment.
4. Installs the `mnemonic` Python package.
5. Generates a 12-word BIP-39 mnemonic.
6. Validates the generated mnemonic.
7. Displays the word count and validation result.

## Windows / PowerShell

Run PowerShell in the project directory:

```powershell
.\generate-mnemonic.ps1
```

If PowerShell execution policy prevents the script from running, you can allow scripts for the current PowerShell session:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Then run:

```powershell
.\generate-mnemonic.ps1
```

The PowerShell version uses:

```text
.venv\Scripts\python.exe
```

for the local Python virtual environment.

## Example Output

```text
[1/3] Checking Python...
[2/3] Setting up Python virtual environment...
[3/3] Generating BIP-39 mnemonic...

BIP-39 mnemonic:

example example example example example example example example example example example example

Valid BIP-39: True
Word count: 12
```

The mnemonic shown above is only an example and must not be used as a real wallet seed.

## How It Works

The project uses the Python `mnemonic` package.

The generator creates 128 bits of entropy:

```python
mnemonic = m.generate(strength=128)
```

According to the BIP-39 encoding scheme, 128 bits of entropy produces a 12-word mnemonic with checksum data.

The generated mnemonic is then validated:

```python
m.check(mnemonic)
```

The script also verifies that exactly 12 words were generated.

## Security

A BIP-39 mnemonic is highly sensitive.

Anyone who obtains a wallet's mnemonic may be able to recover the wallet and access its assets.

Never commit a real mnemonic to GitHub.

Do not:

* Store a real seed phrase in source code.
* Put a real mnemonic in `README.md`.
* Upload a real mnemonic in an issue or pull request.
* Publish screenshots containing a real seed phrase.
* Send a real mnemonic through chat or email.
* Store production wallet seeds in cloud storage or public repositories.

For real cryptocurrency wallets, use a purpose-built wallet or hardware wallet and follow established key-management practices.

This project should not be considered a replacement for a dedicated hardware wallet or audited wallet software.

## Dependency Isolation

Both scripts create a local Python virtual environment:

```text
.venv/
```

The required `mnemonic` package is installed inside this environment rather than into the global Python installation.

This helps avoid dependency conflicts with other Python applications.

The `.venv` directory is excluded from Git using `.gitignore`.

## Supported Platforms

### Linux

Tested/targeted environments include:

* Debian
* Ubuntu
* Kali Linux
* Other Linux distributions with Python 3 and `venv`

### Windows

* Windows 10
* Windows 11
* PowerShell
* Python 3

## Why 12 Words?

The scripts use:

```python
m.generate(strength=128)
```

A strength of 128 bits results in a 12-word BIP-39 mnemonic.

The generated phrase also contains a checksum defined by the BIP-39 specification.

## License

This project is licensed under the MIT License.

See [LICENSE](LICENSE) for details.

## Disclaimer

This software is provided for educational and development purposes.

The authors and contributors are not responsible for any loss of funds, compromised wallets, leaked credentials, or other damages resulting from the use or misuse of this software.
