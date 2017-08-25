#Downnload and unzip file
if(!file.exists("./Project")){dir.create("./Project")}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="./Project/ProjectData.zip")
zipF<-file.choose("./Project/ProjectData.zip") 
outDir<-"./Project"
unzip(zipF,exdir=outDir)
#lLoad dplyr and data.table libraries
library(dplyr)
library(data.table)
#set new working directory and read features table to get variable names
setwd("./Project/UCI HAR Dataset")
features<-read.table("features.txt",header = FALSE)
#read files in the folder with read.table
activitys_names<-read.table("activity_labels.txt", header = FALSE)
x_train<-read.table("./train/X_train.txt",header = FALSE)
y_train<-read.table("./train/Y_train.txt",header=FALSE)
subject_train<-read.table("./train/subject_train.txt",header=FALSE)
x_test<-read.table("./test/X_test.txt",header = FALSE)
y_test<-read.table("./test/Y_test.txt",header=FALSE)
subject_test<-read.table("./test/subject_test.txt",header=FALSE)
#rename columnns in train set, using make.names to automatically handle dulicate column names
names(x_train)<-make.names(features$V2,unique=TRUE)
#rename columnns in test set, using make.names to automatically handle dulicate column names
names(x_test)<-make.names(features$V2,unique=TRUE)
#rename columns in activitys set in train
names(y_train)<-"activitys"
#rename columns in activitys set in test
names(y_test)<-"activitys"
#rename columns in subject set in train
names(subjects_train)<-"subject"
#rename columns in subject set in test
names(subjects_test)<-"subject"
# add subject and acitivitys sets to train set
traindata=cbind(subjects_train,y_train,x_train)
head(traindata,7)
# add subject and acitivitys sets to test set
testdata=cbind(subjects_test,y_test,x_test)
# Combine train and test sets
mergeddata<-rbind(traindata,testdata)
#Extract columns with mean and standard deviation
meanstd<- mergeddata %>% dplyr:: select(grep("subject|activitys|mean|std", names(mergeddata)))
head(meanstd)
#Create descriptive activity labels using recode function and apply them to the dataframe using mutate
newlabels<-recode(meanstd$activitys,'1'='Walking','2'='Walking_Upstairs','3'='Walking_Downstairs','4'='Sitting','5'='Standing','6'='Laying')
meanstd<-meanstd %>% mutate(activitys= newlabels)
#Apply descriptive variable names
names(meanstd)<-gsub("tBodyAcc\\.","Body acceleration signal in time domain (from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("tBodyAccMag\\.","Body acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("tBodyAccJerk\\.","Body acceleration jerk signal in time domain (from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("tBodyAccJerkMag\\.","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform (from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("tGravityAcc\\.","Gravity acceleration signal in time domain (from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("tGravityAccMag\\.","Gravity acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("tBodyGyro\\.","Body acceleration signal in time domain (from the gyroscope)",names(meanstd))
names(meanstd)<-gsub("tBodyGyroMag\\.","Body acceleration signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(meanstd))
names(meanstd)<-gsub("tBodyGyroJerk\\.","Body acceleration jerk signal in time domain (from the gyroscope)",names(meanstd))
names(meanstd)<-gsub("tBodyGyroJerkMag\\.","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(meanstd))
names(meanstd)<-gsub("fBodyAcc\\.","Body acceleration signal in frequence domain (from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("fBodyAccMag\\.","Body acceleration signal in frequence domain applied to Fast Fourier Transform(from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("fBodyAccJerk\\.","Body acceleration jerk signal in frequence domain (from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("fBodyGyro\\.","Body acceleration signal in frequence domain (from the gyroscope)",names(meanstd))
names(meanstd)<-gsub("fBodyBodyAccJerkMag\\.","Body acceleration jerk signal in frequence domain applied to Fast Fourrier Transform (from the accelerometer)",names(meanstd))
names(meanstd)<-gsub("fBodyBodyGyroMag\\.","Body acceleration signal in frequence domain applied to Fast Fourier Transform (from the gyroscope)",names(meanstd))
names(meanstd)<-gsub("fBodyBodyGyroJerkMag\\.","Body acceleration jerk signal in frequence domain applied to Fast Fourrier Transform(from the gyroscope)",names(meanstd))
names(meanstd)<-gsub("mean()", "MEAN", names(meanstd))
names(meanstd)<-gsub("std()", "SD", names(meanstd))
names(meanstd)
#Create tidy data set with the average of each variable for each activity and each subject
tidydata<-meanstd%>%group_by(subject,activitys)%>%summarize_all(mean)
write.table(tidydata, "TidyData.txt", row.name=FALSE)
tidydata
