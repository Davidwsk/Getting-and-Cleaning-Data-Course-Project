# Code Book
generated 2014-07-10 11:04:30 during sourcing of `run_analysis.R`

## Actions performed on data:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## `grouped_data` variable

### key columns

Variable name       | Description
--------------------|------------
`subject`           | ID of subject, int (1-30)
`activity_label`    | Activity, Factor w/ 6 levels
`variable`          | Variable Name, Factor w/ 66 levels

### non-key columns

Variable name       | Description
--------------------|------------
`value`       | value 
