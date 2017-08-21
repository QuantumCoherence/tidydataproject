# tidydataproject
getting-and-cleaning-data-course-project

## Creating the tidy dataset with run_analysis.R
### Installation
 1. Required R packages: dplyr, data.table
 2. Downlaod and extract to a local folder of your choice the raw dataset from this address
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 3. Downald the run_analysis.R script to a local folder of your choice.
 
Example:
```sh
$ setwd("workfolder")
```
  -- download FUCI HAR Dataset.zip
  
  -- unzip "FUCI HAR Dataset.zip"
  
  -- list.dir() will return the following folders and subfolders of the "workfolder" folder:
  
```sh
$ list.dirs()
 [1] "."                                        "./UCI HAR Dataset"                       
 [3] "./UCI HAR Dataset/test"                   "./UCI HAR Dataset/test/Inertial Signals" 
 [5] "./UCI HAR Dataset/train"                  "./UCI HAR Dataset/train/Inertial Signals"
$ setwd("FUCI HAR Dataset")
```
   -- list.files() will return following files 
```sh
$ list.files()
[1] "activity_labels.txt" "features.txt"        "features_info.txt"   "README.txt"         
[5] "test"                "train"                                                          
```

### Using run_analysis.R
**Description** 

run_analysis takes as input the folder location where the raw dataset top folder is located and 
returns a data.frame with the tidy dataset. 

**Usage**

run_analsys(path = ".")

**Arguments**

path  : path (can be relative to the location of the run_analysis.R file) to the "UCI HAR Dataset" folder

Example: 

Continuiong the example from above, assuming run_analysis.R has been save in the "workfolder" direcotry
```sh
$ tidydataset <- run_analysis()
```
will return the tidy dataset into the tidydataset data.frame

**Notes**

Two files will be created , one bianry and thw other in text csv format, 

named respectivley averagedDataSet.rda and averagedDataSet.csv

## Data cleaining Process

 1. **Load Files from raw dataset**
 
    1 traindata <- X_train.txt
    2 testdata  <- X_test.txt 
    3 trainactivity <- y_train.txt
    4 testactivity  <- y_test.txt
    5 trainsubjects <- subject_train.txt
    6 testsubjects  <- subject_test.txt
    
 2. Column bind test subjects, ativity and data into a test data.frame
 3. Column bing train sbject, activity and data into a train data.frame
 4. **Merges rows of train and test data sets into a single _completedata_ data.frame**
 5. Name the column of the subject ids (in the _completedata_ data.frame) "Subject_ID" and the column of the activities, "Activity"
 6. **Extracts only the measurements on the mean and standard deviation for each measurement.**
 
    > Load variable names from features.text file  
    > Filter measurements on the mean and standard deviation 
      >>**See CodeBook.md for details**  
      >> Select variables with either mean() or std(0 that start with "t" only)
      >> Select variables that include either Jerk or Mag and do start with "t" only
      >> The desired feature variables are included in the set difference between 6.2a and 6.2b
      
    > Select the filtered measurement column from the _completedata_ and update it    
    > Upate variable names of _completedata_ with descritives names (see CodeBook.md)

 7. Load activity labels key -> value map
    Replace numerics in the "activity" columsn with the activity charater strings
    
 8. Create the new tidy data set with the averaged value of the
    
    #update variable names
    variablenames <- sapply(variablenames,FUN=function(x){paste("Averaged", x,sep="")})
    names(completedata)[3:20] <- variablenames
    #group by Activity and Subject ids
    averagedDataSet <- completedata %>% group_by(Activity, Subject_ID) %>% summarise_all(funs(mean))
    #save dataset in binary and text forms
    save(averagedDataSet, file = paste(averagedfile,"rda", sep=""))
    write.csv(averagedDataSet,file = paste(averagedfile, "csv",sep=""))
    averagedDataSet
