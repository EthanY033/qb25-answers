#!/usr/bin/env python3
import random

import numpy as np

num_reads_3 = int(1000000 * 3 / 100)
num_reads_10 = int(1000000 * 10 / 100)
num_reads_30 = int(1000000 * 30 / 100)

## use an array to keep track of the coverage at each position in the genome
genome_coverage_3 = np.zeros((1, 1000000), dtype=int)
genome_coverage_10 = np.zeros((1, 1000000), dtype=int)
genome_coverage_30 = np.zeros((1, 1000000), dtype=int)

for i in range(0, num_reads_3):
    startpos = random.randint(0, 1000000-100+1)
    endpos = startpos + 100
    genome_coverage_3[0, startpos : endpos] += 1
    i += 1
for i in range(0, num_reads_10):
    startpos = random.randint(0, 1000000-100+1)
    endpos = startpos + 100
    genome_coverage_10[0, startpos : endpos] += 1
    i += 1
for i in range(0, num_reads_30):
    startpos = random.randint(0, 1000000-100+1)
    endpos = startpos + 100
    genome_coverage_30[0, startpos : endpos] += 1
    i += 1

output_file = open("genome_coverage_3.txt", 'w')
output_list = []
for i in range(genome_coverage_3.size):
    output_list.append(str(genome_coverage_3[0,i]))
print(" ".join(output_list), file = output_file)
output_file.close()

output_file = open("genome_coverage_10.txt", 'w')
output_list = []
for i in range(genome_coverage_10.size):
    output_list.append(str(genome_coverage_10[0,i]))
print(" ".join(output_list), file = output_file)
output_file.close()

output_file = open("genome_coverage_30.txt", 'w')
output_list = []
for i in range(genome_coverage_30.size):
    output_list.append(str(genome_coverage_30[0,i]))
print(" ".join(output_list), file = output_file)
output_file.close()