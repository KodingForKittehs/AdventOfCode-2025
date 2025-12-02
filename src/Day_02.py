# pylint: disable=W0611, C0116, C0413
# ruff: noqa: F401
import sys
sys.path.append("./")
import src.kittehs_funkollection as kf

inp = "input.txt"

def is_invalid_p1(s):
    if s[0:len(s)//2] == s[len(s)//2:]:
        return True
    return False

def is_invalid_p2(s):
    n = len(s)
    for length in range(1, n//2 + 1):
        if n % length == 0:
            pattern = s[:length]
            if pattern * (n // length) == s:
                return True
    return False

def get_invalid_in_range(a, b):
    invalids = set()
    invalids_p2 = set()
    for i in range(a, b + 1):
        s = str(i)
        if is_invalid_p1(s):
            invalids.add(i)
        if is_invalid_p2(s):
            invalids_p2.add(i)
    return invalids, invalids_p2

intervals = kf.eat(inp)[0].split(",")
p1 = set()
p2 = set()
for interval in intervals:
    print(interval)
    vals = interval.split("-")
    a = int(vals[0])
    b = int(vals[1])
    (p1_part, p2_part) = get_invalid_in_range(a, b)
    p1.update(p1_part)
    p2.update(p2_part)

print("Part 1:", sum(p1))
print("Part 2:", sum(p2))
