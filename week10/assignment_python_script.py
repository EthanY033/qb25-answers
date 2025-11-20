#!/usr/bin/env python3

import sys

import numpy as np

from fasta import readFASTA


#====================#
# Read in parameters #
#====================#

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code


# Read the scoring matrix into a dictionary
sigma_file = sys.argv[2]

fs = open(sigma_file)
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# Read in the actual sequences using readFASTA
fasta_file = sys.argv[1]
input_sequences = readFASTA(open(fasta_file))

seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]

# #####################
# sequence1 = "EEEDENDDLDPEANESDSSDEKKSRMKRKRGRKSKKTEGGNEGEVGDPGACNDAHRAMTNRRTFTKGCKSCVFAAPVFNPDHYRKFHMDLL"
# sequence2 = "EPEIEVAPEEEEENDDLDPEANEESDSSDEKKSRMKRKRGRKSKKTEGGNEGEVGDPGACNDAHRAMTNRRTFTKGCKSCVFAAPVFNPDHYRKFHMDLL"
# #####################

gap_penalty = int(sys.argv[3])
out_file = sys.argv[4]

#=====================#
# Initialize F matrix #
#=====================#

f_matrix = np.zeros((len(sequence1) + 1, len(sequence2) + 1), dtype=int)

#=============================#
# Initialize Traceback Matrix #
#=============================#

trace_matrix = np.zeros((len(sequence1) + 1, len(sequence2) + 1), dtype=int)

#===================#
# Populate Matrices #
#===================#

# Populating the F and traceback matrices:
for i in range(1, len(sequence2) + 1):
	f_matrix[0,i] = gap_penalty + f_matrix[0,i-1]
	trace_matrix[0,i] = 2

for i in reversed(range(1, len(sequence1) + 1)):
	f_matrix[i,0] = gap_penalty + f_matrix[i-1,0]
	trace_matrix[i,0] = 3

for i in range(1, len(sequence1) + 1):
	for j in reversed(range(1, len(sequence2) + 1)):
		v_score = gap_penalty + f_matrix[i-1, j]
		h_score = gap_penalty + f_matrix[i, j-1]
		nucleotide = (sequence1[i-1], sequence2[j-1])

		d_score = sigma[nucleotide] + f_matrix[i-1, j-1]

		f_matrix[i,j] = max(v_score, h_score, d_score)

		if max(v_score, h_score, d_score) == d_score:
			trace_matrix[i,j] = 1
		else:
			if max(v_score, h_score, d_score) == h_score:
				trace_matrix[i,j] = 2
			else:
				trace_matrix[i,j] = 3


#========================================#
# Follow traceback to generate alignment #
#========================================#

# The aligned sequences are assumed to be strings named sequence1_alignment
# and sequence2_alignment in later code

i_align = len(sequence1)
j_align = len(sequence2)
sequence1_alignment = ""
sequence2_alignment = ""

while i_align + j_align > 0:
	traceback = trace_matrix[i_align,j_align]

	if traceback == 1:
		sequence1_alignment += sequence1[i_align - 1]
		sequence2_alignment += sequence2[j_align - 1]
		i_align -= 1
		j_align -= 1

	if traceback == 2:
		sequence1_alignment += "-"
		sequence2_alignment += sequence2[j_align - 1]
		j_align -= 1
	
	if traceback == 3:
		sequence1_alignment += sequence1[i_align - 1]
		sequence2_alignment += "-"
		i_align -= 1


#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '

#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

output = open(out_file, 'w')

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_alignment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')

#======================#
# Print alignment info #
#======================#

# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score

print("The number of gaps in", seq1_id, ":", sequence1_alignment.count("-"), file = output)
print("The number of gaps in", seq2_id, ":", sequence2_alignment.count("-"), file = output)

#=============================#
# Calculate sequence identity #
#=============================#

print("The number of gaps in", seq1_id, ":", identity_alignment.count("|") / len(sequence1), file = output)
print("The number of gaps in", seq2_id, ":", identity_alignment.count("|") / len(sequence2), file = output)
print("The score of the alignment:", f_matrix[len(sequence1), len(sequence2)], file = output)
