# Final project for Getting and Cleaning Data Course
# Goal and purpose of the project:
# The purpose of this project is to demonstrate your ability to collect,
# work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis.

# Tasks performed in this R script:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject.


# Set the working directory to where you want to run this code
setwd("~/DataScienceSpecialization/GettingCleaningData/Project/")
# 
# Get the data required for this project
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fname <- "dataset.zip"
if(!file.exists(fname)){
  download.file(url, fname, method="curl")
}

# unzip the data and see the files in this folder
datapath <- "UCI HAR Dataset"
if(!file.exists(datapath)){
  unzip(fname,list = FALSE, overwrite = TRUE)
}

#Read the subject and activity files
subjectTrain <- read.table(file.path(datapath, "train", "subject_train.txt"))
subjectTest  <- read.table(file.path(datapath, "test" , "subject_test.txt" ))
activityTrain <- read.table(file.path(datapath, "train", "Y_train.txt"))
activityTest  <- read.table(file.path(datapath, "test" , "Y_test.txt" ))

xtrain <- read.table(file.path(datapath, "train", "X_train.txt"))
xtest  <- read.table(file.path(datapath, "test" , "X_test.txt" ))

# Task # 1: Merge the training and test sets into one dataset

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
x <- rbind(xtrain, xtest)
sub <- cbind(subject, activity)
onedata <- cbind(sub, x)

# # Task #2: Extract only the measurements on the mean and standard deviation for each measurement.
features <- read.table(file.path(datapath, "features.txt"))
meanStd <- grep("-(mean|std)\\(\\)", features[, 2])

x <- x[,meanStd]
colnames(x) <- features[meanStd,2]


# Task #3: Use descriptive activity names to name the activities in the data set

f <- "activity_labels.txt"
fname2 <- paste(datapath,f,sep="/")
activityLabels <- data.frame()
activityLabels <- read.table(fname2,sep="")
activity[,1] <- activityLabels[activity[,1],2]
colnames(activity) <- "activity"


# Task #4: Appropriately labels the data set with descriptive variable names.
colnames(subject) <- "subject"
data <- cbind(x,activity,subject)

# # Task #5: From the data set in step 4, creates a second, independent tidy data set with the
# # average of each variable for each activity and each subject.

# Removing the subject and activity column, since a mean of those has no use
tidy <- ddply(data, .(subject, activity), function(fm) colMeans(fm[,1:66]))

# writing out the tidy data set to a separate file
write.csv(tidy,"TidyDataset.csv",row.names = FALSE)
 
