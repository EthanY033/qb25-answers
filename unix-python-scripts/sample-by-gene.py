#!/usr/bin/env python3

# Open the file
fs = open("GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct")

# Skip the first two lines
_ = fs.readline()
_ = fs.readline()

# Capture the header and the first data line
header = fs.readline()
header = header.split("\t")
data = fs.readline()
data = data.split("\t")

# Build the dictionary
dictionary = {}
for i in range(len(header)):
    dictionary[header[i]] = data[i]

fs.close()

# Step through the second file
count = 0
for line in open("GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt"):
    line = line.rstrip().split("\t")
    if line[0] in dictionary.keys():
        # print out the SAMPID, expression, and SMTSD
        print(line[0], dictionary[line[0]], line[6])
    else:
        continue

print("The first three tissues that have >0 expression:")
count = 0
for line in open("GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt"):
    line = line.rstrip().split("\t")
    if line[0] in dictionary.keys():
        if float(dictionary[line[0]]) > 0 and count < 3:
            print(line[0], dictionary[line[0]], line[6])
            count += 1
