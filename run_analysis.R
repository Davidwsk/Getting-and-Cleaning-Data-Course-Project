library(stringr)
library(dplyr)
library(reshape2)
#
# 1. Merges the training and the test sets to create one data set.
#
subject_train <- read.table("dataset/train/subject_train.txt")
X_train <- read.table("dataset/train/X_train.txt")
y_train <- read.table("dataset/train/y_train.txt")

train <- cbind(subject_train, X_train, y_train)

subject_test <- read.table("dataset/test/subject_test.txt")
X_test <- read.table("dataset/test/X_test.txt")
y_test <- read.table("dataset/test/y_test.txt")

test <- cbind(subject_test, X_test, y_test)

merged_data <- rbind(train, test)

rm(subject_train, X_train, y_train, subject_test, X_test, y_test, train, test)

features <- read.table("dataset/features.txt")
names(merged_data) <- c("subject", features$V2, "activity")



#
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
#
cols <- c("subject", features$V2[str_which(features$V2, "-mean\\(|-std\\(")], "activity")
extracted_data <- merged_data[,cols]



#
# 3. Uses descriptive activity names to name the activities in the data set
#
activity_labels <- read.table("dataset/activity_labels.txt", col.names=c("id", "activity_label"))
activity_labels$activity_label <- as.factor(activity_labels$activity_label)
labeled_data <- inner_join(extracted_data, activity_labels, by=c("activity"="id"))
labeled_data$activity <- NULL



#
# 4. Appropriately labels the data set with descriptive variable names. 
#
names(labeled_data) <- gsub("-", "_", gsub("\\(\\)", "", names(labeled_data)))



#
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
#


melted_data <- melt(labeled_data, id=c("subject", "activity_label"))

grouped_data <- melted_data %>% group_by(subject, activity_label, variable) %>% summarise(value = mean(value))

write.table(grouped_data, file="tidy-data.txt", row.name=FALSE)
