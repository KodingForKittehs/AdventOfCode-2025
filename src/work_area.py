# pylint: disable=W0611, C0116, C0413, C0114
# ruff: noqa: F401
import sys
sys.path.append("./")
import src.kittehs_funkollection as kf

INPUT_FILE = "input.txt"

lines = kf.eat(INPUT_FILE)
kf.print_grid(lines)
