# Getting and Cleaning Data Project
# Place Data in WOrking Directory
# Data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x <- rbind(x_train, x_test)

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
y <- rbind(y_train, y_test)

Subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Subject <- rbind(Subject_train, Subject_test)




# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("./UCI HAR Dataset/features.txt")
mean_sd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
joinData <- x[, mean_sd]



# 3. Uses descriptive activity names to name the activities in the data set

names(joinData) <- features[mean_sd,2]
names(joinData) <- tolower(names(joinData))
names(joinData) <- gsub("\\(|\\)","", names(joinData))

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(as.character(activity[, 2]))
activity[, 2] <- gsub("_","", activity[,2]) 
  
y[,1] = activity[y[,1],2]
colnames(y) <- "Activity"
colnames(Subject) <- "Subject"


# 4. Appropriately labels the data set with descriptive activity names. 

cleanedData <- cbind(Subject, joinData, y)
write.table(cleanedData, "merged_data.txt", row.names = FALSE) 

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(reshape2)

AllDataMelted <- melt(cleanedData, id = c("Subject", "Activity"))
AllDataMean <- dcast(AllDataMelted, Subject + Activity ~ variable, mean)

write.table(AllDataMean, "final data.txt", row.names = FALSE, quote = FALSE)
