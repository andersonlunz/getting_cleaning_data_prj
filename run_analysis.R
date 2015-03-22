library(data.table)

# Create a temporary directory (assuming that the script is running on linux/unix machines)
dir_project <- "/tmp/project"
if(!file.exists(dir_project)){dir.create(dir_project)}
setwd(dir_project)

# Download zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="Dataset.zip",method="curl")

# Open zip files with all the files in the same directory
unzip("Dataset.zip", junkpaths = TRUE)

# Read the features data set and create a vector with the feature names 
# (it has the same number of columns of the x_train and x_test data sets)
features_df <- read.table("features.txt", header=FALSE, col.names=c("id","feature_name"))
column_names_vector <- as.vector(features_df[,"feature_name"])

# Read the rest of data sets
y_test_df <- read.table("y_test.txt", header=FALSE, col.names = c("id"))
x_test_df <- read.table("X_test.txt", header=FALSE, col.names=column_names_vector)
y_train_df <- read.table("y_train.txt", header=FALSE, col.names = c("id"))
x_train_df <- read.table("X_train.txt", header=FALSE, col.names=column_names_vector)
participant_test_df <- read.table("subject_test.txt", header=FALSE, col.names = c("participant_id"))
participant_train_df <- read.table("subject_train.txt", header=FALSE, col.names = c("participant_id"))
activity_df <- read.table("activity_labels.txt", header=FALSE, col.names = c("id","activity"))

# Add the 'activity_id' column to both x_train and x_test data sets
x_train_df$activity_id <- y_train_df[,1]
x_test_df$activity_id <- y_test_df[,1]

# Add the 'participant' column with the participant identification
x_test_df$participant <- with(participant_test_df, paste("participant", participant_id, sep="_"))
x_train_df$participant <- with(participant_train_df, paste("participant", participant_id, sep="_"))

# Add the 'activity_id' and 'participant' columns to the vector of column names
column_names_vector <- append(column_names_vector, "activity_id", after = length(column_names_vector))
column_names_vector <- append(column_names_vector, "participant", after = length(column_names_vector))


##################
## Assignment 1 ##
##################
# Append the two data frames and create one merged data frame
appended_df <- rbind(x_train_df, x_test_df)


##################
## Assignment 2 ##
##################
# Create a vector with all feature names that match the 'mean' function
mean_columns_indexes <- grep("\\-mean\\(\\)", column_names_vector, ignore.case=TRUE)

# Create a vector with all indexes of the feature names that match the 'standard deviation' function
std_columns_indexes <- grep("\\-std\\(\\)", column_names_vector, ignore.case=TRUE)

# Create a vector with the 'activity_id' index. We need to keep this column for future use.
activity_id_column_index <- grep("activity_id", column_names_vector, ignore.case=TRUE)

# Create a vector with the 'participant' index. We need to keep this column for future use.
participant_id_column_index <- grep("participant", column_names_vector, ignore.case=TRUE)

# Concatenate and sort all indexes found on variables 'mean_columns_indexes' and 'std_columns_indexes'
columns_to_use <- sort(c(mean_columns_indexes, std_columns_indexes, activity_id_column_index, participant_id_column_index))

# Filter the merged data frame, using only the columns related to 'mean' and 'standard deviation' functions
filtered_df <- appended_df[,columns_to_use]


##################
## Assignment 3 ##
##################
# Join the activity data set and the filtered data set
merged_df = merge(filtered_df, activity_df, by.x="activity_id", by.y="id")

# Remove the activity_id column as we already added the activity column (just to keep the data set clean)
merged_df <- merged_df[,!(names(merged_df) %in% c("activity_id"))]


##################
## Assignment 4 ##
##################
# Renamed some abreviations in some column names 
colnames(merged_df) <- gsub("Acc", "Accelerator", colnames(merged_df))
colnames(merged_df) <- gsub("Mag", "Magnitude", colnames(merged_df))
colnames(merged_df) <- gsub("Gyro", "Gyroscope", colnames(merged_df))


##################
## Assignment 5 ##
##################
# Create a tidy data set using the data.table
merged_table <- data.table(merged_df)
tidy_data <- merged_table[, lapply(.SD, mean), by = 'participant,activity']


###########################
## Create Tidy Data file ##
###########################
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
