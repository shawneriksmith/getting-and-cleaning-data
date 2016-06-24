Getting and Cleaning Data Course Project CodeBook


This file describes the variables, data, and any transformations that were performed to tidy or clean up the data.  

* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read X_train.txt, y_train.txt and _subject_train.txt from the "./UCI HAR Dataset/train/" folder and store them in *train* variables.       
 2. Read X_test.txt, y_test.txt and _subject_test.txt from the "./UCI HAR Dataset/test" folder and store them in *test* variables.  
 3. Concatenate *test_data* to *train_data* to generate *join_data*; concatenate *test_label* to *train_label* to generate *join_label*; concatenate *test_subject* to *train_subject* to generate *join_subject*.  
 4. Read the features.txt file from the "./UCI HAR Dataset/" folder and store the data in a variable called *features*, only extract the measurements on the mean and standard deviation.
 5. Clean the column names of the subset by removing the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
 6. Read the activity__labels.txt file from the "./UCI HAR Dataset/"" folder and store the data in a variable called *activity*.  
 7. Clean the activity names in the second column of *activity* by making all names lower case and if the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore.  
 8. Transform the values of *join_label* according to the *activity* data frame.  
 9. Combine the *join_subject*, *join_label* and *joinData* by column to get *cleanedData*. Properly name the first two columns, "_subject" and "activity". The "_subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names.
 10. Write the *cleanedData* out to "merged_data.txt" file in current working directory.  
 11. Finally, generate a second independent tidy data set with the average of each measurement for each activity and each _subject. We have 30 unique _subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the *result* data frame and performing the two for-loops, we get a 180x68 data frame.
 12. Write the *result* out to "data_with_means.txt" file in current working directory. 