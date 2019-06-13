
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

