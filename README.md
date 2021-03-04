Coursera Getting and Cleaning Data Course Project

  The purpose of this project is to demonstrate your ability to collect, work 
  with, and clean a data set. The goal is to prepare tidy data that can be used 
  for later analysis. 
  
This repository contains the following files:
  README.md       This file, that explains how the files work together and how the 
                  data is created.
  run_analysis.R  The R-Script that creates the data set "TidyDataSet.txt"
  TidyDataSet.txt The Data Set that can be used for later analysis
  CodeBook.md     Describes the data in the Data Set TidyDataSet.txt

run_analysis.R contains the code to create the TidyDataSet.txt. The R-Script can
be used as normal. 
The script
  - installs the needed R-packages
  - download the needed file, if it doesn`t exist
  - extract the files
  - merges the training and the test sets
  - extract only the measurements of the mean and standard deviation for each 
    measurement
  - names the activities in the data set
  - labels the data set with descriptive variable names
  - creates the file "TidyDataSet.txt", which contains the average of each 
    variable for each activity and each subject


The data linked to from the course website represent data collected from the 
accelerometers from the Samsung Galaxy S smartphone. A full description is 
available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

License:
========
Use of this dataset in publications must be acknowledged by referencing the 
following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can 
be addressed to the authors or their institutions for its use or misuse. 
Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

