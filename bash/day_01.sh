#!/bin/bash

cz () { awk -v c=50 '{c=(c+$0)%100;p+=(c==0?1:0)} END {print p}'; }
poo () { awk '{d = $1 > 0 ? 1 : -1; for (i = 0; i < d * $1; i++) print d}'; }

cat "input.txt" | tr 'L' '-' | tr 'R' '+' | tee \
>(echo Part 1: $(cz)) \
>(poo | echo Part 2: $(cz)) \
> /dev/null