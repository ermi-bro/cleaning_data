## This file describes step by step how run_analysis.R script works. I have organized the script into three main parts as explained below:
## 1) Data preparation
## - Downloaded the assignment data files from specified website into local working directory.
## - Open the training dataset along with training label file in R
## - Explore and check if the datasets are properly loaded into R
## - Compile training dataset and training label file together using cbind command
## - Open the test dataset along with test label file in R
## - Explore and check if the datasets are properly loaded into R
## - Compile test dataset and test label file together using cbind command

## 2) Merge training and test datasets
## - There two variables with same variable names (“V1”) in training and test data files that comes from label data, we should rename variable that comes from label data as “activity”.  
## - Merge training and test datasets using rbind command named the merged dataset as “fullData”
## - Check if the two datasets are properly merged using dim() command

## 3) Extracts only the measurements on the mean and standard deviation for each measurement
## - Create a numeric vector (varNum) that will be used to extract means and standard deviation for each measurements
## - Extract variables from “fullData” using for loop and varNum vector. 
## - Name extract dataset as “meanSdData”

## 4) Uses descriptive activity names to name the activities in the data set	
