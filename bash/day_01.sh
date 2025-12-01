#!/bin/bash

# Shared preprocessing: convert L/R to -/+ signs
preprocess() {
    cat "input.txt" | tr 'L' '-' | tr 'R' '+'
}

# Count how many times position wraps to 0 (mod 100)
count_zeros() {
    awk -v c=50 '{c=(c+$0)%100;p+=(c==0?1:0)} END {print p}'
}

# Part 1: Process moves as-is
echo "Part 1:"
preprocess | count_zeros

# Part 2: Expand each move into individual steps
echo "Part 2:"
preprocess | \
    awk '{
        n = $1
        if (n > 0) {
            for (i = 0; i < n; i++) print 1
        } else if (n < 0) {
            for (i = 0; i < -n; i++) print -1
        }
    }' | \
    count_zeros
