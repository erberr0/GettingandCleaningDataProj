This is the final project for Getting and Cleaning Data Course (Coursera).

The file run_analysis.R uses data from UCI HAR Dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
It expects the zip file to be uncompressed in the working directory.


First, the training and test sets are merged to one set. Activity values are replaced with activity names. Then, the measurements mean and standard devaiation are extracted.
A tidy dataset is created with the average of each variable for each activity and subject. This is exported to a file called "final data.txt".