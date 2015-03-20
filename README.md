##Getting and Cleaning Data Course Project ReadMe
===============================================

This is the ReadMe file for the Coursera Getting and Cleaning Data course project. 

###Loading the Data

* Running the R script run_analysis.R (using the source() command) in your R working directory will automatically download the UCI HAR dataset to your working directory, unzip, and then read in the data to the appropriate frames.
* The run_analysis.R script will create several data frames in R for merging, extracting mean and standard deviation measurements, filling in descriptive activity names, appropriately labelling the data and creating a tidy dataset.
* The final tidy output data will be contained within the file "tidy_dataset.txt" which will be output to your R working directory.
* The script will not process the final output if the original input data (UCI HAR dataset) is not detected in the working directory, in this case see the manual instructions below.

###Manually Acquire the Data

* Download the UCI HAR Dataset from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Unzip the UCI HAR Dataset folder into your R working directory. Set the working directory using the setwd() command or the session menu in R studio.
* Download the final output file "tidy_dataset.txt" (https://github.com/jg-123/Getting_And_Cleaning_Data_Project/blob/master/tidy_dataset.txt) if desired.
* Use the command tidy_dataset<-read.table("tidy_dataset.txt", header=TRUE) to manually read in the final tidy output dataset from this repository if you do not want to run the run_analysis.R script.
* Place run_analysis.R into your working directory and source it to have the script create the final output dataset if desired.

###Codebook

* Also provided in this repository is a Codebook.md file which contains the descriptions and units of all the data in the provided tidy dataset and all of the required transformations to create this data from the original UCI dataset.
* The final tidy dataset contains 180 rows (30 subjects and 6 activities, so 180 total rows which also contain the relevant mean and standard deviation data for those subject/activity combinations) and 88 variables (all columns from the original dataset which contained the words "mean" and "std" were extracted for a total of 86, plus the subject and activity for 88)