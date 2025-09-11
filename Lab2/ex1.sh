#!/bin/bash

echo "=== File Descriptor Redirection Demo ==="

# Setup: Create some test files
echo -e "banana\napple\ncherry" > fruits.txt
echo "Setting up demo files..."

echo -e "\n1. REDIRECT STDOUT TO FILE"
echo "This goes to a file" > message.txt
echo "✓ Check message.txt - you won't see the output on screen"

echo -e "\n2. REDIRECT STDERR TO FILE"
ls thisfiledoesnotexist 2> error_log.txt
echo "✓ Error message went to error_log.txt instead of screen"

echo -e "\n3. REDIRECT BOTH STDOUT AND STDERR"
# This command will produce both output and an error
{ echo "Success message"; ls fakefile; } > all_output.txt 2>&1
echo "✓ Both success and error messages went to all_output.txt"

echo -e "\n4. SHORTHAND FOR BOTH"
{ echo "Another success"; ls anotherfakefile; } &> shorthand_output.txt
echo "✓ Same result using &> shorthand"

echo -e "\n5. REDIRECT STDIN FROM FILE"
echo "Sorting fruits from fruits.txt:"
sort < fruits.txt

echo -e "\n6. DISCARD OUTPUT (send to /dev/null)"
echo "Running ls on fake file - you won't see any error:"
ls nonexistent 2> /dev/null
echo "✓ Error was discarded"

echo -e "\n7. DISCARD EVERYTHING"
{ echo "This output disappears"; ls fakefile; } &> /dev/null
echo "✓ Both output and errors were discarded"

echo -e "\n=== Demo complete! Check these files: ==="
echo "- message.txt"
echo "- error_log.txt"
echo "- all_output.txt"
echo "- shorthand_output.txt"

# Cleanup option
echo -e "\nTo clean up demo files, run:"
echo "rm -f message.txt error_log.txt all_output.txt shorthand_output.txt fruits.txt"