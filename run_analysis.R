run_analysis <- function(directory ="") {
  # See Readme.md for usage instructions
  if(directory !="") {
      folder <- file.path(directory)
      trainfolder <- file.path(directory, "train")
      testfolder  <- file.path(directory, "test")
      featurefile <- file.path(folder,"features.txt")
      activityfile <-file.path(folder,"activity_labels.txt")
      averagedfile <-file.path(folder,"averagedDataSet.")
  } else{
      folder <- directory
      trainfolder <- "train"
      testfolder  <- "test"
      featurefile <-"features.txt"
      activityfile <-"activity_labels.txt"
      averagedfile <-"averagedDataSet."
  }

    # R packages requirements
  library(data.table)
  library(dplyr)
  
  
  #Load Files from provided directory - see readme for required dataset
  
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

  # merges rows of train and test data sets
    
    # bind subjects and ativity columns to corresponding data set
    testcomplete <- cbind(testsubjects, testactivity, testdata)
    traincomplete <- cbind(trainsubjects, trainactivity, traindata)
    # merge rows of data sets
    completedata <- rbind(testcomplete, traincomplete)
    names(completedata)[1:2] <- c("Subject_ID","Activity")
    #remove unncessary data frames from script
    rm(traindata, testdata, trainactivity, testactivity, trainsubjects, testsubjects,testcomplete, traincomplete)

  #Extracts only the measurements on the mean and standard deviation for each measurement.
    #Load variable names from features.text file and select the requird subset of variables 
    
    #read variables name from features.txt file
    features <- read.csv(featurefile,stringsAsFactors = FALSE, sep = " ", header = FALSE)
    features <-tbl_df(features)
    # filter measurements on the mean and standard deviation - See CodeBook.md for details
      #select variables with either mean() or std(0 that start with t only)
      set1 <- filter(features, grepl("^t.*(mean()|std()).*", features$V2))
      #select variables that include either Jerk or Mag and do start with t only
      set2 <- filter(features, grepl("^t.*(Jerk|Mag).*", features$V2))
      #the desired feature variables are included in the set difference between set1 and sets
      features <- setdiff(set1, set2)
    #increase column indicies by 2 to reflect the added column with subject ids and activity data
    features$V1 <- features$V1 + 2
    
    #select the filtered measurement column 
    completedata <- select(completedata, c(1, 2, features$V1))
    #upate variable names with descritives names
    features$V2 <- strsplit(features$V2,"-")
    variablenames <- lapply(features$V2,FUN=function(x){if(is.na(x[3])) paste(x[2], x[1],sep="") else paste(x[2], x[1], x[3],sep="")})
    variablenames <- gsub("mean[(][)]t", "Mean", variablenames)  # replace "mean()" with "Mean" and drop the letter t in front just after mean()
    variablenames <- gsub("std[(][)]t", "StdDev", variablenames) # Replace "std()" with "StdDev"and drop the letter t in front just after std()

    # assign variable names to columns
    names(completedata)[3:20] <- variablenames
    # Load activity labels key -> value map
    activitylabels <- fread(activityfile, sep = " ", data.table = FALSE, header = FALSE)
    # Replace numerics with character values from activitylabels 
    completedata[["Activity"]] <- activitylabels[match(completedata[['Activity']], activitylabels[['V1']]), 'V2']
    
  #create new averaged data set 
    
    #update variable names
    variablenames <- sapply(variablenames,FUN=function(x){paste("Averaged", x,sep="")})
    names(completedata)[3:20] <- variablenames
    #group by Activity and Subject ids
    averagedDataSet <- completedata %>% group_by(Activity, Subject_ID) %>% summarise_all(funs(mean))
    #save dataset in binary and text forms
    save(averagedDataSet, file = paste(averagedfile,"rda", sep=""))
    write.csv(averagedDataSet,file = paste(averagedfile, "csv",sep=""))
    averagedDataSet
    
}