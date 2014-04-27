library(psych)
library(plyr)
library(reshape2)

setwd ("C:\\Users\\IDMS-TB\\cleaning_data")
# Reading ASCII file - x training file

# 1) WORKING on TRAINING DATA FILES
# a) Upload both training data and training data labels in R
# b) Make sure that the data files are uploaded by using dim() commands
# c) Combine training data and training labels using add column command

# a)
# oepn taining and training labels text files in R 
trainDatax <- read.table("X_train.txt", sep="",header=F)
trainDatay <- read.table("y_train.txt", sep="",header=F)

#rename(trainDatay,("V1"="activity"))

names(trainDatay)[names(trainDatay)=="V1"] <- "activity"

# b)
dim(trainDatax)
dim(trainDatay)
str(trainDatay)

table(trainDatay$activity)

# c)
# adding training labels into training data as columns
trainData <- cbind(trainDatay, trainDatax)

# check the taining labels data is added to training data
dim(trainData) # the number of column in the traiing data has been increased by one 

# check variables/ columns types 
str(trainData)


# WORKING on TEST DATA FILES
# a) Upload both test data and test data labels in R
# b) Make sure that the data files are uploaded by using dim() commands
# c) Combine training data and training labels using add column command

# a)
# Upload test and test labels text files in R 
testDatax <- read.table("X_test.txt", sep="",header=F)
testDatay <- read.table("y_test.txt", sep="",header=F)

names(testDatay)[names(testDatay)=="V1"] <- "activity"

# b)
dim(testDatax)
dim(testDatay)
str(testDatay)

table(testDatay$activity)

# c)
# adding test labels into test data as columns
testData <- cbind(testDatay, testDatax)

# check the test labels data is added to test data
dim(testData) # the number of column in the traiing data has been increased by one 

# check variables/ columns types 
str(testData)

edit(testData)

#########################################
## 2) Merges the training and the test sets to create one data set
# two merge the two data file, use rbind() command
fullData <- rbind(trainData,testData)

# check the two data sets are  compiled properly: 7352+2947 = 10299
# make sure that the number of colums/ variables should not change 
dim(fullData)
save(fullData, file = "fullData.RData")
#########################################

## 3) Extracts only the measurements on the mean and standard deviation for each measurment.
meanSdData <- fullData[,1:2]

varNum <- c(2:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,
            253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,
            513,516,517,526,529,530,539,542,543,552,555,556,557,558,559,560,561)

for(i in varNum){
  x <- paste("V",(i), sep="")
  meanSdData <- cbind(meanSdData, fullData[,x])
  names(meanSdData)[names(meanSdData)=="fullData[, x]"] <- x
}

dim(meanSdData)
edit(meanSdData)


## 4) Appropriately labels the data set with descriptive activity names
meanSdData$activity <- factor(meanSdData$activity, levels =c(1,2,3,4,5,6), labels =c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING","LAYING"))

save(meanSdData, file = "meanSdData.RData")

# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject
# creating secondary daa
activityData <- melt(meanSdData,id="activity")
finalData <- dcast(activityData,activity ~ variable, mean, na.rm=T)

#########################################
## 6) Uses descriptive activity names to name the activities in the data set

VarNewName <- c("tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y",
                "tBodyAcc-std()-Z","tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X",
                "tGravityAcc-std()-Y","tGravityAcc-std()-Z","tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z",
                "tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z","tBodyGyro-mean()-X","tBodyGyro-mean()-Y",
                "tBodyGyro-mean()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z","tBodyGyroJerk-mean()-X",
                "tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z","tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z",
                "tBodyAccMag-mean()","tBodyAccMag-std()","tGravityAccMag-mean()","tGravityAccMag-std()","tBodyAccJerkMag-mean()",
                "tBodyAccJerkMag-std()","tBodyGyroMag-mean()","tBodyGyroMag-std()","tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()",
                "fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z","fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z",
                "fBodyAcc-meanFreq()-X","fBodyAcc-meanFreq()-Y","fBodyAcc-meanFreq()-Z","fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y",
                "fBodyAccJerk-mean()-Z","fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z","fBodyAccJerk-meanFreq()-X",
                "fBodyAccJerk-meanFreq()-Y","fBodyAccJerk-meanFreq()-Z","fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z",
                "fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z","fBodyGyro-meanFreq()-X","fBodyGyro-meanFreq()-Y",
                "fBodyGyro-meanFreq()-Z","fBodyAccMag-mean()","fBodyAccMag-std()","fBodyAccMag-meanFreq()","fBodyBodyAccJerkMag-mean()",
                "fBodyBodyAccJerkMag-std()","fBodyBodyAccJerkMag-meanFreq()","fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()",
                "fBodyBodyGyroMag-meanFreq()","fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()","fBodyBodyGyroJerkMag-meanFreq()",
                "angle(tBodyAccMean,gravity)","angle(tBodyAccJerkMean),gravityMean)","angle(tBodyGyroMean,gravityMean)",
                "angle(tBodyGyroJerkMean,gravityMean)","angle(X,gravityMean)","angle(Y,gravityMean)","angle(Z,gravityMean)")

varOldName <- c("V1","V2","V3","V4","V5","V6","V41","V42","V43","V44","V45","V46","V81","V82","V83",
                "V84","V85","V86","V121","V122","V123","V124","V125","V126","V161","V162","V163","V164",
                "V165","V166","V201","V202","V214","V215","V227","V228","V240","V241","V253","V254",
                "V266","V267","V268","V269","V270","V271","V294","V295","V296","V345","V346","V347",
                "V348","V349","V350","V373","V374","V375","V424","V425","V426","V427","V428","V429","V452",
                "V453","V454","V503","V504","V513","V516","V517","V526","V529","V530","V539","V542","V543",
                "V552","V555","V556","V557","V558","V559","V560","V561")

# changeing variable names
for (i in 1:length(varOldName))
{
  pos <- grep(varOldName[i], names(finalData))
  if (length(pos) != 0) names(finalData)[pos] <- VarNewName[i]
}
dim(finalData)
edit(finalData)
save(finalData, file = "finalData.RData")
