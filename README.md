GettingCleaningDataCourseProject
================================

Course Project Repository for Getting and Cleaning Data track which
is part of John Hopkins University Data Science Specialization on Coursera.

# Project Overview

## Project Goals

The purpose of this project is to demonstrate my ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that can be
used for later analysis.

## The Input Data Set
* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
* Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
* Source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* Data Set Characteristics: Multivariate, Time-Series
* Number of Instances: 10299
* Number of Attributes: 561

### Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Check the original README.txt file for further details about this dataset.

### Attribute Information

For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

## The Tidy Data Set

* Abstract: Tidy Data Set based on the Human Activity Recognition Data Set processed as instructed in the Course Project description
* Number of Instances: 180
* Number of Attributes: 88

### Data Set Information

The Tidy Data Set has been created using run_analysis.R script by
* Merging the training and the test sets to create one data set.
* Extracting only the measurements on the mean and standard deviation for each measurement. 
* Using descriptive activity names to name the activities in the data set.
* Appropriately labeling the data set with descriptive variable names. 
* Creating the second, independent Tidy Data Set with the average of each variable for each activity and each subject. 

Therefore the Tidy Data Set consitsts of the mean and standard deviation measurement of the Human Activity Recognition Data Set aggregated for each activity and each subject using the mean function.

### For each record it is provided:

* Its activity description.
* An identifier of the subject who carried out the experiments. 
* A 86-feature vector aggregated mean values with time and frequency domain variables for mean and standard deviation measurements. 

### The Tidy Data Set includes the following files

* 'README.md': This file
* 'CodeBook.md': Shows information about the variables used in the Tidy Data Set.
* 'run_analysis.R': R script which can reproduce tidy.txt step by step including comments.
* 'tidy.txt': The Tidy Data Set exported to txt file with write.table including header (uploaded to Coursera)

### Notes

* Features are normalized and bounded within [-1,1].
* Wide data form is used for the Tidy Data Set here
* Variable names are based on the original input data set however pattern matching
and replacement were used to make them more descriptive.
* It is assumed that ALL measurements which contains "mean" or "std" in its name is relevant and therefore extracted (not only those that include mean() and std() at the end).

### The run_analysis.R Script

* The provided R Script can fully reproduce the Tidy Data Set from the Input Data Set
* It follows the steps outlined in the Course Project description
* It can download the Input Data Set for convenience if required
* It includes a few check calculations for testing in comments

## References

* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
