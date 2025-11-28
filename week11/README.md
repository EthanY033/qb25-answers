**Step 1.1**    
How many 100bp reads are needed to sequence a 1Mbp genome to 3x coverage?    
    
1Mbp x 3 / 100bp = 30k    
    
Therefore, 30k 100bp reads are needed to sequence a 1Mbp genome to 3x coverage.    
    
     
**Step 1.3**   
Note that for both of these, this will give you the probability of observing each coverage. What do we need to do to transform these probabilities into a frequency count comparable to those in our histogram?    
    
For Poisson distribution, we can multiply the probability with the total length, then we can get the expected number of each coverage.     
    
For normal distribution, as there are values under zero, we firstly normalize the probabilities of getting values above zero to one. Then, we use Cumulative Distribution Function (CDF, the integration of PDF) to calculate the probablities of each coverage, while for coverage n, the probablities of n = CDF(n + 0.5) - CDF(n - 0.5). Finally we can multiply the probability with the total length, then we can get the expected number of each coverage.    
    
    
**Step 1.4**    
1. In your simulation, how much of the genome has not been sequenced (has 0x coverage)?   
     
50889 nucleotides are not sequenced, which accounts for 5.0889% of the genome.    
     
2. How well does this match Poisson expectations? How well does the normal distribution fit the data?    
    
The simulated data matches Poisson distribution almost perfectly, but there are some deviations between the simulated data and the normal distribution on coverages 3-5.   
    
    
**Step 1.5**    
1. In your simulation, how much of the genome has not been sequenced (has 0x coverage)?   
     
107 nucleotides are not sequenced, which accounts for 0.0107% of the genome.    
     
2. How well does this match Poisson expectations? How well does the normal distribution fit the data?    
    
The simulated data matches Poisson distribution almost perfectly, but there are some deviations between the simulated data and the normal distribution on coverages 10-15.   
   
    
**Step 1.6**    
1. In your simulation, how much of the genome has not been sequenced (has 0x coverage)?   
     
3 nucleotides are not sequenced, which accounts for 0.0003% of the genome.    
     
2. How well does this match Poisson expectations? How well does the normal distribution fit the data?    
    
The simulated data matches Poisson distribution almost perfectly, but there are some deviations between the simulated data and the normal distribution on coverages 28-39.  