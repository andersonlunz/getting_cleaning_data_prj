# Course Project
# Getting and Cleaning Data Course - Johns Hopkins - Coursera

## Overview
This project uses a R script to get and clean data, preparing it on a tidy format for later analysis. It will generate one final file called "tiny_data.txt" containig information about the arithimetic mean of each variable, grouped by activity and subject.

The source of the study is on "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" and the data was obtained at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


## The Manipulations to Generate the Final File - Explaining How the Script Works

1. As a first step, the script sets the working directory and download and unzip the source data set.
  * setwd("/tmp/getting_cleaning_data")
  * fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  * download.file(fileUrl,destfile="Dataset.zip",method="curl")
  * unzip("Dataset.zip", junkpaths = TRUE)


> 2. Then it loads the features data sets in a data frame. The features data set will be used to give names for the variables in the x_train and x_test data sets which contains all observations of the study. 
>> features_df <- read.table("features.txt", header=FALSE, col.names=c("id","feature_name"))


> 3. Then it loads the main data sets in data frames and rename the variables in each data frame using the features data frame created on step 2 above. The main data sets are x_train and x_test which contains all observations of the study. 
>> x_train_df <- read.table("X_train.txt", header=FALSE)
>> names(x_train_df) <- features_df$feature_name
>> x_test_df <- read.table("X_test.txt", header=FALSE)
>> names(x_test_df) <- features_df$feature_name


> 4. The script adds the activity_id column to x_train and x_test data frames. The files "y_train.txt" and "y_test.txt" contains the activity ids for each observation in x_train and x_test data sets respectively.
>> temp <- read.table("y_train.txt", header=FALSE)
>> x_train_df$activity_id <- temp[,1]
>> 
>> temp <- read.table("y_test.txt", header=FALSE)
>> x_test_df$activity_id <- temp[,1]


> 5. The script then adds the subject who performed the activity for each observation. The files "subject_train.txt" and "subject_test.txt" have the information of subject for each observation in x_train and x_test data sets respectively. In order to have a more readable data, the script modifies the subject information (which is an integer from 1 to 30) and prepends a "subject_" string before the subject id.
>> temp <- read.table("subject_train.txt", header=FALSE, col.names = c("subject_id"))
>> x_train_df$subject <- with(temp, paste("subject", sprintf("%02d",subject_id), sep="_"))
>> 
>> temp <- read.table("subject_test.txt", header=FALSE, col.names = c("subject_id"))
>> x_test_df$subject <- with(temp, paste("subject", sprintf("%02d",subject_id), sep="_"))


> 6. With the main data frames x_train_df and x_test_df ready to use, the script executes the task of the assignment 1. It consists on append the two main data frames to create a unique data frame to be used by the subsequent assignments.
>> appended_df <- rbind(x_train_df, x_test_df)


> 7. The script execute the assignment 2 witch consists in cleanup the recently appended data frame called appended_df and create a new data frame only with columns related to measurements on the mean and standard deviation. It also keeps the columns "activity_id" and "subject" which will be used in the following assignments.
>> mean_std_columns <- grep("mean\\(\\)|std\\(\\)", names(appended_df))
>> columns_to_select <- c(mean_std_columns, grep("activity_id", names(appended_df)), grep("subject", names(appended_df)))
>> clean_df <- subset(appended_df, select=columns_to_select)


> 8. For the assignment 3 the script first loads the library dplyr which will be used to manipulate the "clean_df" data frame. After that the script will replace the activity_id variable on data frame "clean_df" for the real activity labels which are found on file "activity_labels.txt". It will load the "activity_labels.txt" file on a data frame and then join it with the "clean_df" data frame. This will add the activity labels variable on the "clean_df" data frame for each observation. To keep the new data frame clean, the script removes the "activity_id" variable from the joined data frame.
>> library(dplyr)
>> activity_df <- read.table("activity_labels.txt", header=FALSE, col.names = c("id","activity"))
>> merged_df <- merge(clean_df, activity_df, by.x="activity_id", by.y="id")
>> clean_df <- select(merged_df, -(activity_id))


> 9. For the assignment 4, the script replaces some variable names with more descriptive names.
>> names(clean_df) <- gsub("^t", "time", names(clean_df))
>> names(clean_df) <- gsub("^f", "frequency", names(clean_df))
>> names(clean_df) <- gsub("Acc", "Accelerometer", names(clean_df))
>> names(clean_df) <- gsub("Gyro", "Gyroscope", names(clean_df))
>> names(clean_df) <- gsub("Mag", "Magnitude", names(clean_df))
>> names(clean_df) <- gsub("BodyBody", "Body", names(clean_df))


> 10. For the assignment 5, it first loads the library "data.table" and then the script creates a tidy data set grouping the results by activity and subject and then order the result set by activity and subject.
>> library(data.table)
>> clean_table <- data.table(clean_df)
>> tidy_data <- clean_table[, lapply(.SD, mean), by = 'activity,subject']
>> tidy_data <- tidy_data[order(activity, subject)]


> 11. As the last step, the script generates the final file called "tidy_data.txt"
>> write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)