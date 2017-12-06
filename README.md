# Wearable Computing

Final Project for J Hopkins - Get &amp; Clean Data

## Introduction

This repository is divided into data files, data processing code, and output data files. The [original data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is from the UCI Machine Learning Repository and consists of cell phone accelerometer and gyroscope data labeled with one of six activities the users was engaged in at the moment of measurement. The data set is divided into train and test sets and labeled for maching learning practice; however for this repository it's used for data cleaning and tidying exercises.

## Repository Contents

`activity_labels.txt` - table of activities and their integer encodings

`features.txt` - enumerated list of all 561 measurement variable names

`features_info.txt` - README-like description of features and feature names

`get_clean_project_script.R` - code to read, clean, format, and tidy data

`long_data.txt` - long-form tidy output from `get_clean_project_script.R`

`/test` - file containing processed and raw data for testing ML models

`/train` - file containing processed and raw data for training ML models

`wide_data.txt` - wide-form tidy output from `get_clean_project_script.R`

`code_book.Rmd` - html markdown containing information about variables in tidied dataset.

## The Data

From the Coursera project assignment page:

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

[Data Files](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run_analysis.R that does the following.

## Cleaning and Tidying Steps

### Read in and Merge Data

As a preliminary step the variable names, saved in a separate text file, are read into the global environment and stored as `vars`.

Next the train and test datasets are read in turn. Each is joined with their respective subject and activity variables before being themselves merged into the full dataset. My approached relied on calls to `cbind` and `rbind`. The previously-loaded variable names were add in the calls to `read.table`.

### Subset Data

Once all of the data is loaded and combined into a single data table, they were subset by mean and standard deviation measures.

### Rename Variables

Although far fewer than several hundred variables of the original dataset, the subset data still have what appears to me to be too many variables to rename and label by hand. For that reason the variable names are reformatted programmatically. Abbreviations such as `f` and `t` are expended so that they're meaning is obvious. Also, underscores are added to the names to make the more readable. 

*The code for this part of the file was suggested by [`Psidom`](https://stackoverflow.com/users/4983450/psidom) in a [question](https://stackoverflow.com/questions/47645903/how-to-complete-several-character-vector-formatting-steps-in-a-single-function/47646069?noredirect=1#comment82251240_47646069) posted on stackoverflow.com about improving my original implementation of this portion of the project.*

### Group, Summarize, and Tidy Data

As the last step the data was grouped by `subject` and `activity` before being summarized by the mean and being output in wide format. Code for an alternate long form is also included that just gathers the measure variable names and values from the wide format.






