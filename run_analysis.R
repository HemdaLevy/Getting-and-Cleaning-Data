library (dplyr)
library (reshape)
## Perform common funtionality to "test" and "train" data sets, such as reading data from files,
## selecting the required columns , manipulating and setting the the proper header names
getDataSet <- function (dataSetName )
{
  #create the filenames to read according to the argument passed to the function
  actFilename <- paste(dataSetName, "/y_", dataSetName, ".txt", sep = "")
  valueFilename <- paste(dataSetName, "/X_", dataSetName, ".txt", sep = "")
  subjectFilename <- paste(dataSetName, "/subject_", dataSetName, ".txt", sep = "")
  # read in the data
  activities <- readLines(actFilename)
  values    <- read.table(valueFilename)
  subjects  <- readLines(subjectFilename)
  
  ##Set up the names of the values, subjects and activities
  names (values) <- features
  names(subjects) <- c("subjects")
  names(activities) <- c("activities")
  
  df <- tbl_df(values)
  ## get only those columns that include std deviation or mean according to assignment requirement:
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  smallerDataSet <- select (df, grep("std\\()|mean\\()", names(data) ))
  
  ##combine subjects activities and values
  smallerDataSet <- cbind(subjects, activities, smallerDataSet)

  ##4. Appropriately labels the data set with descriptive variable names.
  theNames <- names(smallerDataSet)
  theNames <- sub ("^[0-9]+ ", "", theNames)  #Remove the numerical prefix
  theNames <- sub ("\\()", "", theNames)      #Remove all parenthese
  theNames <- gsub ("-", ".", theNames)       #Replace all dashes "-" with periods "."
  names(smallerDataSet) <- tolower(theNames)  #convert to lower case
  smallerDataSet
}

## GET THE DATA SETS

features  <- readLines("features.txt")
testSet <- getDataSet ("test")
trainSet <- getDataSet ("train")


##1.Merges the training and the test sets to create one data set.
full <- rbind(testSet, trainSet)

##3.Uses descriptive activity names to name the activities in the data set
acts <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
full$activities <- factor(full$activities, labels = acts)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Collect the means of all measured features by subject and by activity
aggregated <-aggregate(full, by=list(Group.subjects=full$subjects, Group.activities=full$activities), FUN=mean, na.rm=TRUE)
aggregated <- aggregated[, !(colnames(aggregated) %in% c("subjects","activities"))]  ##For some reason these columns are left in with NA - so I remove them myself

## "Melt"  the table - leaving columns that identify each observation (subject and and activity) and combine
## all measured features into one column
melted <- melt(aggregated, id=(c("Group.subjects", "Group.activities")))
names(melted) <- c("subjects", "activities", "measures", "average")

View(melted)
melted
