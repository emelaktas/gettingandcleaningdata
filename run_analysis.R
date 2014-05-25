# This file does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Set working directory
setwd("/Users/emelaktas/gettingandcleaningdata")

# Read activity labels
activity_labels <- read.table("./dataneedstidying/activity_labels.txt", header = F, sep = " ")
names(activity_labels) <- c("activity_id", "activity_name")

# Read accelerator test variables
body_acc_x_test <- read.table("./dataneedstidying/body_acc_x_test.txt", header = F)
body_acc_y_test <- read.table("./dataneedstidying/body_acc_y_test.txt", header = F)
body_acc_z_test <- read.table("./dataneedstidying/body_acc_z_test.txt", header = F)
total_acc_x_test <- read.table("./dataneedstidying/total_acc_x_test.txt", header = F)
total_acc_y_test <- read.table("./dataneedstidying/total_acc_y_test.txt", header = F)
total_acc_z_test <- read.table("./dataneedstidying/total_acc_z_test.txt", header = F)
subject_test <- read.table("./dataneedstidying/subject_test.txt", header = F)
x_test <- read.table("./dataneedstidying/X_test.txt", header = F)
y_test <- read.table("./dataneedstidying/Y_test.txt", header = F)

# Read gyro test variables
body_gyro_x_test <- read.table("./dataneedstidying/body_gyro_x_test.txt", header = F)
body_gyro_y_test <- read.table("./dataneedstidying/body_gyro_y_test.txt", header = F)
body_gyro_z_test <- read.table("./dataneedstidying/body_gyro_z_test.txt", header = F)

# Read accelerator train variables
body_acc_x_train <- read.table("./dataneedstidying/body_acc_x_train.txt", header = F)
body_acc_y_train <- read.table("./dataneedstidying/body_acc_y_train.txt", header = F)
body_acc_z_train <- read.table("./dataneedstidying/body_acc_z_train.txt", header = F)
total_acc_x_train <- read.table("./dataneedstidying/total_acc_x_train.txt", header = F)
total_acc_y_train <- read.table("./dataneedstidying/total_acc_y_train.txt", header = F)
total_acc_z_train <- read.table("./dataneedstidying/total_acc_z_train.txt", header = F)
subject_train <- read.table("./dataneedstidying/subject_train.txt", header = F)
x_train <- read.table("./dataneedstidying/X_train.txt", header = F)
y_train <- read.table("./dataneedstidying/Y_train.txt", header = F)

# Read gyro train variables
body_gyro_x_train <- read.table("./dataneedstidying/body_gyro_x_train.txt", header = F)
body_gyro_y_train <- read.table("./dataneedstidying/body_gyro_y_train.txt", header = F)
body_gyro_z_train <- read.table("./dataneedstidying/body_gyro_z_train.txt", header = F)

# Read features
features <- read.table("./dataneedstidying/features.txt", header = F)


# 1. Merges the training and the test sets to create one data set.
# There are train data: 7352 and test data: 2947 
# subject_train is going to be the id for train sets
# subject_test is going to be the id for test sets

# features has the names of the variables. Name train and test variables:
names(x_train) <- features[,2]
names(x_test) <- features[,2]

# y_train and y_test show the activity undertaken during the measurements
activity_train <- factor(y_train[,1], labels = activity_labels[,2])
activity_test <- factor(y_test[,1], labels = activity_labels[,2])

# Indicate type of data
type_train <- rep("Train", times = dim(y_train)[1])
type_test <- rep("Test", times = dim(y_test)[1])

# Combine subject, measurement and activity
train <- cbind(subject_train, x_train, activity_train, type_train)
test <- cbind(subject_test, x_test, activity_test, type_test)

# Give the same name to the first and last variables in train and test data before binding them.
names(train)[1] <- "Subject"
names(train)[563] <- "Activity"
names(train)[564] <- "Type"
names(test)[1] <- "Subject"
names(test)[563] <- "Activity"
names(test)[564] <- "Type"

# Combine train and test data
data<-rbind(train, test)
datamelted <- melt(data, id = c("Subject","Activity", "Type"))
head(datamelted)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
datameansd <- datamelted[grepl("mean", datamelted$variable) | grepl("std", datamelted$variable) ,]

# 3. Uses descriptive activity names to name the activities in the data set
print("This has been done above already.")
print("y_train and y_test show the activity undertaken during the measurements")
print("code run: activity_train <- factor(y_train[,1], labels = activity_labels[,2])")
print("code run: activity_test <- factor(y_test[,1], labels = activity_labels[,2])") 

# 4. Appropriately labels the data set with descriptive activity names.
print("This has been done above already.")
print("# features has the names of the variables. Name train and test variables:")
print("code run: names(x_train) <- features[,2]")
print("code run: names(x_test) <- features[,2]") 

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(datameansd, "./tidydata.txt", sep="\t")
