
## Step0. Download data and unzip it in Data folder
unzipPath <- "./data"
filePath <- "./data/UCI HAR Dataset/"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("data/UCI HAR Dataset/")) {
    dir.create("data/UCI HAR Dataset/")
}
if (!file.exists(filePath)) {
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, exdir = unzipPath)
    unlink(temp)
}


## Step1. Merges the training and the test sets to create one data set.
trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./data/UCI HAR Dataset/test/y_test.txt") 
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)


## Step2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/UCI HAR Dataset/features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, meanStdIndices]
## remove "()"
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) 
## capitalize M
names(joinData) <- gsub("mean", "Mean", names(joinData))
## capitalize S
names(joinData) <- gsub("std", "Std", names(joinData)) 
## remove "-" in column names 
names(joinData) <- gsub("-", "", names(joinData)) 


## Step3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"


## Step4. Appropriately labels the data set with descriptive activity names. 
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
## write out the 1st dataset
head(cleanedData)
write.table(cleanedData, "./data/merged_data.txt")


## Step5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
head(result)
## write out the 2nd dataset
write.table(result, "./data/data_with_means.txt")
