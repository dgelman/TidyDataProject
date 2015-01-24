---
title: "README.md"
author: "David Gelman"
date: "Thursday, January 22, 2015"
output: html_document
---

The purpose of this document is to explain the run_analysis.R R-language script within this project.

Background: This project seeks to analyze data from the UCI HAR Dataset as part of the Getting and Cleaning Data course at Coursera.org with instructors Jeff Leek, PhD, Roger D. Peng, PhD, and Brian Caffo, PhD of Johns Hopkins Bloomberg School of Public Health. The data being processed here represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Here are the steps performed during the execution of the run_analysis.R script.

1. Install and load requisite packages, dplyr and tidyr
2. From working directory, test if file named "project", and if not, create this file
3. Change the working directory to the file "project"
4. Download the UCI HAR Dataset and unzip file to project directory
5. Read in the following files to dataframes: x_test.txt, subject_test.txt, x_train.txt, subject_train.txt, features.txt
6. Set the column names of the main two datasets (x_test and x_train) to the names of the actual tests performed, noted in the features.txt file
7. Load into dataframes the files y_test.txt and y_train.txt which contain code numbers which correlate with physical activities (laying, walking, etc) noted in the activity_labels.txt file. This latter file was not loaded in, but was referenced in the construction of the next processing step.
8. Mapped the numeric values in y_test and y_train dataframes to actual textural descriptions of the activities performed
9. Bind subject_id and subject_type columns to test data files
10. Add "subject_type" column to dataframes to denote type of subject (test or train)
11. Add column "activity_type" to dataframes to denote 
12. Merge test and training data
13. Subset out only the newly created columns from prior steps and the columns which contain measurements of mean or standard deviation values
14. Tidy data by ordering merged data by subject_id and activity_type, then create long/tall tidy dataset by moving all measurements into two rows of data: a test_type row which will take the name of the type of measurement being performed (like tBodyAcc-Mean-x, etc) and a second column with the value of these measurements (named measurement)
15. Ensure that the columns that are factors are designated as such
16. At this point, the data is a tall/skinnny tidy dataset with the following properties obtained by str(x_tidy):
    + 'data.frame':    885714 obs. of  5 variables:
    + $ subject_id   : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
    + $ subject_type : Factor w/ 2 levels "test","train": 2 2 2 2 2 2 2 2 2 2 ...
    + $ activity_type: Factor w/ 6 levels "laying","sitting",..: 3 3 3 3 3 3 3 3 3 3 ...
    + $ test_type    : Factor w/ 86 levels "tBodyAcc-mean()-X",..: 1 1 1 1 1 1 1 1 1 1 ...
    + $ measurement  : num  0.289 0.278 0.28 0.279 0.277 ...
17. Create a second, independent tidy dataset with the average of each variable by activity and subject with the name tidy_finalmeans, which was the goal of the project
18. Write tidy dataset to file named tidydata.txt without row names. This is structured as a comma-separated value file.