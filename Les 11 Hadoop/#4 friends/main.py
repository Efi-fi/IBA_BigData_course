#!/usr/bin/python3.8
import sys


for line in sys.stdin:
    print('-' *100)
    count = 0
    for line in sys.stdin:
        names = line.split("->")
        user = names[0].strip()
        friends = names[1][1:-1].split(" ")
        count += 1
        print(count)
