#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1])
contigs = fasta.FASTAReader(my_file)

num = 0
genome_len = 0
for ident, sequence in contigs:
    num += 1
    genome_len += len(sequence)

print("Number of contigs:", num)
print("Total length:", genome_len)
print("Average length:", round(genome_len / num, 2))

my_file.close()