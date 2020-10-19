## Verify directory is already in the working directory
if(!dir.exists("gcassignment")){dir.create("gcassignment")}

##Download files to load 
assigURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(assigURL, destfile = "./accelerometersdata.zip")

##Open/Unzipping data sets
unzip("./accelerometersdata.zip")

## Register date of download
dateassignment4downloaded <- date()

## Read all 8 tables using read.table function and assign descriptive names. 
## Please pay attention to the location of the files as they are located in three separated folders
## Main folder name has spaces between words ("UCI HAR Dataset")
## x_tests and X_train are the features of accelerometer
## y_tests and y_train are activity codes and names
## verify dimensions and characteristics of the tables by using dim() and head() functions

## Read and create Labels and names tables
featuresnames <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n", "fuctions"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

## Read and create test data set
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
featuretest <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(featuretest) <- featuresnames$fuctions
activitytest <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")

## Read and create train data set
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
featuretrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(featuretrain) <- featuresnames$fuctions
activitytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Merge feature data sets
featuredata <- rbind(featuretest, featuretrain)

## Merge activity data sets
activitydata <- rbind(activitytest, activitytrain)

## Merge subject data sets
subjectdata <- rbind(subjecttest, subjecttrain)

## Compile/merge the three data sets - subject data first, follow by activity data, and finally feature data
compiledata <- cbind(subjectdata, activitydata, featuredata)

## Extract only the measurements on the mean and standard deviation for each measurement
compiledata_mean_std <- compiledata %>% select(subject, code, contains("mean"), contains("std"))

## Change activity code for descriptive activity name
tidycompiledata <- compiledata_mean_std
tidycompiledata$code <- activities[tidycompiledata$code, 2]

## Change label names so that they are descriptive
names(tidycompiledata)[2] <- "activity"
names(tidycompiledata) <- gsub("^t", "Time", names(tidycompiledata))
names(tidycompiledata) <- gsub("^f", "Frequency", names(tidycompiledata))
names(tidycompiledata) <- gsub("-freq()", "Frequency", names(tidycompiledata))
names(tidycompiledata) <- gsub("-mean()", "Mean", names(tidycompiledata))
names(tidycompiledata) <- gsub("-std()", "STD", names(tidycompiledata))
names(tidycompiledata) <- gsub("Acc", "Accelerometer", names(tidycompiledata))
names(tidycompiledata) <- gsub("Gyro", "Gyroscope", names(tidycompiledata))
names(tidycompiledata) <- gsub("Mag", "Magnitude", names(tidycompiledata))
names(tidycompiledata) <- gsub("BodyBody", "Body", names(tidycompiledata))
names(tidycompiledata) <- gsub("tBody", "TimeBody", names(tidycompiledata))
names(tidycompiledata) <- gsub("angle", "Angle", names(tidycompiledata))
names(tidycompiledata) <- gsub("gravity", "Gravity", names(tidycompiledata))
names(tidycompiledata) <- gsub("\\()", "", names(tidycompiledata))

## Summarize data set by subject and activity
summarizedcompiledata <- tidycompiledata %>% group_by(subject, activity) %>% summarise_all(list(mean))

## Ordering data by subject and activity
summarizedcompiledata <- arrange(summarizedcompiledata, subject, activity)

## Creating a text file with the tidy data
write.table(summarizedcompiledata, "FinalCompileData.txt", row.names = FALSE)


