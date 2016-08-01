library(plyr)

#####################################
#1 Downloading and unzipping dataset

##########
#1.a Download the file and put the file in the ./data folder
if(!file.exists("data"))
  {dir.create("data")
  }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = file.path("data", "Dataset.zip"), mode = "wb") #mode = "wb"

##########
#1.b Unzip dataSet to /data directory
unzip(zipfile=file.path("data","Dataset.zip"), exdir=file.path("data") )
path_data <- file.path("data" , "UCI HAR Dataset")

#####################################
#2. Merging the training and the test sets to create one data set:

###########
#2.1 Reading files
# Reading feature vector:
features <- read.table(file.path(path_data,"features.txt"),header = FALSE)

#Read descriptive activity names from "activity_labels.txt"
activityLabels <- read.table(file.path(path_data, "activity_labels.txt"),header = FALSE)

# Read the Activity files
y_test  <- read.table(file.path(path_data, "test" , "Y_test.txt" ),header = FALSE)
y_train <- read.table(file.path(path_data, "train", "Y_train.txt"),header = FALSE)

# Read Fearures files
x_test  <- read.table(file.path(path_data, "test" , "X_test.txt" ),header = FALSE)
x_train <- read.table(file.path(path_data, "train", "X_train.txt"),header = FALSE)

# Read the Subject files
subject_train <- read.table(file.path(path_data, "train", "subject_train.txt"),header = FALSE)
subject_test  <- read.table(file.path(path_data, "test" , "subject_test.txt"),header = FALSE)

###########
#2.2 Assigning column names
colnames(x_train) <- features[,2]  
colnames(y_train) <-"activityId" 
colnames(subject_train) <- "subjectId" 
 
colnames(x_test) <- features[,2]  
colnames(y_test) <- "activityId" 
colnames(subject_test) <- "subjectId" 

colnames(activityLabels) <- c('activityId','activityType')

###########
#2.3 Merging all data in one set
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAll <- rbind(mrg_train, mrg_test)

###########
#2.4 Subset only measurements for the mean and standard deviation.
colNames <- colnames(setAll)

#Create vector for defining ID, mean and standard deviation
mean_and_std <- (grepl("activityId" , colNames) | 
                 grepl("subjectId" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
                 )
#Subset only measurements for the mean and standard deviation.
setMean_Std <- setAll[ , mean_and_std == TRUE]

setWithActivityNames <- merge(setMean_Std, activityLabels,
                              by='activityId',
                              all.x=TRUE)
###########
# 2.5 Appropriately labeling the data set with descriptive variable names
names(setWithActivityNames)<-gsub("^t", "time", names(setWithActivityNames))
names(setWithActivityNames)<-gsub("^f", "frequency", names(setWithActivityNames))
names(setWithActivityNames)<-gsub("Acc", "Accelerometer", names(setWithActivityNames))
names(setWithActivityNames)<-gsub("Gyro", "Gyroscope", names(setWithActivityNames))
names(setWithActivityNames)<-gsub("Mag", "Magnitude", names(setWithActivityNames))
names(setWithActivityNames)<-gsub("BodyBody", "Body", names(setWithActivityNames))

#####################################
#3.  Creating a second, independent tidy data set with the average of 
#    each variable for each activity and each subject
###########
#3.1 Making second tidy data set
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
###########
#3.2 Save result in the file `tidy.txt`.
write.table(secTidySet, "tidy.txt", row.name=FALSE)
