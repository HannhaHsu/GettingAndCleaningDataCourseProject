#Download and unzip data if data does not already exist in working directory
if(!file.exists("./getting_cleaning_data")){dir.create("./getting_cleaning_data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./getting_cleaning_data/Dataset.zip", method="curl")
unzip(zipfile="./getting_cleaning_data/Dataset.zip", exdir="./getting_cleaning_data")
path_uci <- file.path("./getting_cleaning_data/", "UCI HAR Dataset")
files <- list.files(path_uci, recursive = TRUE)
#Check
files

#Read data into the variables from the files and display the information of the variables
activityTest <- read.table(file.path(path_uci, "test", "y_test.txt"), header = FALSE)
activityTrain <- read.table(file.path(path_uci, "train", "y_train.txt"), header = FALSE)

subjectTrain <- read.table(file.path(path_uci, "train", "subject_train.txt"), header = FALSE)
subjectTest <- read.table(file.path(path_uci, "test", "subject_test.txt"), header = FALSE)

featureTest <- read.table(file.path(path_uci, "test", "X_test.txt"), header = FALSE)
featureTrain <- read.table(file.path(path_uci, "train", "X_train.txt"), header = FALSE)

#Check
str(activityTest)
str(activityTrain)

str(subjectTest)
str(subjectTrain)

str(featureTest)
str(featureTrain)

#Concatenate the training and test data tables by rows
activityData <- rbind(activityTrain, activityTest)
subjectData <- rbind(subjectTrain, subjectTest)
featureData <- rbind(featureTrain, featureTest)

#Appropriately labels the data set with descriptive variable names.
names(subjectData) <- c("subject")
names(activityData) <- c("activity")
featureNames <- read.table(file.path(path_uci, "features.txt"), head = FALSE)
names(featureData) <- featureNames$V2

#Concatenate subject, activity and feature data by column
dataCombine <- cbind(subjectData, activityData)
Data <- cbind(featureData, dataCombine)

#Extracts only the measurements on the mean and standard deviation for each measurement
subdataFeatureNames <- featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)]

#Uses descriptive activity names to name the activities in the data set
selectedNames <- c(as.character(subdataFeatureNames), "subject", "activity")

#Subset the data frame Data by selected names of Features
Data <- subset(Data, select=selectedNames)

#Check
str(Data)

#Label activities
activityLabels <- read.table(file.path(path_uci, "activity_labels.txt"), header = FALSE)
head(Data$activity)
names(Data)

###Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
write.table(Data2, file = "tidydata.txt", row.name = FALSE)

