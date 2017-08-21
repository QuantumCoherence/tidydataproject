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
```sh
run_analsys(path = ".")
```

**Arguments**

path  : path (can be relative to the location of the run_analysis.R file) to the "UCI HAR Dataset" folder

Example: 

Continuiong the example from above, assuming run_analysis.R has been save in the "workfolder" direcotry
```sh
$ tidydataset <- run_analysis()
```
will return the tidy dataset into the tidydataset data.frame

**Notes**

Two files will be created , one binary and the other in text csv format,

named respectivley _averagedDataSet.rda_ and _averagedDataSet.csv_

## Data cleaining Process - Step by Step with code

 0. Setup folder names and load packages
```sh
   run_analysis(path = ".')
```
```sh
   # See Readme.md for usage instructions
      trainfolder <- file.path(path, "UCI HAR Dataset/train")
      testfolder  <- file.path(path, "UCI HAR Dataset/test")
      featurefile <- file.path(path, "UCI HAR Dataset/features.txt")
      activityfile <-file.path(path, "UCI HAR Dataset/activity_labels.txt")
      averagedfile <-file.path(path, "UCI HAR Dataset/averagedDataSet.")

    # R packages requirements
  library(data.table)
  library(dplyr)
```

 1. **Load Files from raw dataset**

```sh
    #Train Data
    traindata <- fread(file=file.path(trainfolder,"X_train.txt"), sep = " ", data.table = FALSE, header = FALSE)
    #Test Data
    testdata <- fread(file=file.path(testfolder,"X_test.txt"), sep = " ", data.table = FALSE, header = FALSE)
    #Train Activity
    trainactivity <- fread(file=file.path(trainfolder,"y_train.txt"), sep = " ", data.table = FALSE, header = FALSE)
    #Test Activty 
    testactivity <- fread(file=file.path(testfolder,"y_test.txt"), sep = " ", data.table = FALSE, header = FALSE)
    #Train Subjects
    trainsubjects <- fread(file=file.path(trainfolder,"subject_train.txt"), sep = " ", data.table = FALSE, header = FALSE)
    #Test Subject
    testsubjects <- fread(file=file.path(testfolder,"subject_test.txt"), sep = " ", data.table = FALSE, header = FALSE)
```
    
2.  Merges rows of train and test data sets

```sh
    # bind subjects and ativity columns to corresponding data set
    testcomplete <- cbind(testsubjects, testactivity, testdata)
    traincomplete <- cbind(trainsubjects, trainactivity, traindata)
    # merge rows of data sets
    completedata <- rbind(testcomplete, traincomplete)
    names(completedata)[1:2] <- c("Subject_ID","Activity")
    #remove unncessary data frames from script
    rm(traindata, testdata, trainactivity, testactivity, trainsubjects, testsubjects,testcomplete, traincomplete)    
```

3. **Extracts only the measurements on the mean and standard deviation for each measurement.**

**See CodeBook.md for details about which variable were selected **

```sh
    #Load variable names from features.text file and select the requird subset of variables 
    
    #read variables name from features.txt file
    features <- read.csv(featurefile,stringsAsFactors = FALSE, sep = " ", header = FALSE)
    features <-tbl_df(features)
    # filter measurements on the mean and standard deviation - 
      #select variables with either mean() or std(0 that start with t only)
      set1 <- filter(features, grepl("^t.*(mean()|std()).*", features$V2))
      #select variables that include either Jerk or Mag and do start with t only
      set2 <- filter(features, grepl("^t.*(Jerk|Mag).*", features$V2))
      #the desired feature variables are included in the set difference between set1 and sets
      features <- setdiff(set1, set2)
    #increase column indicies by 2 to reflect the added column with subject ids and activity data
    features$V1 <- features$V1 + 2
 ```
 
 ```sh
     #select the filtered measurement column 
    completedata <- select(completedata, c(1, 2, features$V1))
    #upate variable names with descritives names
    features$V2 <- strsplit(features$V2,"-")
    variablenames <- lapply(features$V2,FUN=function(x){if(is.na(x[3])) paste(x[2], x[1],sep="") else paste(x[2], x[1], x[3],sep="")})
    variablenames <- gsub("mean[(][)]t", "Mean", variablenames)  
                     # replace "mean()" with "Mean" and drop the letter t in front just after mean()
    variablenames <- gsub("std[(][)]t", "StdDev", variablenames) 
                     # Replace "std()" with "StdDev"and drop the letter t in front just after std()
```

```sh
    # assign variable names to columns
    names(completedata)[3:20] <- variablenames
    # Load activity labels key -> value map
    activitylabels <- fread(activityfile, sep = " ", data.table = FALSE, header = FALSE)
    # Replace numerics with character values from activitylabels 
    completedata[["Activity"]] <- activitylabels[match(completedata[['Activity']], activitylabels[['V1']]), 'V2']
```

4. Create new tidy data set with averaged means and standard deviations 
```sh
    #update variable names
    variablenames <- sapply(variablenames,FUN=function(x){paste("Averaged", x,sep="")})
    names(completedata)[3:20] <- variablenames
    #group by Activity and Subject ids
    averagedDataSet <- completedata %>% group_by(Activity, Subject_ID) %>% summarise_all(funs(mean))
    #save dataset in binary and text forms
    save(averagedDataSet, file = paste(averagedfile,"rda", sep=""))
    write.csv(averagedDataSet,file = paste(averagedfile, "csv",sep=""))
    averagedDataSet
```

