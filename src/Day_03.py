# pylint: disable=W0611, C0116, C0413, C0114
# ruff: noqa: F401
from functools import lru_cache
import sys
sys.path.append("./")
import src.kittehs_funkollection as kf

INPUT_FILE = "input.txt"

lines = kf.eat(INPUT_FILE)
kf.print_grid(lines)

def get_joltage(row):
    max = 0
    sz = len(row)
    for i in range(sz):
        for j in range(i + 1, sz):
            if int(row[i]) * 10 + int(row[j]) > max:
                max = int(row[i]) * 10 + int(row[j])
    print("Max joltages in row", row, "is", max)
    return max

@lru_cache(maxsize=None)
def get_joltage_p2(row, size=12):
    if size == 0:
        return 0
    if len(row) == size:
        sum = 0
        for i in range(size):
            sum += int(row[i]) * pow(10, size - i - 1)
        return sum
    jolt_selected = int(row[0])*pow(10, size - 1) + get_joltage_p2(row[1:], size - 1)
    jolt_not_selected = get_joltage_p2(row[1:], size)
    return jolt_not_selected if jolt_not_selected > jolt_selected else jolt_selected

p1, p2 = 0, 0
for row in lines:
    p1 += get_joltage(row)
    p2 += get_joltage_p2(row)

print("p1:", p1)
print("p2:", p2)
