#!/bin/bash
result=$(whiptail \
  --radiolist "What is your favorite shell?" 0 0 3 \
  "Bash" "(Bourne Again shell)" 1 \
  "Zsh"  "(Z-Shell)" 0 \
  "Dash" "(Dash shell)" 0 \
  3>&1 1>&2 2>&3)

echo "You selected: $result"