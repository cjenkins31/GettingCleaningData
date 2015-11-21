# CodeBook.md
# Getting & Cleaning Data Course Project

## Data
A full description of the data can be found at [The UCI Machine Learning Repository][1]

The source data can be found [here][2].

## Data Set Information (from the UCI Machine Learning Repository)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information (from the UCI Machine Learning Repository)
For each record in the dataset it is provided: 

 - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
 - Triaxial Angular velocity from the gyroscope. 
 - A 561-feature vector with time and frequency domain variables. 
 - Its activity label. 
 - An identifier of the subject who carried out the experiment.

## Process

Download the data and unzip the files.  The files will be in the 'UCI HAR Dataset' folder.

You will need to use the following files for this project:

 - ./activity_labels.txt
 - ./features.txt
 - ./train/X_test.txt
 - ./train/y_test.txt
 - ./train/subject_test.txt
 - ./test/X_test.txt
 - ./test/y_test.txt
 - ./test/subject_test.txt

### Step 1: Merge the train and test sets to create one data set

 - Read each of the files listed above into a table
 - Assign column names to each file so they can be merged
 - Merge the train data and test data separately using cbind() for each
 - Create one data set by merging the train and test data sets using rbind()

### Step 2. Extract only the measurements on the mean and standard deviation for each measurement.

 - Create a logical vector that contains TRUE values for the ID, mean and stdev columns and FALSE otherwise. 
 - Update the data set so only the subset of data where the logical vector is TRUE remains

### Step 3. Use descriptive activity names to name the activities in the data set

 - Merge the data set from step 2 with the activity table to include descriptive activity names

### Step 4. Appropriately label the data set with descriptive variable names.

 - Rename columns in the data set so they are more descriptive
 - Use a for loop to go through all the column names
 - Replace values using the gsub() function

### Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

 - Create a data set with the 'ActivityType' column removed
 - Using the aggregate function, create a data set with just the mean of each variable for each activity and each subject
 - Create the final tidy data set by merging the data set from the step above with the activity data set

### Write the tidy data set to the working directory as 'tidy.txt'

 
  [1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  [2]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip