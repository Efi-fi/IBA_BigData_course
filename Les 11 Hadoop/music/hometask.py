import sys

tr_stat = {}

for row in sys.stdin:
    values = row.split('|')
    if len(values) == 5:
        tr_id = values[0]
        try:
            tr_stat[tr_id]['total'] += 1
            tr_stat[tr_id]['shared'] += int(values[2])
            tr_stat[tr_id]['radio'] += int(values[3])
            tr_stat[tr_id]['skip'] += int(values[4])
        except:
            tr_stat[tr_id] = dict()
            tr_stat[tr_id]['total'] = 1
            tr_stat[tr_id]['shared'] = int(values[2])
            tr_stat[tr_id]['radio'] = int(values[3])
            tr_stat[tr_id]['skip'] = int(values[4])

from pprint import pprint
pprint(tr_stat)

