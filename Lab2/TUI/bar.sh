#!/bin/bash

# Simple file processing progress bar
{
    for i in {0..100..20}; do
        echo "XXX"
        echo $i
        echo "Processing file $((i/20 + 1)) of 6..."
        echo "XXX"
        sleep 1
    done
} | whiptail --gauge "File Processing" 6 50 0

echo "Done!"