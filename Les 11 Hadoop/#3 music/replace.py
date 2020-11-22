#!/usr/bin/python3.8
import sys


for line in sys.stdin:
        print(line.replace('|', '\t'), end='')

