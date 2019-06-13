
#Install Packages 
install.packages("reshape2")
install.packages("BH")
install.packages("plogr")
install.packages("dplyr")


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
