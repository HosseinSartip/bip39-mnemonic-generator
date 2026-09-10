#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

Write-Host "[1/3] Checking Python..."

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python is not installed."
    Write-Host "Install Python 3 and make sure it is available in PATH."
    exit 1
}

Write-Host "[2/3] Setting up Python virtual environment..."

$VenvDir = ".venv"

if (-not (Test-Path $VenvDir)) {
    python -m venv $VenvDir
}

$Python = Join-Path $VenvDir "Scripts\python.exe"

if (-not (Test-Path $Python)) {
    Write-Host "Virtual environment Python executable was not found."
    exit 1
}

& $Python -m pip install --upgrade pip --quiet
& $Python -m pip install mnemonic --quiet

Write-Host "[3/3] Generating BIP-39 mnemonic..."
Write-Host ""

$PythonCode = @'
from mnemonic import Mnemonic

m = Mnemonic("english")

# 128 bits of cryptographically secure entropy
mnemonic = m.generate(strength=128)

# Verify BIP-39 checksum
if not m.check(mnemonic):
    raise SystemExit("ERROR: Invalid BIP-39 mnemonic.")

words = mnemonic.split()

if len(words) != 12:
    raise SystemExit("ERROR: Mnemonic must contain 12 words.")

print("BIP-39 mnemonic:")
print()
print(mnemonic)
print()
print("Valid BIP-39:", m.check(mnemonic))
print("Word count:", len(words))
'@

$PythonCode | & $Python -
