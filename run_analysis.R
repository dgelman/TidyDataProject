# Install requisite packages for analysis
install.packages("plyr")
library("plyr")
install.packages("dplyr")
library("dplyr")
install.packages("tidyr")
library("tidyr")

# Create file "project" in working directory to hold project if there is no project file
if (!file.exists("project")){
    dir.create("project")
}

# Change the working directory to the project file
setwd("./project")

# Download UCI HAR Dataset and unzip file to project directory
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip (temp)

# Reading in files
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",strip.white = T)
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt",strip.white = T)
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.csv("UCI HAR Dataset//features.txt", header=FALSE, sep=" ")
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]

# Load in test and training activities, convert numbers to named activities
# (1=walking,2=walking_upstairs,3=walking_downstairs,4=sitting,5=standing,6=laying)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
from <- c(1,2,3,4,5,6)
to <- c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
map = setNames(to,from)
y_test[,1] = map[y_test[,1]]
y_train[,1]= map[y_train[1,]]

# Bind subject_id and subject_type columns to test data files
x_test <- cbind(x_test,test_subject)
colnames(x_test)[562] <- "subject_id"
x_train <- cbind(x_train,train_subject)
colnames(x_train)[562] <- "subject_id"

# Add "subject_type" column to dataframes to denote type of subject (test or train)
newcol <- rep("test",nrow(x_test))
x_test <- cbind(x_test,newcol)
colnames(x_test)[563] <- "subject_type"

newcol = rep("train",nrow(x_train))
x_train <- cbind(x_train,newcol)
colnames(x_train)[563] <- "subject_type"

# Add column "activity_type" to dataframes to denote type of activity (laying, sitting, etc)
x_test <- cbind(x_test,y_test)
colnames(x_test)[564] <- "activity_type"

x_train <- cbind(x_train,y_train)
colnames(x_train)[564] <- "activity_type"

# Merge test and training data
x_merged <- rbind(x_test,x_train)

# Select out all rows with new columns created above, then those with mean and standard deviation
# of measurement values
x_merged <- x_merged[,c(562:564,1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,
            253,254,266:271,294:296,345,346:350,373:375,424:429,452:454,503,504,
            513,516,517,526,529,530,539,542,543,552,555:561)]

# Tidy data by ordering merged data by subject_id and activity_type, then create long/tall tidy
# dataset by moving all measurements into two rows of data: a test_type row which will take the
# name of the type of measurement being performed (like tBodyAcc-Mean-x, etc) and a second column
# with the value of these measurements (named measurement)
x_merged <- arrange(x_merged, subject_id,activity_type)
x_tidy <- gather(x_merged, test_type, measurement, -subject_id, -subject_type, -activity_type)

# Makes sure the columns that are factors are designated as such
x_tidy$subject_id <- as.factor(x_tidy$subject_id)
x_tidy$subject_type <- as.factor(x_tidy$subject_type)
x_tidy$activity_type<- as.factor(x_tidy$activity_type)
x_tidy$test_type <- as.factor(x_tidy$test_type)

## X_tidy at this point has the following properties, obtained by str(x_tidy):
## 'data.frame':    885714 obs. of  5 variables:
##    $ subject_id   : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
##$ subject_type : Factor w/ 2 levels "test","train": 2 2 2 2 2 2 2 2 2 2 ...
##$ activity_type: Factor w/ 6 levels "laying","sitting",..: 3 3 3 3 3 3 3 3 3 3 ...
##$ test_type    : Factor w/ 86 levels "tBodyAcc-mean()-X",..: 1 1 1 1 1 1 1 1 1 1 ...
##$ measurement  : num  0.289 0.278 0.28 0.279 0.277 ...

# Create a second, independent tidy dataset with the average of each variable by activity and subject
# with the name tidy_finalmeans
tidy_finalmeans <- ddply(x_tidy, .(subject_id,subject_type,activity_type,test_type),
                         summarize, meanOfMeasurements = mean(measurement))
# Write tidy dataset to file without row names
write.table(tidy_finalmeans, file = "tidydata.txt", sep = ",", row.name=F)