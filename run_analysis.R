# This is the R script created for Getting and Cleaning Data Course Project
# Its goal is to create an aggregated tidy data set based on the
# Human Activity Recognition Using Smartphones Data Set 

# The script assumes that the input data set is located in the
# "UCI HAR Dataset" folder
# In case the input data set is missing the script downloads and extracts it.

dataDirectory <- "UCI HAR Dataset"
dataFile <- "UCI_HAR_Dataset.zip"
tidyFile <- "tidy.txt"

if (!file.exists(dataDirectory)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url=fileUrl, destfile=dataFile, method="curl")
    dateDownloaded <- date()
    unzip(dataFile)
}

# Step 1.
# Merge the training and the test sets to create one data set.
#
# The input files are read into different data frames at this stage
# and each train and test data frames are merged using rbind

x.train <- read.table(paste0(dataDirectory, "/train/X_train.txt"))
subject.train <- read.table(paste0(dataDirectory, "/train/subject_train.txt"))
y.train <- read.table(paste0(dataDirectory, "/train/y_train.txt"))

x.test <- read.table(paste0(dataDirectory, "/test/X_test.txt"))
subject.test <- read.table(paste0(dataDirectory, "/test/subject_test.txt"))
y.test <- read.table(paste0(dataDirectory, "/test/y_test.txt"))

x.merged <- rbind(x.train, x.test)
subject.merged <- rbind(subject.train, subject.test)
y.merged <- rbind(y.train, y.test)

# Step 2.
# Extract only the measurements on the mean and standard deviation
# for each measurement.
#
# The variables of the feature vector are read from features.txt.
# All features matching "mean" or "std" are assumed to be relevant and extracted

features <- read.table(file=paste0(dataDirectory, "/features.txt"), sep=" ")
feature.names <- as.character(features[,2])

toextract <- grepl("mean|std", feature.names, ignore.case=TRUE)
x.extracted <- x.merged[toextract]

# Step 3.
# Use descriptive activity names to name the activities in the data set.
#
# The activity names are read from activity_labels.txt.
# They are converted to descriptive names and used for factor relabelling.

activities <- read.table(file=paste0(dataDirectory, "/activity_labels.txt"))
names(activities) <- c("id", "description")
names(y.merged) <- "id"

activities$description <- sub("_", " ", activities$description)
activities$description <- tolower(activities$description)

y.descriptive = data.frame(description=as.factor(y.merged$id))
levels(y.descriptive$description) <- activities$description

# Step 4.
# Appropriately label the data set with descriptive variable names. 
#
# Pattern matching & replacement is used to make feature names more descriptive.
# The columns of the different data frames are finally merged using cbind.

feature.names <- gsub("\\.|\\(|\\)", "", feature.names)
feature.names <- sub("BodyBody", "Body", feature.names)  # correcting input bug
feature.names <- sub("^t", "Time.", feature.names) 
feature.names <- sub("^f", "Freq.", feature.names)
feature.names <- sub("^anglet", "Angle.Time.", feature.names)
feature.names <- sub("^angle", "Angle.", feature.names)
feature.names <- sub("mean", "Mean", feature.names)
feature.names <- sub("std", "StdDev", feature.names)
feature.names <- sub("gravity", "Gravity", feature.names)
feature.names <- make.names(feature.names, unique=TRUE)

names(x.extracted) <- feature.names[toextract]
names(subject.merged) <- "Subject"
names(y.descriptive) <- "Activity"

humanactivity <- cbind(x.extracted, subject.merged, y.descriptive)

# Step 5.
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
#
# The aggregate function is used to split the data into subsets,
# compute mean for each. The result is exported using write.table as txt file.

tidy <- aggregate(data = humanactivity, .~Activity + Subject, mean)
write.table(tidy, file=tidyFile)

# Optionally we can run a few check calculations based on the following thread
# https://class.coursera.org/getdata-005/forum/thread?thread_id=270

#print(tidy[tidy$Activity=="laying" & tidy$Subject==1, 3])
#print(tidy[tidy$Activity=="sitting" & tidy$Subject==10, 3])

#print(table(tidy$Subject, tidy$Activity))

# Optionally generate the raw CodeBook

#codebook <- data.frame(variable = names(tidy),
#                       data.frame(description = as.character(names(tidy)),
#                                  stringsAsFactors=FALSE))
#codebook[1, 2] <- "Activity description: Factor w/ 6 levels \"walking\",\"walking upstairs\", \"walking downstairs\", \"sitting\", \"stanting\", \"laying\""
#codebook[2, 2] <- "An identifier of the subject who carried out the experiments"
#for (i in 3:88) { codebook[i, 2] <- paste("Aggregated mean value of variable", codebook[i, 2])}

#write.table(codebook, file="CodeBook.md", row.names=FALSE)
