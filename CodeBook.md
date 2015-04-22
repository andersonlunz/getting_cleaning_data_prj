## Information About the Tidy Data Set (Codebook)
The tidy data set generated on file "tidy_data.txt" was based on the study detailed at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The source data set used to generate this tidy data set was obtained at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

There study was conducted with 30 participants with age between 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. Data from the smartphone sensors were captured in 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

The tidy data set "tidy_data.txt" has 180 observations (measurements) and 68 columns (variables). The data set is grouped by its first two columns ("activity" and "subject") which represent the identification of each participant of the study and the activity observed in the measurement. The other columns represents the arithimetic mean of each variable measured on the study.




There are two major variable domains which are variables started with "time" representing "time" values and variables started with "frequency" representing frequency values.

Variables containing accelerometer and gyroscope on the name refere to values measured by an accelerometer sensor and a gyroscope.

The letters X,Y and Z at the end of the variable names represent de axis related to the measurement.


Variables types on this data set:

activity                                      : Factor w/ 6 levels "LAYING", "SITTING", "STANDING". "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"
subject                                       : Character  from "subject_01" to "subject_30"
timeBodyAccelerometer-mean()-X                : Numeric  
timeBodyAccelerometer-mean()-Y                : Numeric  
timeBodyAccelerometer-mean()-Z                : Numeric  
timeBodyAccelerometer-std()-X                 : Numeric  
timeBodyAccelerometer-std()-Y                 : Numeric  
timeBodyAccelerometer-std()-Z                 : Numeric  
timeGravityAccelerometer-mean()-X             : Numeric  
timeGravityAccelerometer-mean()-Y             : Numeric  
timeGravityAccelerometer-mean()-Z             : Numeric  
timeGravityAccelerometer-std()-X              : Numeric  
timeGravityAccelerometer-std()-Y              : Numeric  
timeGravityAccelerometer-std()-Z              : Numeric  
timeBodyAccelerometerJerk-mean()-X            : Numeric  
timeBodyAccelerometerJerk-mean()-Y            : Numeric  
timeBodyAccelerometerJerk-mean()-Z            : Numeric  
timeBodyAccelerometerJerk-std()-X             : Numeric  
timeBodyAccelerometerJerk-std()-Y             : Numeric  
timeBodyAccelerometerJerk-std()-Z             : Numeric  
timeBodyGyroscope-mean()-X                    : Numeric  
timeBodyGyroscope-mean()-Y                    : Numeric  
timeBodyGyroscope-mean()-Z                    : Numeric  
timeBodyGyroscope-std()-X                     : Numeric  
timeBodyGyroscope-std()-Y                     : Numeric  
timeBodyGyroscope-std()-Z                     : Numeric  
timeBodyGyroscopeJerk-mean()-X                : Numeric  
timeBodyGyroscopeJerk-mean()-Y                : Numeric  
timeBodyGyroscopeJerk-mean()-Z                : Numeric  
timeBodyGyroscopeJerk-std()-X                 : Numeric  
timeBodyGyroscopeJerk-std()-Y                 : Numeric  
timeBodyGyroscopeJerk-std()-Z                 : Numeric  
timeBodyAccelerometerMagnitude-mean()         : Numeric  
timeBodyAccelerometerMagnitude-std()          : Numeric  
timeGravityAccelerometerMagnitude-mean()      : Numeric  
timeGravityAccelerometerMagnitude-std()       : Numeric  
timeBodyAccelerometerJerkMagnitude-mean()     : Numeric  
timeBodyAccelerometerJerkMagnitude-std()      : Numeric  
timeBodyGyroscopeMagnitude-mean()             : Numeric  
timeBodyGyroscopeMagnitude-std()              : Numeric  
timeBodyGyroscopeJerkMagnitude-mean()         : Numeric  
timeBodyGyroscopeJerkMagnitude-std()          : Numeric  
frequencyBodyAccelerometer-mean()-X           : Numeric  
frequencyBodyAccelerometer-mean()-Y           : Numeric  
frequencyBodyAccelerometer-mean()-Z           : Numeric  
frequencyBodyAccelerometer-std()-X            : Numeric  
frequencyBodyAccelerometer-std()-Y            : Numeric  
frequencyBodyAccelerometer-std()-Z            : Numeric  
frequencyBodyAccelerometerJerk-mean()-X       : Numeric  
frequencyBodyAccelerometerJerk-mean()-Y       : Numeric  
frequencyBodyAccelerometerJerk-mean()-Z       : Numeric  
frequencyBodyAccelerometerJerk-std()-X        : Numeric  
frequencyBodyAccelerometerJerk-std()-Y        : Numeric  
frequencyBodyAccelerometerJerk-std()-Z        : Numeric  
frequencyBodyGyroscope-mean()-X               : Numeric  
frequencyBodyGyroscope-mean()-Y               : Numeric  
frequencyBodyGyroscope-mean()-Z               : Numeric  
frequencyBodyGyroscope-std()-X                : Numeric  
frequencyBodyGyroscope-std()-Y                : Numeric  
frequencyBodyGyroscope-std()-Z                : Numeric  
frequencyBodyAccelerometerMagnitude-mean()    : Numeric  
frequencyBodyAccelerometerMagnitude-std()     : Numeric  
frequencyBodyAccelerometerJerkMagnitude-mean(): Numeric  
frequencyBodyAccelerometerJerkMagnitude-std() : Numeric  
frequencyBodyGyroscopeMagnitude-mean()        : Numeric  
frequencyBodyGyroscopeMagnitude-std()         : Numeric  
frequencyBodyGyroscopeJerkMagnitude-mean()    : Numeric  
frequencyBodyGyroscopeJerkMagnitude-std()     : Numeric