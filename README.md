# Wearable Computing

Final Project for J Hopkins - Get &amp; Clean Data

## Introduction

This repository is divided into data files, data processing code, and output data files. The [original data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is from the UCI Machine Learning Repository and consists of cell phone accelerometer and gyroscope data labeled with one of six activities the users was engaged in at the moment of measurement. The data set is divided into train and test sets and labeled for maching learning practice; however for this repository it's used for data cleaning and tidying exercises.

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

## Code Book

Each variable name is divided into ordered descriptive components:

The first component is either `Time` or `Freq` to denote time domain or frequency domain signals respectively. 

The second component, either `Body` or `Gravity`, indicate body or gravity acceleration signals.

The third component, either `Acc` or `Gyro`, denotes whether the measure is from the accelerometer or gyroscope.

Inclusion of a the component, `Jerk`, indicates the variable is the derivation of body linear acceleration and angular velocity in time. Inclusion of the component `Mag` indicates the variable is measure of the magnitude of these three dimensional forces.

The final two components denote summary statistic and axial signal. 

The summary stat component is either `Mean` or `Stddev` denoting mean or standard deviation respectively.

The last component, axial signals, is marked with the directional variables `X`, `Y`, or `Z`.







