#!/bin/bash
name="John"
age=25
score=87.5

# echo - basic concatenation
echo "Name: $name, Age: $age, Score: $score"

# printf - formatted output
printf "Name: %-10s Age: %3d Score: %6.2f\n" "$name" "$age" "$score"
# Output: Name: John       Age:  25 Score:  87.50

# Without formatting
printf "%s\n" "hello"
# Output: hello

# With %-10s (left-aligned, 10 characters wide)
printf "%-10s|\n" "hello"
# Output: hello     |
#         ^^^^^     ^ (5 spaces added to make it 10 chars total)

# Compare with right-aligned (no minus sign)
printf "%10s|\n" "hello"
# Output:      hello|
#         ^^^^^     ^ (5 spaces before the text)