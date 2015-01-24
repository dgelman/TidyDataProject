---
title: "CodeBook.md"
author: "David Gelman"
date: "Thursday, January 22, 2015"
output: html_document
---
  
#### Purpose of document
The purpose of this code book is to explain the variables in the tidydata.txt, a text file with comma-separated data (details described below). The original source of these variables and methods used to transform them into their final format.


#### Original source
The source of the data in tidydata.txt is the Human Activity Recognition Using Smartphones Dataset Version 1.0 dataset from the University of California Irvine. The license for use of this data is at the bottom of the document. This data was collected by the scientists listed below. 

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Università degli Studi di Genova  
Via Opera Pia 11A, I-16145, Genoa, Italy  
activityrecognition@smartlab.ws  
www.smartlab.ws  

In brief, this dataset consists of data obtained from 30 volunteers engaged in 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a cellphone with a gyroscope and accelerometer. The data collected consisted of measurements of 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

A full description of the original dataset is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original dataset for the project is located here:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

For more information about this dataset contact: activityrecognition@smartlab.ws

#### Current structure of tidydata.txt
The tidydata.txt is structured as a comma-separated value text document. Each row consists of one value - the mean of a given measurement for a specific subject performing a specific activity. Each column consists of one variable. 

Tidydata.txt consists of data arranged into the following 5 columns:

1. subject_ID  
  + ID of each participant, numbered 1 to 30  
  + Source: /test/subject_test.txt and /train/subject_train.txt files  
  + Units: unitless  

2. subject_type  
+ Subjects were grouped into test or training groups so that prediction models could be trained and then tested on separate individuals' data. This column holds the value of "test" or "train"
+ source: column was added to data (see README.md), with subjects from the subject_test.txt file getting the value "test" and subjects from the /train/subject_train.txt getting the value "train" prior to merging these two subsets of subjects
+ Units: unitless

3. activity_type
+ Text description of one of the six different physical behaviors engaged in by subject; (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
+ Source: Initial source of data were the /test/y_test.txt and /train/y_train.txt files. These files contained number values from 1 to 6 that correlated to behaviors according to the /activity_labels.txt file. This column was constructed by converting the numeric values to the corresponding text descriptions
+ Units: unitless

4. test_type
+ Text delineating what features of movement were captured by the measurement.
+ Source: The names of the features (now named test_types) came from the /features.txt file. There were originally 561 features recorded per subject throughout each activity performed. This vector of 561 terms was matched to the 561 fixed-width columns in /test/subject_test.txt and /train/subject_train.txt files.  The test_types included in the final tidydata.txt file were (by project specification) a subset of the original 561 values: only those that themselves were measurements of means or standard deviation values in the original dataset were included. Please refer to "Further description of test types" below for a clearer understanding of this column's data.
+ Units: unitless

5. meanOfMeasurements
+ Mean of multiple measurements of specific test_type taken of given subject during given activity. 
+ Source: Calculated by ddply function, obtaining the mean of groups of measurements for which the other columns were equal (subject_id, activity_type, test_type)
+ Units: unitless. The values are normalized and bounded within [-1,1].

  
#### Further description of test_types
Here is reproduced, in full, the /features_info.txt file from the UCI HAR Dataset.

##### Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal  
kurtosis(): kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in 'features.txt'

####License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
