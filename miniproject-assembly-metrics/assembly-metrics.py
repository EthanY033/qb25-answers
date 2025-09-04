#!/usr/bin/env python3

import sys
import fasta

# Read the fasta file
my_file = open(sys.argv[1])
contigs = fasta.FASTAReader(my_file)

# Step through the contigs
num = 0
genome_len = 0
lengths = []
for ident, sequence in contigs:
    num += 1
    genome_len += len(sequence)
    lengths.append(len(sequence))

# Output of exercise 4
print("Number of contigs:", num)
print("Total length:", genome_len)
print("Average length:", round(genome_len / num, 2))

# Codes for exercise 5
lengths.sort(reverse=True)

sum_lengths = 0
for item in lengths:
    sum_lengths += item
    if sum_lengths > genome_len / 2:
        print("Sequence length of the shortest contig at 50% of the total assembly length:", item)
        break

my_file.close()