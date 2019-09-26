##########################################################
#                    getting and cleaning data
#                        the final course project
###########################################################
#
#
# Please note: here i change the steps sequence but keep their original numbers, according 
# to coursera Getting and Cleaning Data Course Project
##########################################################################################

setwd("D:/R_exercises/coursera/getting and cleaning data/course project")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "fitdata.zip")
unzip("fitdata.zip")
list.files()

#read data into r-ojects
test <- read.table("UCI HAR Dataset/test/X_test.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")

#1. Merge the training and the test sets to create one data set
dt <- rbind(test, train)

#4 Appropriately labels the data set with descriptive variable names
features <- readLines("UCI HAR Dataset/features.txt")

length(features)==length(names(dt))
names(dt) <- features #labels the mesuarements

#3.Uses descriptive activity names to name the activities in the data set
ac_labels <- readLines("UCI HAR Dataset/activity_labels.txt")#let's save the activity names in a vector 

ac_test_code <- readLines("UCI HAR Dataset/test/y_test.txt") #creates a vector with a coded names for activities for test data set
ac_train_code <- readLines("UCI HAR Dataset/train/y_train.txt")#creates a vector with a coded names for activities for training data set
dt$ac_code <- c(ac_test_code, ac_train_code) #since we have a merged data set, i marge the coded activity names together and labele the activities with a code
str(dt$ac_code) #chr vector labeling code of the activity
dt$activity<- factor(dt$ac_code, labels = ac_labels) #here we give the proper activity names (walking etc) based on the coded names

dt[107:120,c("activity","ac_code")] #here I do a little check to see that code and labels match

id_test <- readLines("UCI HAR Dataset/test/subject_test.txt") #we create a vector with id of persons carrying out the experiments for test subset
id_train <- readLines("UCI HAR Dataset/train/subject_train.txt") #we create a vector with id of persons carrying out the experiments for training subset
dt$id <- c(id_test, id_train) #labels data with participants' id from two above created vectors

#2.Extract only the measurements on the mean and standard deviation for each measurement
dt_std <- dt[,grepl("std", names(dt))]
dt_mean <- dt[,grepl("mean", names(dt))]

dt_mean_std <- cbind(dt$id, dt$activity, dt_std,dt_mean)# createst the data set with the mesurements on mean and std
names(dt_mean_std)#let's check it

#5. From the data set in step 4 (here it is the data set dt_mean_std, created in previous step),
#creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

tidy_dt <-aggregate(dt_mean_std, by=list(dt$id, dt$activity), FUN=mean, na.rm=TRUE)
#here i use the function aggregate to create our tidy data set averiging every variable accoring to activity 
#and the participant's id
head(tidy_dt)#let's have a look on our tidy data set

#since the average numbers of "activity" and "id" variables don't make any sense let's simply remove them
tidy_dt$`dt$activity` <- NULL
tidy_dt$`dt$id` <- NULL

#as a final step let's rename the variables created by aggregate function to "id" and "activity"
#in order to make our data set really tidy
names(tidy_dt)[c(1,2)] <- c("id","activity")
names(tidy_dt)#our data set still has the numbers before variables names. let's get rid of them
names(tidy_dt) <- gsub("[0-9]", "", names(tidy_dt)) #now we have clear variables names

write.table(tidy_dt, file = "tidy_dt.txt", sep = "")#to save our data set in working directory
write.table(names(tidy_dt), file = "codebook.txt",sep = "")


#please visit my readme document where i explain the final tidy data set 
 