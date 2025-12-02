#!/bin/bash

count_zeros() {
    awk -v c=50 '{c=(c+$0)%100;p+=(c==0?1:0)} END {print p}'
}

cat "input.txt" | tr 'L' '-' | tr 'R' '+' | tee >(
    echo Part 1: "$(count_zeros)" > /dev/tty
) | \
    awk '{
        n = $1
        if (n > 0) {
            for (i = 0; i < n; i++) print 1
        } else if (n < 0) {
            for (i = 0; i < -n; i++) print -1
        }
    }' | echo Part 2: "$(count_zeros)" > /dev/tty
