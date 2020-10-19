---
title: "Accelerometers Cookbook"
author: "Javier Sanmiguel"
date: "10/18/2020"
output: html_document
---

```

## **Getting and downloading data**

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.  A scrip named run_analysis.R was written to get, download, extract, manipulate and clean data sets, so that a new tidy data set is created which will be  easy to work with. 

The original data set it is found at this location:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Data is download and unzipped at a location already set up using download.file(), and unzip() functions.  There are eight "txt" files saved under the folder named "UCI HAR Dataset".  Three test files are saved in a sub-folder test.  Three trail files are saved in sub-folder named trail.

## **Assigning and Labeling data sets**

x_tests and X_train are the features of accelerometer, while y_tests and y_train are activity codes and names.  Feature names and activities are in tables named features and activity_labels.  Data sets are created as follows by using read.table() function

*featuresnames <- features.txt*
*activities <- activity_labels.txt*

*subjecttest <- subject_test.txt*
*featuretest <- X_test.txt*
*activitytest <- y_test.txt*

*subjecttrain <- subject_train.txt*
*featuretrain <- X_train.txt*
*activitytrain <- y_train.txt*

## **Merging test and traing data sets to create a compalited data set**

subject, feature, and activity data sets are mergered by using rbind() function. Then the three data sets are merged by using cbind() function.  The order of binding is subject -> activity ->  feature. The compiled data set is named "compiledata"

## **Extract only the measurements on the mean and standard deviation for each measurement**

A data set named "compiledata_mean_std" is created after subsetting "compiledata" data set, by selecting only subject, code, and mesuarements of "mean" and "std" for each mesuarement

## **Change activity code for descriptive activity name**

A new dataset is created "tidycompiledata". The code for each activity is change by the descritive name subtting activities table

## Change label names so that they are descriptive

The variables/mesuarements names are modifiy so that they are descritived. The following are the necessary changes

code <- "activity"
*"^t"        was replaced by  "Time"*
* "^f"       was replaced by  "Frequency"*
* "-freq"    was replaced by  "Frequency"*
* "-mean"    was replaced by  "Mean"*
* "-std"     was replaced by  "STD"*
* "Acc"      was replaced by  "Accelerometer"*
* "Gyro"     was replaced by  "Gyroscope"*
* "Mag"      was replaced by  "Magnitude"*
* "BodyBody" was replaced by  "Body"*
* "tBody"    was replaced by  "TimeBody"*
* "angle"    was replaced by  "Angle"*
* "gravity"  was replaced by  "Gravity"*
* "\\()"     was replaced by  ""*
 
## **Creating a tidy data set with mean value for each variable

Summarized data set is created using summirize() funtion.  The dat set was summarized by subject and activity. Then the dataset is order by subject and activity by using arrange() function.  Finally, a text file is created by using write.table() function

