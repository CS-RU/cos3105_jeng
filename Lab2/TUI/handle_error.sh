#!/bin/bash

# Capture stdout and stderr separately
result=$(./contacts2 mode email email_body 2>&1)
exit_code=$?

if [ $exit_code -eq 0 ]; then
    echo "Success: $result"
else
    echo "Error (exit code $exit_code): $result"
fi