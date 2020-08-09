#run_analysis.R---->

#   1.  Merges the training and the test sets to create one data set.
#   2.  Extracts only the measurements on the mean and standard deviation 
#     for each measurement
#   3.  Uses descriptive activity names to name the activities in the data set.
#   4.  Appropriately labels the data set with descriptive variable names.
#   5.  Creates a second, independent tidy data set with the average of each
#      variable for each activity and each subject.


#------------------------------------------------------------------- IMPORT LIBRARIES SITE
    
library(data.table) #Here we load the libraries we will need.  

library(reshape2)  #Here we load the libraries we will need. 

#--------------------------------------------------------------------- LOADING ACTIVITY LABELS FEATURES

act <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2] #Import act. labels (column)

feat <- read.table("./UCI HAR Dataset/features.txt")[,2] #Import features for dataset (column)

meanstd <- grepl("mean|std", feat) #Grep to sarch and ONLY preserve features that contains mean and std.

#------------------------------------------------------------------ READING DATA SITE (MEAN|STD)

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt") #Read xtest

ytest<- read.table("./UCI HAR Dataset/test/y_test.txt") #Read ytest

stest <- read.table("./UCI HAR Dataset/test/subject_test.txt") #Subject

names(xtest) <- feat #giving features to the columns in data frame.

xtest <- xtest[,meanstd] #Columns with mean|std.

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt") #Read xtrain

ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt") #Read ytrain

strain <- read.table("./UCI HAR Dataset/train/subject_train.txt") #Subject

names(xtrain) <- feat #giving features to the columns in data frame.

xtrain = xtrain[,meanstd] #same, only std and mean

#-------------------------------------------------------------- ACTIVITY ID AND LABELS.

ytest[,2] <- act[ytest[,1]] #Add activity label to ytest

names(ytest) <- c("Activity_ID", "Activity_Label") #Rename with a descriptive name.

names(stest) <- "Subject" #Rename with a descriptive name.

ytrain[,2] = act[ytrain[,1]] #Add activiy labels to train

names(ytrain) = c("Activity_ID", "Activity_Label")

names(strain) = "Subject"  #Rename with a descriptive name.

#-------------------------------------------------------------------- MERGING DATA SITE

testdata <- cbind(as.data.table(stest), ytest, xtest) #Merging - test data.

traindata <- cbind(as.data.table(strain), ytrain, xtrain)  #Merging - train data


#--------------------------------------------------------------------- MERGING BOTH DATA FRAMES.

mergeddata <- rbind(testdata, traindata)

#--------------------------------------------------------------------TIDYING DATASETS

labels   <- c("Subject", "Activity_ID", "Activity_Label") 

dlabels <- setdiff(colnames(mergeddata), labels) #Only mean|std labels, our interest.

melted <- melt(mergeddata, id = labels, measure.vars = dlabels) 
#collapse (using the function melt) the df retaining labels, and bring any others to the rows.

#-----------------------------------------------------------------------------MEAN FUNCTION


tidydata <- dcast(melted, Subject + Activity_Label ~ variable, mean) # Apply mean function through dcast.

#------------------------------------------------------------------------------- OUTPUT DATA SET
write.table(tidydata, file = "./tidy_data.txt",row.names=FALSE)