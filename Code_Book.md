

The run_analysis.R script prepares the data as guided in the 5 steps in the 
course project’s definition.

First Download the dataset.
        Dataset downloaded and extracted under the folder called UCI HAR Dataset

Second. Assign each data to variables
        
        features <- features.txt 
        The features selected for this database come from the accelerometer and 
        gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
        
        activities <- activity_labels.txt
        List of activities performed when the corresponding measurements were taken         and its codes (labels)
        
        subject_test <- test/subject_test.txt
        contains test data of 9/30 volunteer test subjects being observed
        
        x_test <- test/X_test.txt 
        contains recorded features test data
        
        y_test <- test/y_test.txt 
        contains test data of activities’code labels
        
        subject_train <- test/subject_train.txt 
        contains train data of 21/30 volunteer subjects being observed
        
        x_train <- test/X_train.txt 
        contains recorded features train data
        
        y_train <- test/y_train.txt 
        contains train data of activities’code labels

Third. the script Merges the training and the test sets to create one data set

        X (10299 rows, 561 columns) is created using rbind() function that merges x_train and x_test 
        Y (10299 rows, 1 column) is created using rbind() function that merges y_train and y_test 
        Subject (10299 rows, 1 column) is created using rbind() function that merges subject_train and subject_test
        Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

    The script Extracts only the measurements on the mean and standard deviation for each measurement
        TidyData is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

    The script uses descriptive activity names to rename the activities in the data set.
    Numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

    Then the script labels the data set with better variable names
        code column in TidyData renamed into activities
        All Acc in column’s name renamed by Accelerometer
        All Gyro in column’s name renamed by Gyroscope
        All BodyBody in column’s name renamed by Body
        All Mag in column’s name renamed by Magnitude
        All start with character f in column’s name renamed by Frequency
        All start with character t in column’s name renamed by Time

    The script then takes the data set in step 4 and creates a second tidy data set with the average of each variable for each activity and each subject
        "FinalData" set is created with sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
        
    The scriptExport exports FinalData into FinalData.txt file.

