Code Book of Getting and Cleaning Data Project
==============================================

Variables
---------

A total of 561 variables as given in features.txt


Data
----

train data: 7352 and test data: 2947 observations


Transformations
---------------

type_train and type_test variables added to indicate which data came from training set and which came from test set.

subject_train, x_train, y_train and type_train variables combined under train   
subject_test, x_test, y_test and type_test variables combined under test   
train and test combined under data   
data melted with ids subject, activity and type   

Workflow
--------
1. The first task was to read the variables into R. This also helped with understanding the data further by comparing and contrasting the lengths of the test and the train data. 
2. Then features data is used to name train and test variables in x_train and x_test data sets. 
3. y_train and y_test appeared to be the activity variable, hence was vactorised using activity_labels data.
4. Two variables were generated type_train and type_test which had the same nrow with x_train and x_test respectively
5. subject_train, subject_test was combined with x_train, x_test, type_train and type_test respectively. 
6. Names of train and test data updated in order to be able to combine them into a single data set.
7. Combined data was melted using id variables of subject, activity and type. variables were features and values came from x_train and x_test as combined.
8. mean and sd were selected from the melted data as instructed in the assignment brief.
9. Finally the requested data was saved as tidydata.txt.

Code
-----

### Read activity labels
activity_labels <- read.table("./dataneedstidying/activity_labels.txt", header = F, sep = " ")
names(activity_labels) <- c("activity_id", "activity_name")

### Read test variables
subject_test <- read.table("./dataneedstidying/subject_test.txt", header = F)
x_test <- read.table("./dataneedstidying/X_test.txt", header = F)
y_test <- read.table("./dataneedstidying/Y_test.txt", header = F)

### Read train variables
subject_train <- read.table("./dataneedstidying/subject_train.txt", header = F)
x_train <- read.table("./dataneedstidying/X_train.txt", header = F)
y_train <- read.table("./dataneedstidying/Y_train.txt", header = F)

### Read features
features <- read.table("./dataneedstidying/features.txt", header = F)


Assignment requirement point  1. Merges the training and the test sets to create one data set.
 There are train data: 7352 and test data: 2947    
 subject_train is going to be the id for train sets   
 subject_test is going to be the id for test sets   

### features has the names of the variables. Name train and test variables:
Assignment requirement point 4. Appropriately labels the data set with descriptive activity names.   
names(x_train) <- features[,2]   
names(x_test) <- features[,2]   

### y_train and y_test show the activity undertaken during the measurements
Assignment requirement point  3. Uses descriptive activity names to name the activities in the data set   
activity_train <- factor(y_train[,1], labels = activity_labels[,2])   
activity_test <- factor(y_test[,1], labels = activity_labels[,2])   

### Indicate type of data
type_train <- rep("Train", times = dim(y_train)[1])   
type_test <- rep("Test", times = dim(y_test)[1])   

### Combine subject, measurement and activity
train <- cbind(subject_train, x_train, activity_train, type_train)   
test <- cbind(subject_test, x_test, activity_test, type_test)   

### Give the same name to the first and last variables in train and test data before binding them.
Assignment requirement point 4. Appropriately labels the data set with descriptive activity names.   
names(train)[1] <- "Subject"   
names(train)[563] <- "Activity"    
names(train)[564] <- "Type"   
names(test)[1] <- "Subject"   
names(test)[563] <- "Activity"   
names(test)[564] <- "Type"   

### Combine train and test data
data<-rbind(train, test)   
datamelted <- melt(data, id = c("Subject","Activity", "Type"))   
head(datamelted)   

Assignment requirement point 2. Extracts only the measurements on the mean and standard deviation for each measurement.   
datameansd <- datamelted[grepl("mean", datamelted$variable) | grepl("std", datamelted$variable) ,]   


Assignment requirement point 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.   
write.table(datameansd, "./tidydata.txt", sep="\t")
