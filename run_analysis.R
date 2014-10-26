# Download and unzip to ./data/UCI HAR Dataset/
# Read data description

# 1 - Merges the training and the test sets to create one data set

  ## Accediendo a los datos
    x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
    x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
    x <- rbind(x_train, x_test)
    
    subj_train <- read.table('./data/UCI HAR Dataset/train/subject_train.txt')
    subj_test <- read.table('./data/UCI HAR Dataset/test/subject_test.txt')
    subj <- rbind(subj_train, subj_test)
    
    y_train <- read.table('./data/UCI HAR Dataset/train/y_train.txt')
    y_test <- read.table('./data/UCI HAR Dataset/test/y_test.txt')
    y <- rbind(y_train, y_test)
    

# 2 - Extracts only the measurements on the mean and standard deviation for each measurement
    features <- read.table('./data/UCI HAR Dataset/features.txt')
    mean_sd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
    x_mean_sd <- x[, mean_sd]

# 3 - Uses descriptive activity names to name the activities in the data set
    names(x_mean_sd) <- features[mean_sd, 2]
    names(x_mean_sd) <- tolower(names(x_mean_sd)) 
    names(x_mean_sd) <- gsub("\\(|\\)", "", names(x_mean_sd))
    
    activities <- read.table('./data/UCI HAR Dataset/activity_labels.txt')
    activities[, 2] <- tolower(as.character(activities[, 2]))
    activities[, 2] <- gsub("_", "", activities[, 2])
    
    y[, 1] = activities[y[, 1], 2]
    colnames(y) <- 'activity'
    colnames(subj) <- 'subject'
    
# 4 - Appropriately labels the data set with descriptive activity names.
    data <- cbind(subj, x_mean_sd, y)
    str(data)
    write.table(data, './data/Project/merged.txt')
    
# 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    average <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
    str(average)
    write.table(average, './data/Project/average.txt')
    