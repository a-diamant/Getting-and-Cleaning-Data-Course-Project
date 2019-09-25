#getting and cleaning data
#the final course project

setwd("~/R_exercises/coursera/getting and cleaning data")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "fitdata.zip")
unzip("fitdata.zip")
list.files()

#read data into r-ojects
test <- read.table("UCI HAR Dataset/test/X_test.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")

#1. Merge the training and the test sets to create one data set
dt <- rbind(test, train)

#2.Extract only the measurements on the mean and standard deviation for each measurement
dt_std <- dt[,grepl("std", names(dt))]
dt_mean <- dt[,grepl("mean", names(dt))]

dt_mean_std <- cbind(dt_std,dt_mean)#the mesurements on mean and std
names(dt_mean_std)#let's check it

#3.Uses descriptive activity names to name the activities in the data set
ac_labels <- readLines("UCI HAR Dataset/activity_labels.txt")#activity names 

ac_test_code <- readLines("UCI HAR Dataset/test/y_test.txt")
ac_train_code <- readLines("UCI HAR Dataset/train/y_train.txt")
dt$ac_code <- c(ac_test_code, ac_train_code) #labels the activities with a code
str(dt$ac_code) #chr vector labeling code of the activity
dt$activity<- factor(dt$ac_code, labels = ac_labels) #labels activities with the names accordin to code
#dt$ac_code <- NULL
dt[107:120,c("activity","ac_code")] #code and labels match

#4 Appropriately labels the data set with descriptive variable names
features <- readLines("UCI HAR Dataset/features.txt")
#features <- gsub("[0-9]", "", features)

length(features)==length(names(dt))
names(dt) <- features #labels the mesuarements 



#5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

id_test <- readLines("UCI HAR Dataset/test/subject_test.txt")
id_train <- readLines("UCI HAR Dataset/train/subject_train.txt")
dt$id <- c(id_test, id_train) #labels data with participants' id

#tidy_dt <-aggregate(dt, by=list(id, activity), FUN=mean, na.rm=TRUE)
library(dplyr)
names(dt)[562] <- "act"
dt[,563] <- NULL
tidy_dt <- group_by(dt, id, activity) %>%
  summarise_each(funs(mean))
