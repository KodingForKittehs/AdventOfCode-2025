#!/bin/bash

count_cycles () { awk -v c=50 -v pt=$1 '{c=(c+$0)%100;p+=(c==0?1:0)} END {print "Part " pt ": " p}'; }
expand_moves () { awk '{d=$1>0?1:-1;for(i=0;i<d*$1;i++) print d}'; }

cat "input.txt" | tr 'L' '-' | tr 'R' '+' | tee \
>(count_cycles 1) \
>(expand_moves | count_cycles 2) \
> /dev/null