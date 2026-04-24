#!/usr/bin/env bash
set -euo pipefail

PLAINTEXT="0001001000110100010101100111100010011010101111001101111011110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des
CIPHER=$(printf "1\n%s\n%s\n" "$PLAINTEXT" "$KEY" | ./des)

# Bit flip - tamper by changing first character
TAMPERED_CIPHER="1${CIPHER:1}"
DECRYPTED=$(printf "2\n%s\n%s\n" "$TAMPERED_CIPHER" "$KEY" | ./des)

if [[ "$DECRYPTED" != "$PLAINTEXT" ]]; then
  echo "PASS: Tampered ciphertext did not match plaintext (negative test passed)"
else
  echo "FAIL: Tampered matched original"
  exit 1
fi