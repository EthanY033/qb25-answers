#!/usr/bin/env python3

for line in open("/Users/cmdb/qb25-answers/unix-python-scripts/ce11_genes.bed"):
    line = line.rstrip().split("\t")
    
    new_score = int(line[2]) - int(line[1])
    new_score *= float(line[4])

    if line[5] == "-":
        new_score *= -1
    
    new_line = [line[0], line[1], line[2], line[3], str(new_score), line[-1]]
    print("\t".join(new_line))
