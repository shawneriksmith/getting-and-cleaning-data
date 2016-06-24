# Merge the training and the test sets to create one data set.
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_label <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_label <- read.table("./UCI HAR Dataset/test/y_test.txt") 
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
join_data <- rbind(train_data, test_data)
join_label <- rbind(train_label, test_label)
join_subject <- rbind(train_subject, test_subject)

# Extract the mean and standard deviation
features <- read.table("./UCI HAR Dataset/features.txt")
mean_std_index <- grep("mean\\(\\)|std\\(\\)", features[, 2])
join_data <- join_data[, mean_std_index]
names(join_data) <- gsub("\\(\\)", "", features[mean_std_index, 2]) # remove "()"
names(join_data) <- gsub("mean", "Mean", names(join_data)) # capitalize M
names(join_data) <- gsub("std", "Std", names(join_data)) # capitalize S
names(join_data) <- gsub("-", "", names(join_data)) # remove "-" in column names 

# Descriptive activity names
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[join_label[, 1], 2]
join_label[, 1] <- activityLabel
names(join_label) <- "activity"

# Appropriately label the data
names(join_subject) <- "subject"
clean_data <- cbind(join_subject, join_label, join_data)
write.table(clean_data, "merged_data.txt") # write out the 1st dataset

# Create independent tidy data set with the average of each variable
subjectLen <- length(table(join_subject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(clean_data)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(clean_data)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(join_subject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == clean_data$subject
    bool2 <- activity[j, 2] == clean_data$activity
    result[row, 3:columnLen] <- colMeans(clean_data[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
write.table(result, "data_with_means.txt") # write out the 2nd dataset