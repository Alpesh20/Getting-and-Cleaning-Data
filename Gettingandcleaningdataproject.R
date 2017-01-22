# Step 0: Reading Data and upzip into R.

# Set working director
#SetWd("C:/Users/Alpesh/Documents/1. Coursera/GACD Week 4/project")
setwd("~/1. Coursera/GACD Week 4/project")

# Download data
Projecturl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = Projecturl, destfile = "Dataset.zip")

# Unzip the data set
unzip(zipfile="Dataset.zip", exdir = "./project")

# setting working director
Setwd("C:/Users/Alpesh/Documents/1. Coursera/GACD Week 4/project/UCI HAR Dataset")

# Reading data from files
# Test Data
Testx <-read.table("UCI HAR Dataset/test/X_test.txt")
str(Testx)
Testy <- read.table("UCI HAR Dataset/test/y_test.txt")
str(Testy)
Sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
str(Sub_test)

# Reading training data
Trainx <- read.table("UCI HAR Dataset/train/x_train.txt")
str(Trainx)
Trainy <- read.table("UCI HAR Dataset/train/y_train.txt")
str(Trainy)
Sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
str(Sub_train)

# Reading activity table
ALabels <- read.table("UCI HAR Dataset/activity_labels.txt")
str(ALabels)
#Reading Featur Vector
Features <- read.table("UCI HAR Dataset/features.txt")
str(Features)



# Step1:Merges the training and the test sets to create one data set.

# Naming and Assinging columns names
colnames(Testx) <- Features[,2]
colnames(Testy) <-  "activityid"
colnames(Sub_test) <- "Subjectid"

colnames(Trainx) <-Features[,2]
colnames(Trainy) <- "activityid"
colnames(Sub_train) <- "Subjectid"

colnames(ALabels) <- c('activityid', 'activitytype')



# Step 2:Extracts only the measurements on the mean and standard deviation for each measurement.

# Merger Data in one Data Set
Mer_Train <- cbind(Trainx, Trainy, Sub_train)
Mer_Test <-  cbind(Testx, Testy, Sub_test)
Overall_Dataset <- rbind(Mer_Test, Mer_Test)



# Step 3: Uses descriptive activity names to name the activities in the data set

# Reading columns
Datasetone <-  colnames(Overall_Dataset)
head(Datasetone)

# Vector for ID, Mean and STD
Mean_and_std <- (grepl("activityid" , Datasetone)   |
                   grepl("Subjectid" , Datasetone)  |
                   grepl("mean..", Datasetone)      |
                   grepl("std..", Datasetone)
                )

# subset from Ovreall_Dataset
subsetforMeanandStd <- Overall_Dataset[,Mean_and_std == TRUE]



# Step # 4 Appropriately labels the data set with descriptive variable names.
CombinwithActivityNames <- merge(subsetforMeanandStd, ALabels, by='activityid', all.x=TRUE)



# Step 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Creating Second Dataset
Seconddataset <- aggregate(. ~Subjectid + activityid, CombinwithActivityNames, mean)
Seconddataset <- Seconddataset[order(Seconddataset$Subjectid, Seconddataset$activityid),]

# writing second tidy dataset
write.table(Seconddataset,"SecondTidyData.txt" , row.names = FALSE)


# End of the project
