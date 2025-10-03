#!/usr/bin/env python3

import sys

sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
              "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

output_file = open("gt_long.txt", "w")
print("Sample ID\tChromosome\tPosition\tGenotype", file = output_file)

for line in open(sys.argv[1]):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')

    # grab what you need from `fields`
    chrom = fields[0]
    pos = fields[1]

    # Write the output to a file
    for i in range(len(sample_ids)):
        ID = sample_ids[i]
        GT = fields[i + 9].split(":")[0]
        print(ID, chrom, pos, GT, sep = "\t", file = output_file)

output_file.close()