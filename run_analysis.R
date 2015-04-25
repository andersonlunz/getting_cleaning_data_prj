###############################################################################
## First Download the zip file data set and extract it on working directory  ##
## NOTE: Set your working directory before downloading the file if you want. ##
###############################################################################
setwd("/tmp/getting_cleaning_data")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="Dataset.zip",method="curl")

# Open zip files with all the files in the same directory
unzip("Dataset.zip", junkpaths = TRUE)


################################################################################################
## Read the Train and Test data sets. Adjust data sets before work on the project assignments ##
################################################################################################

# The file "features.txt" contains a list of the column names to be applied to x_train and x_test data sets.
# I'll read it to a data frame and change the x_train and x_test column names a few steps below
features_df <- read.table("features.txt", header=FALSE, col.names=c("id","feature_name"))


# So, below I'll read the x_train and x_test data sets and then set their column names
# using the "feature_name" column of the features_df data frame
x_train_df <- read.table("X_train.txt", header=FALSE)
names(x_train_df) <- features_df$feature_name

x_test_df <- read.table("X_test.txt", header=FALSE)
names(x_test_df) <- features_df$feature_name


# Now we need to add the activity_id column to x_train and x_test data frames. 
# This will add the acivity id for each observation on the data sets.
# The files y_train.txt and y_test.txt contains the activity ids for each observation in x_train and x_test 
# data sets respectively.
# As the files y_train.txt and y_test.txt have one column only, I read them in a temporary data frame and then
# I create a new column called "activity_id" on x_train and x_test data frames.
temp <- read.table("y_train.txt", header=FALSE)
x_train_df$activity_id <- temp[,1]

temp <- read.table("y_test.txt", header=FALSE)
x_test_df$activity_id <- temp[,1]


# One more step is to add the subject who performed the activity for each observation.
# I'll create another column called subject which will contain the subject identification.
# I'll modify the id prepending a "subject_" string before the id, just to be more readable.
# The files subject_train.txt and subject_test.txt contains the subject identification for each 
# observation in x_train and x_test data sets respectively. 
temp <- read.table("subject_train.txt", header=FALSE, col.names = c("subject_id"))
x_train_df$subject <- with(temp, paste("subject", sprintf("%02d",subject_id), sep="_"))

temp <- read.table("subject_test.txt", header=FALSE, col.names = c("subject_id"))
x_test_df$subject <- with(temp, paste("subject", sprintf("%02d",subject_id), sep="_"))


##################
## Assignment 1 ##
##################
# Append the two data frames and create one merged data frame
appended_df <- rbind(x_train_df, x_test_df)


##################
## Assignment 2 ##
##################
# First get all column names that are related to measurements on the mean and standard deviation
mean_std_columns <- grep("mean\\(\\)|std\\(\\)", names(appended_df))

# Add the "activity_id" and "subject" columns
columns_to_select <- c(mean_std_columns, grep("activity_id", names(appended_df)), grep("subject", names(appended_df)))

# Create a clean data frame with only the mean and standard deviation columns plus 
# "activity_id" and "subject" columns
clean_df <- subset(appended_df, select=columns_to_select)


##################
## Assignment 3 ##
##################
library(dplyr)
# First read the activity labels to a data frame
activity_df <- read.table("activity_labels.txt", header=FALSE, col.names = c("id","activity"))

# Then merge the clean_df data frame with the activity_df data frame
merged_df <- merge(clean_df, activity_df, by.x="activity_id", by.y="id")

# To keep the new data frame clean, I'll remove the activity_id column from merged_df
clean_df <- select(merged_df, -(activity_id))

##################
## Assignment 4 ##
##################
# Replace some variable names with a more descriptive text
names(clean_df) <- gsub("^t", "time", names(clean_df))
names(clean_df) <- gsub("^f", "frequency", names(clean_df))
names(clean_df) <- gsub("Acc", "Accelerometer", names(clean_df))
names(clean_df) <- gsub("Gyro", "Gyroscope", names(clean_df))
names(clean_df) <- gsub("Mag", "Magnitude", names(clean_df))
names(clean_df) <- gsub("BodyBody", "Body", names(clean_df))


##################
## Assignment 5 ##
##################
# Create a tidy data set grouping the results by activity and subject and then order the result set
# by activity and subject
library(data.table)
clean_table <- data.table(clean_df)
tidy_data <- clean_table[, lapply(.SD, mean), by = 'activity,subject']
tidy_data <- tidy_data[order(activity, subject)]

###########################
## Create Tidy Data File ##
###########################
# Write the result set in a file
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
