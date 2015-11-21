# run_analysis.R
# The following steps will be performed:
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.


# Set the working directory
setwd("C:/Users/Chad/Desktop/Data Science/Getting & Cleaning Data/UCI HAR Dataset")

# 1. Merge the training and the test sets to create one data set.

# Import the training data, features, and activity type
xTrain <- read.table('./train/X_train.txt',header=FALSE)
yTrain <- read.table('./train/y_train.txt',header=FALSE)
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)
features <- read.table('./features.txt',header=FALSE)
activity <- read.table('./activity_labels.txt',header=FALSE)

# Assign column names
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"
colnames(subjectTrain) <- "subjectId"
colnames(activity) <- c('activityId','activityType')

# Final training data set
train <- cbind(yTrain, subjectTrain, xTrain)

# Import the test data
xTest <- read.table('./test/X_test.txt',header=FALSE)
yTest <- read.table('./test/y_test.txt',header=FALSE)
subjectTest <- read.table('./test/subject_test.txt',header=FALSE)

# Assign column names
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"
colnames(subjectTest) <- "subjectId"

# Final test dataset
test <- cbind(yTest, subjectTest, xTest)

# Merge the train and test datasets
final <- rbind(train, test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
col <- colnames(final)
logical <- (grepl("activity..",col) | grepl("subject..",col) | grepl("-mean..",col) & !grepl("-meanFreq..",col))

final <- final[logical == TRUE]

# 3. Use descriptive activity names to name the activities in the data set

final <- merge(final, activity, by='activityId',all.x=TRUE)

# 4. Appropriately label the data set with descriptive variable names.

col <- colnames(final)
for(i in 1:length(col)){
        col[i] <- gsub("\\()","",col[i])
        col[i] <- gsub("-std$","StDev",col[i])
        col[i] <- gsub("-mean","Mean",col[i])
        col[i] <- gsub("^(t)","time",col[i])
        col[i] <- gsub("^(f)","freq",col[i])
        col[i] <- gsub("[Gg]ravity","Gravity",col[i])
        col[i] <- gsub("([Bb]ody[Bb]ody)","Body",col[i])
        col[i] <- gsub("[Gg]yro","Gyro",col[i])
        col[i] <- gsub("AccMag","AccMagnitude",col[i])
        col[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",col[i])
        col[i] <- gsub("JerkMag","JerkMagnitude",col[i])
        col[i] <- gsub("GyroMag","GyroMagnitude",col[i])
}

colnames(final) <- col

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

# Remove activityType column
removeActivity <- final[,names(final) != 'activityType']

# Include just the mean of each variable
tidy <- aggregate(removeActivity[,!(names(removeActivity) %in% c('activityId','subjectId'))],by=list(activityId=removeActivity$activityId,subjectId=removeActivity$subjectId),mean)
tidy <- merge(tidy,activity,by='activityId',all.x=TRUE)

# Export the tidy dataset
write.table(tidy, './tidy.txt', row.names=FALSE,sep='\t')















































