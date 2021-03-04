run_analysis <- function() {
  ## R-Script for Coursera - Getting and Cleaning Data - Course Project
  ## Scriptname: run_analysis.R
  ## Author: Frank Oelker
  ## Date: 04.03.2021
  ## This script
  ## 1. Download the needed ZIP-file
  ## 2. Extract the files 
  ## 3. Merges the training and the test sets to create one data set
  ## 4. Extract only the measurements on the mean and standard deviation for
  ##    each measurement
  ## 5. Uses descriptive activity names to name the activities in the data set
  ## 6. Approbiately labels the data set with descriptive variable names
  ## 7. From the data set in step 6, creates a second, independent tidy data
  ##    set with the average of each variable for each activity and each subject
  print("Running...Please Wait")
  if(!is.element("mgsub", installed.packages()[,1])){
    install.packages('mgsub')
  }
  if(!is.element("dplyr", installed.packages()[,1])){
    install.packages('dplyr')
  }
  ## used libraries
  library(dplyr)
  library(mgsub)
  
  ## 1. Download the needed ZIP-file
  ## load the ZIP-File if it does not exist
  dataSetZip <- "Dataset.zip"
  if(!file.exists(dataSetZip)) {
      zipURL <- paste0("https://d396qusza40orc.cloudfront.net/getdata%2F",
                "projectfiles%2FUCI%20HAR%20Dataset.zip")
      download.file(zipURL, destfile = dataSetZip)
  } 

  ## 2. Extract the files 
  ## unzip the file, if the zipped files not exist
  if (!file.exists("./UCI_HAR_Dataset")) {
    unzip(dataSetZip)
  }

  ## 3. Merges the training and the test sets to create one data set
  ## 3.1 Read data
  ## 3.1.1 Read training datasets
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  ## 3.1.2 Read test datasets
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  ## 3.1.3 Read common data
  features <- read.table("./UCI HAR Dataset/features.txt")
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  ## 3.2 Accept/define column names
  colnames(x_train) <- features[,2]
  colnames(x_test) <- features[,2]
  colnames(y_train) <- "activityID"
  colnames(y_test) <- "activityID"
  colnames(subject_train) <- "subjectID"
  colnames(subject_test) <- "subjectID"
  colnames(activity_labels) <- c("activityID", "activityTyp")
  
  ## 3.3 Merge data
  ## merge the columns with cbind and merge the rows with rbind
  dataMerged <- rbind(cbind(x_train, y_train, subject_train),
                      cbind(x_test, y_test, subject_test))
  
  ## 4. Extract only the measurements on the mean and standard deviation for
  ##    each measurement
  ##    "mean()" and "std()" are part of the column name, the "new" columns
  ##    "activityID" and "subjectID" also need to be extracted
  meanstd <- dataMerged[,grepl("activityID|subjectID|mean\\(\\)|std\\(\\)",
                               colnames(dataMerged))]
  
  ## 5. Uses descriptive activity names to name the activities in the data set
  meanstd <- merge(meanstd, activity_labels, by = "activityID", all.x = TRUE)
  ##    The included columns "activityID" contains numbers 1-6, each number
  ##    represents a value (look at activity_labels).
  ##    The column "activityTyp" is added to meanstd, so at this moment there
  ##    are two columns with the same meaning - as text and as number.
  ##    The column "activityID" can be removed to make tidy data: "each variable
  ##    should be in ONE column"
  meanstd <- select(meanstd,-activityID)
  
  ## 6. Approbiately labels the data set with descriptive variable names
  ## ^t       = time
  ## ^f       = frequency
  ## mean()   = Mean
  ## std()    = Standard
  ## Acc      = Accelerometer
  ## Gyro     = Gyroscope
  ## ()-      = remove these signs
  ## BodyBody = Body
  ## Mag      = Magnitude
  colnames(meanstd) <- mgsub(colnames(meanstd), 
      pattern =     c("^t", "^f", "mean", "std", 
                      "Acc", "Gyro", "\\(|\\)|\\-", "BodyBody", 
                      "Mag"), 
      replacement = c("time", "frequency", "Mean", "Standard",
                      "Accelerometer", "Gyroscope", "", "Body",
                      "Magnitude"))
  
  ## 7. From the data set in step 6, creates a second, independent tidy data
  ##    set with the average of each variable for each activity and each subject
  tidy_data_set <- aggregate(. ~subjectID + activityTyp, meanstd, mean)
  write.table(tidy_data_set, file = "TidyDataSet.txt", row.names = FALSE)
  print("The File TidyDataSet is created")
}
