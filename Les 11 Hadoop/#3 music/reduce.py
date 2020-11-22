#!/usr/bin/python3.8
import sys

track_id = None
error_count = 0

total = None
shared = None
radio = None
skip = None

for line in sys.stdin:
    try:
        values = line[:].split('\t')
        if track_id == values[1]:
            total += 1
            shared += int(values[2])
            radio += int(values[3])
            skip += int(values[4])
        else:
            print(f'{track_id}\t{total}\t{shared}\t{radio}\t{skip}')
            track_id = values[1]
            total = 1
            shared = int(values[2])
            radio = int(values[3])
            skip = int(values[4])
    except Exception as e:
        error_count += 1
        print(e)
        print(f'Last TrackId: {track_id}\nError line:"{line}"')

print(f'Number of errors: {error_count}')
    

