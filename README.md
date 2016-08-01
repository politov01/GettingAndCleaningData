# Getting and Cleaning Data Course Project

in Coursera by John Hopkins Bloomberg School of Public Health

This repository hosts is the course project for the 
"Getting and Cleaning Data" Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory

2. Merging the training and the test sets to create one data set
2.1 Reading files
2.2 Assigning column names
2.3 Merging all data in one set
2.4 Subset only measurements for the mean and standard deviation.
2.5 Appropriately labeling the data set with descriptive variable names

3. Creates a tidy dataset that consists of the average (mean) value of 
   each variable for each subject and activity pair.
3.1 Making second tidy data set
3.2 Save result in the file `tidy.txt`.

## Files

* `CodeBook.md` describes the how to use all this, variables, the data, and any transformations or work that was performed to clean up the data.

* `run_analysis.R` contains all the code to perform the analyses described in the 5 steps. They can be launched in RStudio by just importing the file.

* The output of all steps is called `tidy.txt`, and uploaded in the course project's form.

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in
