# Getting-and-Cleaning-Data
## week 4 Assignment

This submission includes R code that assumes that the working directory contains sub-folders "test" and "train".
The file containing the code is run_analysis.R .

Here is a description of the code in run_anaysis.R:

   I have a function named "getDataSet <- function (dataSetName )", where the dataSetName specifies whether it's
   "train" or "test".
   This function does the following:
   - Reads in the 3 files involved with this specific data set -  y_, X_ and subject_, which contain the activities, values of the         measured features and subject ids.
   - Extracts only those columns that include std deviation or mean, using "select" and "grep"
   - Combines subjects, activities and values into one data frame
   - Labels the data set with descriptive variable names, by removing the numerical prefix and parenthese, replacing all dashes "-"        with periods "." and converting to lower case
   - Returns the specified data set to the caller

  The code calls this function twice to get the 2 data sets ("train" and "test").
  Then it combines them to one big dataset.
  The code goes on to use descriptive activity names to name the activities in the data set, by assigning a factor (with labels) to the "activities" column.
  The code collects the means of all measured features by subject and by activity, by using "aggregate"
  and then uses "melt" to get an elongated style of table or all measures are combined into one column. So there is one row for each observation (average of particular measure), which is identified by subject and activity.
  
  This documentation is sparsed in the code, so that it should be easier to understand while following the actual code.
  
  The original codebook of the features is attached, because it contains the names and explanations of the original measures.
  My codebook.txt contains only additional information.
