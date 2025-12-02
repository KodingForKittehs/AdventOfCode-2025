#!/bin/bash

expand () { awk '{for(i=$1;i<=$2;i++) print i}'; }
invalid_p1 () { awk '{hl=length($1)/2;s+=substr($1,1,hl)==substr($1,hl+1)?$1:0} END {print "Part 1:", s}'; }

invalid_p2 () {
    awk '{
        s = $1
        n = length(s)
        for (length_val = 1; length_val <= n/2; length_val++) {
            if (n % length_val == 0) {
                pattern = substr(s, 1, length_val)
                repeated = ""
                for (i = 0; i < n / length_val; i++) {
                    repeated = repeated pattern
                }
                if (repeated == s) {
                    sum += s
                    next
                }
            }
        }
    } END {print "Part 2:", sum}'
}


cat "input.txt" | tr ',' '\n' | tr '-' ' ' | expand | tee \
>(invalid_p1) \
>(invalid_p2) \
>/dev/null

