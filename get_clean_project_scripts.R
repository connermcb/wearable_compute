## Process Accelerometer and Gyroscope Data

## packages
library(dplyr)
library(reshape)
library(stringi)

## Get and format variable names
# Load variable names
vars <- readLines("features.txt")
vars <- unlist(lapply(vars, function(x){gsub("^[0-9]+ *", "", x)}))

# Load activity labels
actvs <- read.table("activity_labels.txt",
                    header=FALSE, col.names = c("activity", "activity_name"))

## Get and join data sets
# Load train datasets
train_x <- read.table("train/X_train.txt", 
                      header=FALSE, col.names = vars)
train_y <- read.table("train/y_train.txt", 
                      header=FALSE, col.names = "activity")
activity_name <- merge(train_y, actvs, by="activity")[, 2] # describe activities

train_subject <- read.table("train/subject_train.txt", 
                            header=FALSE, col.names = "subject")

# bind x and y, train
train <- cbind(train_subject, activity_name, train_x)

# Load test datasets
test_x <- read.table("test/X_test.txt", 
                     header=FALSE, col.names = vars)
test_y <- read.table("test/y_test.txt", 
                     header=FALSE, col.names = "activity")
activity_name <- merge(test_y, actvs, by="activity")[, 2] # describe activities
test_subject <- read.table("test/subject_test.txt", 
                           header=FALSE, col.names = "subject")

# bind x and y, test
test <- cbind(test_subject, activity_name, test_x)

# bind train and test sets
full_data <- rbind(train, test)

## Subset data on mean and standard deviation
full_data <- full_data[, -(516:561)]
full_data <- full_data[, grepl("std|mean|subject|activity", names(full_data))]
full_data <- full_data[, !grepl("Freq", names(full_data))]

## Rename variables
# get present list of variables
vars_list <- names(full_data)

# vectors of patterns and replacment for formatting variable names
patterns <- c('^t', '^f', 'std', 'mean', '\\.+', '(?<=[a-z])(?=[A-Z])')
replacement <- c('Time', 'Freq', 'Stddev', 'Mean', '', '_')

# reformat variable names 
vars_list <- stri_replace_all_regex(vars_list, 
                                    patterns, 
                                    replacement, 
                                    vectorize_all = F)

# reassign newly formatted names to variables
names(full_data) <- vars_list

## summarize data
# group and get mean by group
wide_data <- full_data%>%
  group_by(subject, activity_name)%>%
  summarize_all(funs(mean))

# write wide summary table to file
write.table(wide_data, "wide_data.txt", row.names = FALSE)

# reshape into long form
long_data <- wide_data%>%
  gather(key="measure", value="value", -c(1:2))

# write long summary table to file
write.table(long_data, "long_data.txt", row.names = FALSE)
