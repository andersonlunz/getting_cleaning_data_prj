# Course Project
# Getting and Cleaning Data Course - Johns Hopkins - Coursera

## Overview
This project uses a R script to get and clean data, preparing it on a tidy format for analysis. It will generate one final file called "tiny_data.txt" containig information about the arithimetic mean of each variable, grouped by participant and activity.
The source of the study is on "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" and the data was obtained at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


## Information about the final file (Codebook)
The final file generated has 180 data rows (measurements) and 68 columns (variables). The first 2 columns of this file ("participant" and "activity") represents an identification of each participant of the study
and the activity observed in the measurement. The other columns represents the arithimetic mean of each variable measured on the study. 
Each measurement was grouped by participant and activity.
There were 30 participants on the study, identified by labels "participant_1" to "participant_30" and the acitities are classified in six (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
There are two major variable domains which are variables started with "t" time representing "time" values and variables started with "f" representing frequency values.
Variables containing accelerometer and gyroscope on the name refere to values measured by an accelerometer sensor and a gyroscope.
The letters X,Y and Z at the end of the variable names represent de axis related to the measurement.


## The manipulations to generate the final file - Explaining How the script works

> 1. The first step is load the library data.table which will be used by the script on its final part
>> library(data.table)

> 2. After the script downloads automatically the zip file to the current working directory
>> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
>> download.file(fileUrl,destfile="Dataset.zip",method="curl")

> 3. It uncompresses the downloaded file "Dataset.zip" removing the zip file paths(parameter 'junkpaths = TRUE'), so all files will be extracted on the working directory
>> unzip("Dataset.zip", junkpaths = TRUE)

> 4. It reads the features data set to a data frame and also creates a vector called 'column_names_vector' that will hold all the column names for the test and training data sets
>> features_df <- read.table("features.txt", header=FALSE, col.names=c("id","feature_name"))
>> column_names_vector <- as.vector(features_df[,"feature_name"])

> 5. It then reads all the important data set files into data frames
>> y_test_df <- read.table("y_test.txt", header=FALSE, col.names = c("id"))
>> x_test_df <- read.table("X_test.txt", header=FALSE, col.names=column_names_vector)
>> y_train_df <- read.table("y_train.txt", header=FALSE, col.names = c("id"))
>> x_train_df <- read.table("X_train.txt", header=FALSE, col.names=column_names_vector)
>> participant_test_df <- read.table("subject_test.txt", header=FALSE, col.names = c("participant_id"))
>> participant_train_df <- read.table("subject_train.txt", header=FALSE, col.names = c("participant_id"))
>> activity_df <- read.table("activity_labels.txt", header=FALSE, col.names = c("id","activity"))

> 6. It adds a new column called 'activity_id' in the x_test_df and x_train_df data frames. This column has the id of the activity(WALKING, STANDING, etc...) which will be merged later. The new column is also added to the 'column_names_vector'
>> x_train_df$activity_id <- y_train_df[,1]
>> x_test_df$activity_id <- y_test_df[,1]
>> column_names_vector <- append(column_names_vector, "activity_id", after = length(column_names_vector))

> 7. It adds a column in the x_test_df and x_train_df data frames identifying each measuremnet with a participant. The participant name will follow the pattern 'participant_id'. The new column is also added to the 'column_names_vector'
>> x_test_df$participant <- with(participant_test_df, paste("participant", participant_id, sep="_"))
>> x_train_df$participant <- with(participant_train_df, paste("participant", participant_id, sep="_"))
>> column_names_vector <- append(column_names_vector, "participant", after = length(column_names_vector))

> 8. Then, for the assignment 1 it appends the two data frames (x_train_df and x_test_df)
>> appended_df <- rbind(x_train_df, x_test_df)

> 9. For the assignement 2 it creates several vectors with all the column indexes for the columns that will be filtered, that means:
>> It gets all the indexes of columns that use the mean function using:
>>> mean_columns_indexes <- grep("\\-mean\\(\\)", column_names_vector, ignore.case=TRUE)
>> It gets all the indexes of columns that use the 'standard deviation' function using:
>>> std_columns_indexes <- grep("\\-std\\(\\)", column_names_vector, ignore.case=TRUE)
>> It gets also the indexes of 'activity_id' and 'participant' columns which will also be included when it will filter the columns
>>> activity_id_column_index <- grep("activity_id", column_names_vector, ignore.case=TRUE)
>>> participant_id_column_index <- grep("participant", column_names_vector, ignore.case=TRUE)
>> It then concatenates and sorts the indexes to get an ordered list of indexes to filter the data frame appended_df
>>> columns_to_use <- sort(c(mean_columns_indexes, std_columns_indexes, activity_id_column_index, participant_id_column_index))

> 10. So, to finish assignment 2, it finally filters the data frame appended_df using the vector 'columns_to_use' above
>> filtered_df <- appended_df[,columns_to_use]

> 11. For the assignment 3, it joins the activity data frame with the recently created filtered_df (above) to get the activity labels in each measurement. It also removes the 'activity_id' from the recent created data frame merged_df just to keep the data frame clean
>> merged_df = merge(filtered_df, activity_df, by.x="activity_id", by.y="id")
>> merged_df <- merged_df[,!(names(merged_df) %in% c("activity_id"))]

> 12. For assignment 4, it renames some abreviations in columns to try to make them clear for the user
>> colnames(merged_df) <- gsub("Acc", "Accelerator", colnames(merged_df))
>> colnames(merged_df) <- gsub("Mag", "Magnitude", colnames(merged_df))
>> colnames(merged_df) <- gsub("Gyro", "Gyroscope", colnames(merged_df))

> 13. For assignment 5 it creates a tidy data set grouping the measurements by participant and activity and applying the function 'mean' to each variable
>> merged_table <- data.table(merged_df)
>> tidy_data <- merged_table[, lapply(.SD, mean), by = 'participant,activity']

> 14. To finish it creates a file int the working directory, using the tiny data set created above
>> write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)