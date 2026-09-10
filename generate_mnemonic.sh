#!/usr/bin/env bash
set -euo pipefail

echo "[1/3] Checking Python..."

if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 is not installed."
    echo "Install it with:"
    echo "  sudo apt update && sudo apt install python3 python3-venv"
    exit 1
fi

echo "[2/3] Setting up Python virtual environment..."

VENV_DIR=".venv"

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
fi

"$VENV_DIR/bin/python" -m pip install --upgrade pip >/dev/null 2>&1
"$VENV_DIR/bin/python" -m pip install mnemonic >/dev/null 2>&1

echo "[3/3] Generating BIP-39 mnemonic..."
echo

"$VENV_DIR/bin/python" - <<'PY'
from mnemonic import Mnemonic

m = Mnemonic("english")

mnemonic = m.generate(strength=128)

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
PY
