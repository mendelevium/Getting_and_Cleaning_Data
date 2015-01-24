###Getting and Cleaning Data: Course Project CodeBook

This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  

* The site where the data was obtained:  
`http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones`      
The data for the project:  
`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip` 

* The run_analysis.R script performs the following steps to clean the data:   
 1) Join *testData* to *trainData* to generate a 10299x561 data frame, *joinData*; concatenate *testLabel* to *trainLabel* to generate a 10299x1 data frame, *joinLabel*; concatenate *testSubject* to *trainSubject* to generate a 10299x1 data frame, *joinSubject*.  
 2) Read the `features.txt` file and store the data in a variable called *features*. We only extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of *joinData* with the 66 corresponding columns.  
 3) Clean the column names of the subset. ("()" and "-" etc.).  
 4) Clean the activity names in the second column of *activity*. (lowercase, "_", etc.).  
 5) Combine the *joinSubject*, *joinLabel* and *joinData* by column to get a new cleaned 10299x68 data frame, *cleanedData*.   Properly name the first two columns, "subject" and "activity".  
 6) Write the *cleanedData* out to `merged_data.txt` file in current working directory.  
 7) Generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two.  
 8) Write the *result* out to `data_with_means.txt` file in current working directory.  
