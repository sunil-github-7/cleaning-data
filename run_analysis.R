
# libraries

library(dplyr)
library(reshape2)
# Download data to local and then Unzip


zip = "UCIdata.zip"
link = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir = "UCI HAR Dataset"

# File download verification. If file does not exist, download to working directory.
if(!file.exists(zip))
{
  download.file(link, zip , mode = "wb") 
}

# File unzip verification. If the directory does not exist, unzip the downloaded file.
if(!file.exists(dir))
{
  unzip("UCIdata.zip", files = NULL, exdir=".")
}


## Read Data
test = read.table("UCI HAR Dataset/test/subject_test.txt")

x_test = read.table("UCI HAR Dataset/test/X_test.txt")

y_test = read.table("UCI HAR Dataset/test/y_test.txt")


train = read.table("UCI HAR Dataset/train/subject_train.txt")
x_train = read.table("UCI HAR Dataset/train/x_train.txt")
y_train = read.table("UCI HAR Dataset/train/y_train.txt")

label = read.table("UCI HAR Dataset/activity_labels.txt")
features = read.table("UCI HAR Dataset/features.txt")  

###


label = read.table("UCI HAR Dataset/activity_labels.txt")
colnames(label)=c("code","activity")
features = read.table("UCI HAR Dataset/features.txt")  
colnames(features)=c("n","functions")


test = read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(test)="subject"
x_test = read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test)=features$functions
y_test = read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test)="code"

train = read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(train)="subject"
x_train = read.table("UCI HAR Dataset/train/x_train.txt")
colnames(x_train)=features$functions
y_train = read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train)="code"

# 1 - Merges the training and the test sets to create one data set.

x = rbind(x_train, x_test)
y = rbind(y_train, y_test)
sub = rbind(train, test)

mer_dat = cbind(sub, y,x)


# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

mer_dat_mean_std = mer_dat[,which(colnames(mer_dat) %in% c("subject", "code", grep("mean\\(\\)|std\\(\\)", colnames(mer_dat), value=TRUE)))]

colnames(mer_dat_mean_std)
# 3 - Uses descriptive activity names to name the activities in the data set

label_1=as.character(label[,2])
mer_dat_mean_std$code=label_1[mer_dat_mean_std$code]


# 4 -Appropriately labels the data set with descriptive variable names.

names(mer_dat_mean_std)[2] = "Activity"
colnames(mer_dat_mean_std)
names(mer_dat_mean_std)=gsub("Acc", "Accelerometer", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("Gyro", "Gyroscope", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("BodyBody", "Body", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("Mag", "Magnitude", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("^t", "Time", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("^f", "Frequency", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("tBody", "TimeBody", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("-mean()", "Mean", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("-std()", "STD", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("-freq()", "Frequency", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("angle", "Angle", names(mer_dat_mean_std), ignore.case = TRUE)
names(mer_dat_mean_std)=gsub("gravity", "Gravity", names(mer_dat_mean_std), ignore.case = TRUE)


#5-  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Handson = mer_dat_mean_std %>% group_by(subject, activity) %>%  summarise_all(list(mean))

View(Handson)

write.table(Handson, "Handson.txt", row.name=FALSE)

