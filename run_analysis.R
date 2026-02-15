# run_analysis.R
# Author: Saurabh
# Purpose: Clean and tidy the UCI HAR Dataset

# Load necessary libraries
library(dplyr)
library(data.table)

# Step 0: Set working directory (optional)
# setwd("YOUR_PROJECT_PATH")

# Step 1: Download and unzip data
if(!file.exists("UCI HAR Dataset")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile = "dataset.zip")
  unzip("dataset.zip")
}

# Step 2: Read features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

# Step 2: Read training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

# Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")

# Step 3: Merge training and test datasets
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
full_data <- rbind(train, test)

# Step 4: Extract only mean and standard deviation measurements
mean_std_columns <- grepl("mean\\(\\)|std\\(\\)|subject|activity", colnames(full_data))
data_mean_std <- full_data[, mean_std_columns]

# Step 5: Use descriptive activity names
data_mean_std$activity <- factor(data_mean_std$activity, 
                                 levels = activities$id, 
                                 labels = activities$activity)

# Step 6: Label dataset with descriptive variable names
names(data_mean_std) <- gsub("\\()", "", names(data_mean_std))
names(data_mean_std) <- gsub("-", "_", names(data_mean_std))
names(data_mean_std) <- gsub("^t", "TimeDomain_", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "FrequencyDomain_", names(data_mean_std))
names(data_mean_std) <- gsub("Acc", "Accelerometer", names(data_mean_std))
names(data_mean_std) <- gsub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))

# Step 7: Create tidy dataset with average of each variable for each activity and subject
tidy_data <- data_mean_std %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean = mean))

# Save tidy dataset
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

# Message
cat("Tidy dataset created and saved as tidy_data.txt\n")
