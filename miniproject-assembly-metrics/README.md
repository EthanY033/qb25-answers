**My Mini Project**  
   
This is the start of my first mini project

**URL links for the Genomic Sequence (FASTA)**:   
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248909/caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa.gz   
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248911/caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa.gz   
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA53967/caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa.gz   
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA577507/caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa.gz   
   
**File sizes**:   
120564187 caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa   
126639400 caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa   
147929855 caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa   
132662265 caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa   
   
**Instructions**:   
The assembly-metrics.py is used for counting the number of contigs, total length, and average length of a .fa file.    
Input: assembly-metrics.py expects a .fasta file as an argument   
Format of command: ./assembly-metrics.py sequences.fa   
Output:     
Number of contigs: ###   
Total length: ###   
Average length: ###   
    
**Sample commands and outputs**:    
./assembly-metrics.py caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa   
Number of contigs: 1591   
Total length: 118549266   
Average length: 74512.42   
    
./assembly-metrics.py caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa   
Number of contigs: 912   
Total length: 124541912   
Average length: 136559.11   
    
./assembly-metrics.py caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa   
Number of contigs: 3670   
Total length: 145442736   
Average length: 39630.17   
    
./assembly-metrics.py caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa   
Number of contigs: 187   
Total length: 130480874   
Average length: 697758.68   