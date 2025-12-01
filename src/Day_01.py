# pylint: disable=W0611, C0116, C0413
# ruff: noqa: F401
import sys
sys.path.append("./")
import src.kittehs_funkollection as kf


def get_password(inp):
    curr = 50
    password1 = 0
    password2 = 0
    for line in kf.eat(inp):
        dirn = -1 if line[0] == "L" else 1
        steps = int(line[1:])
        for _ in range(steps):
            curr = (curr + dirn) % 100
            if curr == 0:
                password2 += 1
        if curr == 0:
            password1 += 1
    return password1, password2

print(get_password("input.txt"))
