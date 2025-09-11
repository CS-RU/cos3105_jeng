#!/bin/bash
# Global variable
username="Alice"

function display_user() {
    echo "User: $username"  # Can access global variable
}

function change_user() {
    username="Bob"          # Modifies the global variable!
}

echo "Initial: $username"  # Alice
display_user               # User: Alice
change_user
echo "After change: $username"  # Bob (global was modified)