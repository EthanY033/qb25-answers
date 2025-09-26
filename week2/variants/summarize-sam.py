#!/usr/bin/env python3

import sys

rnames_dict = {}
mismatch_dict = {}

# Read the sam file
for line in open(sys.argv[1]):
    line = line.rstrip().split("\t")

    #Skip the lines begining with @
    if "@" in line[0]:
        continue

    # Build dictionary and count alignments
    if line[2] not in rnames_dict.keys():
        rnames_dict[line[2]] = 0
    rnames_dict[line[2]] += 1

    # Count mismatch number
    for item in line:
        if "NM:i:" in item:
            NM_num = int(item[5:])

            if NM_num not in mismatch_dict.keys():
                mismatch_dict[NM_num] = 0
            mismatch_dict[NM_num] += 1

# Sort dictionary mismatch_dict
mismatch_dict = dict(sorted(mismatch_dict.items()))

# Print the result
output = open("summarize-sam.txt", "w")

for chro in rnames_dict.keys():
    print(chro, rnames_dict[chro], file = output)

for mis in mismatch_dict.keys():
    print(mis, mismatch_dict[mis], file = output)

output.close()