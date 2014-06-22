WearableData
============


# How to use
In order to tidy the data take the following steps:
1. Ensure that the UCI HAR Dataset directory is in your working directory. Additionally, folder subfolder structure should be unchanged.
2. Load the run_analysis.R script into your workspace with source("run_analysis.R").
3. Run the runDataScript() function. There are no arguments provided to this function.
4. This will generate two files in your working directory. A "tidy_data.txt" file and a "summary.txt" file.

# Output

The tidy_data.txt file includes the training data and test data joined together in a narrow fashion. The data in the file has 81 columns. The first one is the Subject and the second column is the activty. The remaining 79 columns are the variables from the features.txt file. The only features included are features are mean values or standard deviation values. The variable names are the same as they are in the feature file. However, the dashes have been replaced by underscores and the parantheses have been removed. This makes the columns easier to access interactive in R. There are 10299 rows in the file. This is the joined test and train data from the "X" files.

The summary.txt file groups the data by subject and activity. The other columns are the means of each feature grouped by subject and activity.