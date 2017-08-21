# tidydataproject
getting-and-cleaning-data-course-project

## Creating the tidy dataset with run_analysis.R
### Installation
 1. Required R packages: dplyr, data.table
 2. Downlaod and extract to a local folder of your choice the raw dataset from this address
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 3. Downald the run_analysis.R script to a local folder of your choice.
 
 Example:
 `<setwd("workfolder")>`
  -- download FUCI HAR Dataset.zip
  -- unzip "FUCI HAR Dataset.zip"
  -- list.dir() will return the following folders and subfolders of the "tidydataproject" folder:
 `<list.dirs()
[1] "."                                        "./UCI HAR Dataset"                       
[3] "./UCI HAR Dataset/test"                   "./UCI HAR Dataset/test/Inertial Signals" 
[5] "./UCI HAR Dataset/train"                  "./UCI HAR Dataset/train/Inertial Signals"
>`
`<setwd("FUCI HAR Dataset")>`
   -- list.files() will return following files 
`<list.files()
[1] "activity_labels.txt" "features.txt"        "features_info.txt"   "README.txt"         
[5] "test"                "train"              
>`
### using run_analysis.R
**Description** 
run_analysis takes as input the folder location where the raw dataset top folder is located and 
returns a data.frame with the tidy dataset. 

**Usage**

run_analsys(path = ".")

**Arguments**
path  : path (can be relative to the location of the run_analysis.R file) to the "UCI HAR Dataset" folder

Example: 
Continuiong the example from above, assuming run_analysis.R has been save in the "workfolder" direcotry

tidydataset <- run_analysis()

will return the tidy dataset into the tidydataset data.frame

**Notes**
Two files will be created , one bianry and thw other in text csv format, 
named respectivley averagedDataSet.rda and averagedDataSet.csv
