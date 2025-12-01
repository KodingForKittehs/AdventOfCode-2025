#!/bin/bash

# Part 1
cat "input.txt" | \
    tr 'L' '-' | \
    tr 'R' '+' | \
    awk -v c=50 '{c=(c+$0)%100;p+=(c==0?1:0)} END {print p}'

# Part 2
cat "input.txt" | \
    tr 'L' '-' | \
    tr 'R' '+' | \
    awk '{
        n = $1
        if (n > 0) {
            for (i = 0; i < n; i++) print 1
        } else if (n < 0) {
            for (i = 0; i < -n; i++) print -1
        }
    }' | \
    awk -v c=50 '{c=(c+$0)%100;p+=(c==0?1:0)} END {print p}'
