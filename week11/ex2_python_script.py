#!/usr/bin/env python3

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
k = 3

output_file = open("de_Bruijn_ends.dot", 'w')
output_list = []

for read in reads:
    for i in range(len(read) - k):
        kmer1 = read[i: i+k]
        kmer2 = read[i+1: i+1+k]
        output_list.append(f"{kmer1} -> {kmer2}")

print("digraph {", file = output_file)
for edge in output_list:
    print(edge, file = output_file)
print("}", file = output_file)
output_file.close()