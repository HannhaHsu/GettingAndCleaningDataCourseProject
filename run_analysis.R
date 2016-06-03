library(plyr);

###Download and unzip data if data does not already exist in working directory###
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./getting_cleaning_data")){
  dir.create("./getting_cleaning_data")
  download.file(fileUrl, destfile="./getting_cleaning_data/Dataset.zip", method="curl")
}
unzip(zipfile="./getting_cleaning_data/Dataset.zip", exdir="./getting_cleaning_data")
ucifile_path <- file.path("./getting_cleaning_data/", "UCI HAR Dataset")
files <- list.files(ucifile_path, recursive = TRUE)
####Download and unzip data if data does not already exist in working directory###

###Read data into the variables from the files and display the information of the variables###
activityTest <- read.table(file.path(ucifile_path, "test", "y_test.txt"), header = FALSE)
activityTrain <- read.table(file.path(ucifile_path, "train", "y_train.txt"), header = FALSE)
subjectTrain <- read.table(file.path(ucifile_path, "train", "subject_train.txt"), header = FALSE)
subjectTest <- read.table(file.path(ucifile_path, "test", "subject_test.txt"), header = FALSE)
featureTest <- read.table(file.path(ucifile_path, "test", "X_test.txt"), header = FALSE)
featureTrain <- read.table(file.path(ucifile_path, "train", "X_train.txt"), header = FALSE)
str(activityTest)
str(activityTrain)
str(subjectTest)
str(subjectTrain)
str(featureTest)
str(featureTrain)
###Read data into the variables from the files and display the information of the variables###

###Concatenate the training and test data tables by rows###
activityData <- rbind(activityTrain, activityTest)
subjectData <- rbind(subjectTrain, subjectTest)
featureData <- rbind(featureTrain, featureTest)
###Concatenate the training and test data tables by rows###

###Appropriately labels the data set with descriptive variable names###
names(subjectData) <- c("subject")
names(activityData) <- c("activity")
featureNames <- read.table(file.path(ucifile_path, "features.txt"), head = FALSE)
names(featureData) <- featureNames$V2
###Appropriately labels the data set with descriptive variable names###

###Concatenate subject, activity and feature data by column###
dataCombine <- cbind(subjectData, activityData)
Data <- cbind(featureData, dataCombine)
###Concatenate subject, activity and feature data by column###

###Extracts only the measurements on the mean and standard deviation for each measurement###
subdataFeatureNames <- featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)]
###Extracts only the measurements on the mean and standard deviation for each measurement###

###Uses descriptive activity names to name the activities in the data set###
selectedNames <- c(as.character(subdataFeatureNames), "subject", "activity")
###Uses descriptive activity names to name the activities in the data set###

###Subset the data frame Data by selected names of Features###
Data <- subset(Data, select=selectedNames)
str(Data)
###Subset the data frame Data by selected names of Features###


###Label activities###
activityLabels <- read.table(file.path(ucifile_path, "activity_labels.txt"), header = FALSE)
Data$activity<-factor(Data$activity);
Data$activity<- factor(Data$activity,labels=as.character(activityLabels$V2))
head(Data$activity)
names(Data)
###Label activities###

###Creates a second, independent tidy data set with the average of each variable for each activity and each subject###
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt", row.name = FALSE)
###Creates a second, independent tidy data set with the average of each variable for each activity and each subject###
