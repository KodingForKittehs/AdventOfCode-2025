#!/bin/bash

cz () { awk -v c=50 -v pt=$1 '{c=(c+$0)%100;p+=(c==0?1:0)} END {print "Part " pt ": " p}'; }
poo () { awk '{d=$1>0?1:-1;for(i=0;i<d*$1;i++) print d}'; }

cat "input.txt" | tr 'L' '-' | tr 'R' '+' | tee \
>(cz 1) \
>(poo | cz 2) \
> /dev/null