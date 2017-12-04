## Process Accelerometer and Gyroscope Data

## Get and format variable names
# Load variable names
vars <- readLines("features.txt")
vars <- unlist(lapply(vars, function(x){gsub("^[0-9]+ *", "", x)}))

## Get and join data sets
# Load train datasets
train_x <- read.table("X_train.txt", 
                      header=FALSE, col.names = vars)
train_y <- read.table("y_train.txt", 
                      header=FALSE, col.names = "activity")
train_subject <- read.table("subject_train.txt", 
                            header=FALSE, col.names = "subject")

# bind x and y, train
train <- cbind(train_subject, train_y, train_x)

# Load test datasets
test_x <- read.table("X_test.txt", 
                     header=FALSE, col.names = vars)
test_y <- read.table("y_test.txt", 
                     header=FALSE, col.names = "activity")
test_subject <- read.table("subject_test.txt", 
                           header=FALSE, col.names = "subject")

# bind x and y, test
test <- cbind(test_subject, test_y, test_x)

# bind train and test sets
full_data <- rbind(train, test)

## Subset data on mean and standard deviation
full_data <- full_data[, grepl("std|mean|subject|activity", names(full_data))]
full_data <- full_data[, !grepl("Freq", name(full_data))]
