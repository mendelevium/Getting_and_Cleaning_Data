###Getting and Cleaning Data: Course Project

This file describes use run_analysis.R script
* Use the command `source("run_analysis.R")` command in RStudio. This will create a Data directory in your workspace and download automatically the dataset and then clean it.
* You will find two output files are generated in the Data directory located in your workspace:
  - merged_data.txt (~8 Mb): it contains a data frame called cleanedData with 10299*68 dimension.
  - data_with_means.txt (~200 Kb): it contains a data frame called result with 180*68 dimension.
* If you want to play furthur with the data use sometable <- read.table("data_with_means.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features. 
