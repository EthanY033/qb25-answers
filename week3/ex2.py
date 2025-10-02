#!/usr/bin/env python3

import sys

AF_list = []
DP_list = []

for line in open(sys.argv[1]):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')

    # grab what you need from `fields`
    info = fields[7].split(";")
    AF = float(info[3][3:])
    AF_list.append(AF)

    for sample_data in fields[9:]:
        DP = int(sample_data.split(":")[2])
        DP_list.append(DP)



# Output result
AF_file = open("AF.txt", "w")
print("Allele Frequencies (AF)", file = AF_file)
for item_AF in AF_list:
    print(item_AF, file = AF_file)
AF_file.close()

DP_file = open("DP.txt", "w")
print("Read Depths (DP)", file = DP_file)
for item_DP in DP_list:
    print(item_DP, file = DP_file)
DP_file.close()
