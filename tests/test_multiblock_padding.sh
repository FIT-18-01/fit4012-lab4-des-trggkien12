#!/usr/bin/env bash
set -euo pipefail

LONG_PLAINTEXT="00010010001101000101011001111000100110101011110011011110111100011010"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des
CIPHER=$(printf "1\n%s\n%s\n" "$LONG_PLAINTEXT" "$KEY" | ./des)

LEN=${#CIPHER}
if [[ "$LEN" -eq 128 ]]; then
  echo "PASS: Multi-block padding generated 128-bit ciphertext"
else
  echo "FAIL: Padding length incorrect"
  exit 1
fi