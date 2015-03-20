# Getting and Cleaning Data Project

# See if zip file exists, if not, then download
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip"))
{
  fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  # run on Windows, might need to add method = "curl" to download command if running on another OS
  download.file(fileURL, destfile="getdata-projectfiles-UCI HAR Dataset.zip")
}
# If zip file found and data not already extracted, unzip the file
if (file.exists("getdata-projectfiles-UCI HAR Dataset.zip") && !file.exists("UCI HAR Dataset"))
{
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

# Preparation - read in required datasets and quit and display a message if all files not found,
# otherwise proceed with each part of the project.
fileReadCounter <- 0
if (file.exists("UCI HAR Dataset"))
{
  featureNames <- read.table("UCI HAR Dataset\\features.txt")
  fileReadCounter <- fileReadCounter + 1
  activityLabels <- read.table("UCI HAR Dataset\\activity_labels.txt")
  fileReadCounter <- fileReadCounter + 1
  if (file.exists("UCI HAR Dataset\\train"))
  {
    train_X <- read.table("UCI HAR Dataset\\train\\X_train.txt")
    fileReadCounter <- fileReadCounter + 1
    train_y <- read.table("UCI HAR Dataset\\train\\y_train.txt")
    fileReadCounter <- fileReadCounter + 1
    train_subject <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
    fileReadCounter <- fileReadCounter + 1
  }
  if (file.exists("UCI HAR Dataset\\test"))
  {
    test_X <- read.table("UCI HAR Dataset\\test\\X_test.txt")
    fileReadCounter <- fileReadCounter + 1
    test_y <- read.table("UCI HAR Dataset\\test\\y_test.txt")
    fileReadCounter <- fileReadCounter + 1
    test_subject <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
    fileReadCounter <- fileReadCounter + 1
  }
}else
{
  message("Could not find UCI HAR Dataset folder. Exiting.") 
}
if (fileReadCounter != 8)
{
  message ("Could not find all required files in the UCI HAR Dataset. Exiting.")
}else
{
  # Part 1) Merge training and test data sets to create a single data set
  
  X_data <- rbind(train_X, test_X)
  y_data <- rbind(train_y, test_y)
  subject_data <- rbind(train_subject, test_subject)
    # going to hold off on cbinding everything together until all of the data columns are labeled 
    # correctly to make life easier
  
  # Part 2) Extract only the measurements on the mean and standard deviation for each measurement.
  
    # find all column names with 'mean' or 'std' in them using grep function on feature name data
    # store indices for future use
  mean_and_std_dev_column_indexes <- grep("mean|std|Mean|Std", featureNames[, 2])
    # cut out columns not having to do with mean or std deviation, only have to worry about X dataset since
    # the label and subject data don't apply
  X_data <- X_data[,mean_and_std_dev_column_indexes]
  
  # Part 3) Use descriptive activity names to name the activities in the data set
  
    # use grep to remove all occurences of '_' in the activity labels and make them all lower case to make them
    # look pretty
  activityLabels[,2] <- gsub("_", "", activityLabels[,2])
  activityLabels[,2] <- tolower(as.character(activityLabels[,2]))
    # replace the activity number with the corresponding label from the activity_labels.txt file
  y_data[,1] <- activityLabels[y_data[,1], 2]
  
  # Part 4) Appropriately labels the data set with descriptive variable names. 
  
  names(y_data) <- "activity"
  names(subject_data) <- "subject"
    # extract the column names from the dataset (features.txt) and apply the names to my merged dataset
  names(X_data) <- featureNames[mean_and_std_dev_column_indexes,2]
    # get rid of parenthesis and replace commas with dashes using grep replacement, then change all letters to lowercase
    # to make the labels pretty
  names(X_data) <- gsub("\\(|\\)", "", names(X_data))
  names(X_data) <- gsub(",", "-", names(X_data))
  names(X_data) <- tolower(names(X_data))
    #merge all columns together into a single dataset
  labeled_and_merged_data <- cbind(subject_data, y_data, X_data)
  
  # Part 5) From the data set in step 4, creates a second, independent tidy data set with the average of 
  # each variable for each activity and each subject.
  
    # get a listing of each individual test subjects to loop over
  subject_list <- unique(subject_data)[,1]
  subject_count <- length(subject_list)
    # listing of unique activities
  activity_count <- length(activityLabels[,1])
  column_count <- dim(labeled_and_merged_data)[2]
  tidy_data <- labeled_and_merged_data[1:(subject_count*activity_count),]
  
    # loop over each activity per subject and calculate the mean for each column
  current_row <- 1
  for (current_subject in 1:subject_count){
    for (current_activity in 1:activity_count){
      tidy_data[current_row,1] <- subject_list[current_subject]
      tidy_data[current_row,2] <- activityLabels[current_activity,2]
      
      holder <- labeled_and_merged_data[labeled_and_merged_data$subject==current_subject & labeled_and_merged_data$activity==activityLabels[current_activity,2],]
      tidy_data[current_row, 3:column_count] <- colMeans(holder[,3:column_count])
    
      current_row <- current_row + 1
    }
  }
    # save tidy dataset to file
  write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE)
}
