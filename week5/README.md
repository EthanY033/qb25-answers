**Question in Step 2.2**   
1. What is the “size” (i.e., slope) of this relationship? Interpret the slope in plain language. Does it match your plot?    
    
The slope of this relationship is 0.37757. The slope means that in this model, for every additional year of maternal age, the expected number of maternal DNM increases by 0.378. It matches with the plot.   
    
   
2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.     
    
This relationship is significant due to small p values of slope and intercept. The p value refers to the possibility of getting such a relationship between maternal age and maternal DNM numbers just by random chance, with no actual relationship between two variables and the null hypothesis is true. The p value of intercept is smaller than 0.05 and p value of slope is smaller than 0.001, meaning that the relationship is significant.   
   


**Question in Step 2.3**     
1. What is the “size” (i.e., slope) of this relationship? Interpret the slope in plain language. Does it match your plot?    
    
The slope of this relationship is 1.35384. The slope means that in this model, for every additional year of paternal age, the expected number of paternal DNM increases by 1.35384. It matches with the plot.   
    
   
2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.     
    
This relationship is significant due to small p values of slope and intercept. The p value refers to the possibility of getting such a relationship between paternal age and paternal DNM numbers just by random chance, with no actual relationship between two variables and the null hypothesis is true. The p value of both intercept and slope are smaller than 0.001, meaning that the relationship is very significant.    
      
     
     
**Question in Step 2.4**   
Use the paternal regression model to predict the expected number of paternal DNMs for a father of age 50.5.   
    
Code using predict() function to calculate the result is shown in R_script.R file.   
The prediction() function gives the result 78.69546. Given that the number of DNMs must be an integer, the expected number of paternal DNMs for a father of age 50.5 is **79**.   
   
   
   
**Question in Step 2.6**    
1. What is the “size” of this relationship (i.e., the average difference in counts of maternal and paternal DNMs)? Interpret the difference in plain language. Does it match your plot?    
   
The mean difference in counts of maternal and paternal DNMs is 39.23485. Explanation: the population mean of paternal DNMs is 39.23485 higher than the population mean of maternal DNMs. It matches with the plot.   
   

2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.   
   
This relationship is significant due to small p value. The p value refers to the possibility of getting such a difference between the population means of paternal and paternal DNMs just by random chance, with no actual difference between two population means and the null hypothesis is true. The p value of paired t-test is smaller than 0.001, meaning that the difference is very significant.    
   

3. Fit this model using lm() and compare to the results of the paired t-test. How would you interpret the coefficient estimate for the intercept term?   
   
The model fit is calcluated in the R_script.R file.   
The intercept given by lm() is 39.2348, very close to the mean difference given by t-test. This intercept refers to the difference between the population means of maternal and paternal DNMs. As this intercept is positive, it means that the population mean of paternal DNMs is 39.2348 higher than the population mean of maternal DNMs.   
The p value of the intercept is smaller than 0.001, meaning that the difference is very significant.  
     


**Exercise 3.1**   
The dataset chosen: The History of Himalayan Mountaineering Expeditions.  
   
   
**Exercise 3.2**   
Distributions of defense points vs. height and defense points vs. attack points are explored and plotted.   
   
   
**Exercise 3.3**   
Hypothesis: the distribution of defense points vs. attack points follows linear model.   
Results: the p values of slope and intercept are smaller than 0.001, meaning that they are highly significant. However, the adjusted R-squared is 0.1924, meaning that this distribution poorly fit a linear model. Therefore, the distribution of defense points vs. attack points don't follow linear model. 