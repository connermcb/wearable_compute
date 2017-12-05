## Process Accelerometer and Gyroscope Data

## Get and format variable names
# set directory path


# Load variable names
vars <- readLines("features.txt")
vars <- unlist(lapply(vars, function(x){gsub("^[0-9]+ *", "", x)}))

## Get and join data sets
# Load train datasets
train_x <- read.table("train/X_train.txt", 
                      header=FALSE, col.names = vars)
train_y <- read.table("train/y_train.txt", 
                      header=FALSE, col.names = "activity")
train_subject <- read.table("train/subject_train.txt", 
                            header=FALSE, col.names = "subject")

# bind x and y, train
train <- cbind(train_subject, train_y, train_x)

# Load test datasets
test_x <- read.table("test/X_test.txt", 
                     header=FALSE, col.names = vars)
test_y <- read.table("test/y_test.txt", 
                     header=FALSE, col.names = "activity")
test_subject <- read.table("test/subject_test.txt", 
                           header=FALSE, col.names = "subject")

# bind x and y, test
test <- cbind(test_subject, test_y, test_x)

# bind train and test sets
full_data <- rbind(train, test)

## Subset data on mean and standard deviation
full_data <- full_data[, grepl("std|mean|subject|activity", names(full_data))]
full_data <- full_data[, !grepl("Freq", names(full_data))]

## Rename variables
# get present list of variables
vars_list <- names(full_data)

# change `t` and `f` prefixes to `Time` and `Freq` respectively.
vars_list <- unlist(lapply(vars_list, function(x){gsub("^t", "Time", x)}))
vars_list <- unlist(lapply(vars_list, function(x){gsub("^f", "Freq", x)}))

# make standard deviation description clearer, capitalize
vars_list <- unlist(lapply(vars_list, function(x){gsub("std", "Stddev", x)}))
vars_list <- unlist(lapply(vars_list, function(x){gsub("mean", "Mean", x)}))

# remove periods
vars_list <- unlist(lapply(vars_list, function(x){gsub("\\.+", "", x)}))
vars_list <- unlist(lapply(vars_list, function(x){gsub("\.", "", x)}))

# add underscores for readability
vars_list <- unlist(lapply(vars_list, 
                           function(x){gsub("(?<=[a-z]).{0}(?=[A-Z])",
                                            "_", x, perl = TRUE)}))

