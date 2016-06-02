This is the course project for the Coursera course Getting and Cleaning Data from John Hopkins University.

The data to be analyzed can be found from the links below:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The R script called run_analysis.R contains the following steps:

1. Download and unzip data, if it does not already exist in the working directory
2. Read data into the variables from the files and display the information of the variables
3. Appropriately labels the data set with descriptive variable and activity names
4. Merges the training and the test sets to create one data set
5. Extracts only the measurements on the mean and standard deviation for each measurement.
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
