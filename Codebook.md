#  Code Book for script run_analysis.R

 This code book describes the work that was done in the script and how it works.
 
#  Link to the Data

The data used in this project is stored in : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# About the Data

The measurements contained in this data set were acquired using the accelerometer and gyroscope of a samsung galaxy ii smartphone for 6 activities.

# Datasets and files in the zip

This are the files and datasets avalaible in UCI HAR DATASET:

'features_info.txt': Information about the variables used on features measured

'features.txt': List of features measured by smartphone.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

'activity_labels.txt': Activities detected by smartphone.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

# ¿How we transform the data?

1. Merge the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5 .From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# ¿How the script works?
1. Call the libraries needed to work optimally.
2. Read the data set of training and test.
3. Read features and the six activities from the directory.
4. Select only mean and standart desviation data variables from all labels.
5. The datasets are merged and reorganized.
6. Write the tidy data in a file called "Tidy_data.txt"
