#!/bin/bash
username="Alice"  # Global

function test_local() {
    local username="Bob"    # Local variable, shadows global
    echo "Inside function: $username"  # Bob
}

echo "Before: $username"   # Alice
test_local                 # Inside function: Bob
echo "After: $username"    # Alice (global unchanged)