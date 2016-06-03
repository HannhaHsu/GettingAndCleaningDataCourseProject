This is the course project for the Coursera course Getting and Cleaning Data from John Hopkins University.

###Data Introduction
The data to be analyzed can be found from the links below:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


###R Code Structure
The R script called run_analysis.R contains the following steps:

1. Download and unzip data, if it does not already exist in the working directory
2. Read data into the variables from the files and display the information of the variables
3. Concatenate the training and test data tables by rows
4. Appropriately labels the data set with descriptive variable names
5. Concatenate subject, activity and feature data by column
6. Extracts only the measurements on the mean and standard deviation for each measurement
7. Uses descriptive activity names to name the activities in the data set
8. Subset the data frame Data by selected names of Features
9. Label actitivities
10. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
