library(dplyr)

# Download the dataset

filename <- "Coursera.zip"

# Checking if file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = filename, method="curl")
}  

# Checking the folder 
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# (a) tables are loaded into R and put common names to columns

features <- read.table("./UCI HAR Dataset/features.txt", 
                       col.names = c("n","functions"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("code", "activity"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$functions)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1. The code merges the training and the test sets to create one data set.

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_table <- cbind(Subject, Y, X)

# 2. Extracts only the measurements on the mean and standard deviation for 
# each measurement. 

Clean_Data <- Merged_table %>% select(subject, code, contains("mean"), 
                                   contains("std"))

# 3 Uses descriptive activity names to name the activities in the data set

Clean_Data$code <- activities[Clean_Data$code, 2]

# 4 Appropriately labels the data set with descriptive variable names.

names(Clean_Data)[2] = "activity"
names(Clean_Data)<-gsub("Acc", "Accelerometer", names(Clean_Data))
names(Clean_Data)<-gsub("Gyro", "Gyroscope", names(Clean_Data))
names(Clean_Data)<-gsub("BodyBody", "Body", names(Clean_Data))
names(Clean_Data)<-gsub("Mag", "Magnitude", names(Clean_Data))
names(Clean_Data)<-gsub("^t", "Time", names(Clean_Data))
names(Clean_Data)<-gsub("^f", "Frequency", names(Clean_Data))
names(Clean_Data)<-gsub("tBody", "TimeBody", names(Clean_Data))
names(Clean_Data)<-gsub("-mean()", "Mean", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-std()", "STD", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-freq()", "Frequency", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("angle", "Angle", names(Clean_Data))
names(Clean_Data)<-gsub("gravity", "Gravity", names(Clean_Data))

# 5 From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

Final_table <- Clean_Data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Final_table, "Final_table.txt", row.name=FALSE)

# checar

str(Final_table)

Final_table

