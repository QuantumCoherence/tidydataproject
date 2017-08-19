# Peer-graded Assignment: 
# Getting and Cleaning Data Course Project
================================================================

Author: Paolo Bernasconi
Date:   Wednesday,  August  16,  2017

## Project Description
Collect, work with, and clean a data set from the  
"Human Activity Recognition Using Smartphones" Dataset

## Study design and data processing

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Collection of the raw data
Orignal Dataset source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Notes on the original (raw) data 
Refer to the Readme.txt file included in the above dataset for details.

### Creating the tidy datafile
IMPORTANT NOTE on point 3. of the "Study Design and data processing":

The raw data set includes data collected from the sensors embedded in a cellphone. Specifically it includes data from a three axis gyroscope and a three axis accelerometer. 

In the context of this project, we are requested to extract only "the mean and standard deviation for each measurement".

The features_info.txt file of the original data describes all the 561 provided variables in details, of which only 18 meet the requirements of point 3.

To understand what are measurements in this context, it is useful to consider that gyroscopes and accelerometer measure acceleration and rotation rate in the time domain on three perpendicular axes for each sensor. 

In the raw dataset these measurements are first digitally filtered to eliminate noise.
The acceleration measurements are then by mean of frequency analysis separated in body and gravity accelerations. 

In total only nine entities are directly measured: three from the body acceleration (one for each axis),  three from the gravity acceleration (one for each axis) and three from the gyroscope rotation rates (one for each axis). 

Any other further processing of the data is a derived entity and therefore outside of the scope of this project.  As we are interested only in the standard deviation and mean of these nine measurements, we only have to extract  18 variables from the 561 available. 

The code of the script run_analysis.R that extracts the requested data is on lines 50 to 62 of the run_analysis.R code. 

The reader is advised to make use of the comments in the code for a detailed understanding.

The actual names of the variables from the raw data set that are extracted are:

X|Y|Z
-|-|-
tBodyAcc-mean()-X | tBodyAcc-mean()-Y |tBodyAcc-mean()-Z
tBodyAcc-std()-X|tBodyAcc-std()-Y|tBodyAcc-std()-Z
tGravityAcc-mean()-X|tGravityAcc-mean()-Y|tGravityAcc-mean()-Z
tGravityAcc-std()-X|tGravityAcc-std()-Y|tGravityAcc-std()-Z
tBodyGyro-mean()-X|tBodyGyro-mean()-Y|tBodyGyro-mean()-Z
tBodyGyro-std()-X|tBodyGyro-std()-Y|tBodyGyro-std()-Z


## Guide to create the tidy data file
Refer to the Readme.md file included in this repository for detailed instructions on how to use the included R script to create the tidy data files.
Two data files are created by the provided R script, "run_analysis.R". They are two copies of the same data, one in text format and the other in binary format. Since most of the data included are of numeric  type (double type in fact),  it is more convenient to have files in binary data form, so to guarantee no loss of numerical precision when loading the data. 
However, for compatibility, a text only version is also provided. 

### Cleaning of the data
1. Extract in a local folder of your choice the run_analysis.R file
2. Extract the original data you have downloaded from the above address into a local folder of
    your choice 
3. run_analysis.R expects one text parameter with the folder name where the original data have been extracted. By default, the parameter is set to an empty string, indicating to look for the original data set files in the local folder where the run_analysis.R is run from. 
The run_analysis.R returns a "data.frame" with the tidy data described here below.
it also saves the data frame in the files 
"averagedDataSet.rda" in binary form and  
"averagedDataSet.csv"  in csv text form. 

## Description of the variables 
The data set includes 180 observations of 20 variables.
               
             
### Activty

-  Class "Character"
 - 6 levels :  "LAYING"
        "SITTING"
        "STANDING"
        "WALKING"
        "WALKING_DOWNSTAIRS"
        "WALKING_UPSTAIRS"  
- Unit of measurement : described the type of activity performed while data were collected
### Subject_ID

- Class "integer"
- 30 levels: 1:30
- Unique ID number indentifying the individual, who was performing the activity

### AveragedMeanBodyAccX

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the body acceleration measured by the axis X of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedMeanBodyAccY

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the body acceleration measured by the axis Y of the accelerometer sensor", averaged over a specific activity and subject.
  
### AveragedMeanBodyAccZ

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the body acceleration measured by the axis Z of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedStdDevBodyAccX

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the body acceleration measured by the axis X of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedStdDevBodyAccY

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the body acceleration measured by the axis Y of the accelerometer sensor", averaged over a specific activity and subject.


### AveragedStdDevBodyAccZ

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the body acceleration measured by the axis Z of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedMeanGravityAccX

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the gravity acceleration measured by the axis X of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedMeanGravityAccY

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the gravity acceleration measured by the axis Y of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedMeanGravityAccZ

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the gravity acceleration measured by the axis Z of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedStdDevGravityAccX

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the gravity acceleration measured by the axis X of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedStdDevGravityAccY

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the gravity acceleration measured by the axis Y of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedStdDevGravityAccZ

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the gravity acceleration measured by the axis Z of the accelerometer sensor", averaged over a specific activity and subject.

### AveragedMeanBodyGyroX

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the Body rotational rate measured by the axis X of the gyroscope sensor", averaged over a specific activity and subject.

### AveragedMeanBodyGyroY

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the Body rotational rate measured by the axis Y of the gyroscope sensor", averaged over a specific activity and subject.

### AveragedMeanBodyGyroZ

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Mean of the Body rotational rate measured by the axis Z of the gyroscope sensor", averaged over a specific activity and subject.

### AveragedStdDevBodyGyroX

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the Body rotational rate measured by the axis X of the gyroscope sensor", averaged over a specific activity and subject.

### AveragedStdDevBodyGyroX

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the Body rotational rate measured by the axis X of the gyroscope sensor", averaged over a specific activity and subject.

### AveragedStdDevBodyGyroY

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the Body rotational rate measured by the axis Y of the gyroscope sensor", averaged over a specific activity and subject.

### AveragedStdDevBodyGyroZ

- Class "numeric"
- Range: -1.0 to 1.0
- Unit of measurement : G = 9.8 m/s^2
-   "Standard Deviation of the Body rotational rate measured by the axis Z of the gyroscope sensor", averaged over a specific activity and subject.


## Sources
Stockexchange.com for R-coding support and sample of this Codebook
