# Getting and Cleaning Data Course Project
This repository contains the R script, run_analysis.R required for the final project for Getting and Cleaning Data course. 

## Purpose of the project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
## Following tasks are performed in the run_analysis.R file
* The dataset is downloaded if it is not present in the working directory
* The training and test datasets are merged into one data set, keeping only the measurements on mean and standard deviation
* Activity info is loaded to give appropriate labels to the activities in data set
* Finally, a tidy data set is created with the average of each variable for each activity and each subject
* The tidy data set obtained is written to a file named "TidyDataset.txt"  

Another file, CodeBook.md describes the various variables and transformations performed to obtain cleaned data in TidyDataset.txt
