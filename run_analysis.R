##### Download & Unzip data file #############################################
##### R Script for Course Project in & Cleaning Data Course###################
##### Merges the training and the test sets to create one data set.###########
##### Extracts only the measurements on the mean and standard deviation#######
##### Uses descriptive activity names to name the activities in the data set##
##### Appropriately labels the data set with descriptive variable names#######
##### Create independent tidy data set with  each subject#####################


##### Download & Unzip data file #################################################################  

flUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(flUrl, dest="./data/dataset.zip") 
unzip("./data/dataset.zip", exdir = "./data")

##################################################################################################

############### Read Data Set in Tables###########################################################

### Read Training Subject data in variable trainsubject###########################################
trainsubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

### Read Training Activity data in variable trainactivity#########################################
trainactivity <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header = FALSE)

### Read Training data set in variable trainset####################################################
trainset <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)

### Read Test Subject data in variable trainsubject#############################################
testsubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

### Read Test Activity data in variable trainactivity############################################
testactivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header = FALSE)

### Read Test data set in variable testset#######################################################
testset <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)

### Read features in variable features###########################################################
features <- read.table("./data/UCI HAR Dataset/features.txt",header = FALSE)

##################################################################################################

######################## Merge Data Sets##########################################################

######################### Merge Train Data Sets##################################################
trainmerge <- cbind(trainsubject, trainactivity, trainset)

######################### Merge Test Data Sets####################################################
testmerge <- cbind(testsubject, testactivity, testset)

######################### Merge Data in Test & Training data Sets#################################
mergedata <- rbind (trainmerge, testmerge)
                    
##Find the indexes in vector features having string as mean add 2 to offset for subject & activity column##
meancol <- (grep("mean", as.character(features$V2)) + 2)
meancol1 <- (grep("mean", as.character(features$V2)) )
##Find the indexes in vector features having string as std add 2 to offset for subject & activity column##
stdcol <- (grep("std", as.character(features$V2)) + 2)
stdcol1 <- (grep("std", as.character(features$V2)) )
##############Combine the two index vectors meancol & std col ######################################
mean_std_col <- c(1,2,meancol, stdcol)

names(mergedata)[1] <- "X1"
names(mergedata)[2] <- "X2"

##### mean_std_data extracts only the measurements on the mean and standard deviation################
mean_std_data <- select(mergedata,mean_std_col)

#####################################################################################################

##### Uses descriptive activity names to name the activities in the data set mergedata###############

mean_std_data$X2 <- gsub(1,"WALKING",mean_std_data$X2)
mean_std_data$X2 <- gsub(2,"WALKING_UPSTAIRS",mean_std_data$X2)
mean_std_data$X2 <- gsub(3,"WALKING_DOWNSTAIRS",mean_std_data$X2)
mean_std_data$X2 <- gsub(4,"SITTING",mean_std_data$X2)
mean_std_data$X2 <- gsub(5,"STANDING",mean_std_data$X2)
mean_std_data$X2 <- gsub(6,"LAYING",mean_std_data$X2)

######################################################################################################

##### Appropriately labels the data set with descriptive variable names###############################

##### varnames is a charcter vector havinf descriptive variables for mergedata #######################
##### varnames is created by concatenating the Subject & Activity names with the features V2 column###

varnames <- c("Subject","Activity",as.character(features$V2[meancol1]),as.character(features$V2[stdcol1]))

######## setname function(library (data.table)) sets the descriptive names for mergedata columns######

setnames(mean_std_data,names(mean_std_data),varnames)

######################################################################################################

##### Create independent tidy data set with  each subject#############################################
######Melt Data by Subject & Activity ################################################################
########dcast data by Subject & Activity as var and take mean of all the other variables#############
fmeancol1 <- as.character(features$V2[meancol1])
fstdcol1  <- as.character(features$V2[stdcol1])
datamelt <- melt(mean_std_data,id=c("Subject","Activity"),measure.vars = c(fmeancol1,fstdcol1))
tidydata <- dcast(datamelt, Subject + Activity ~ variable,mean)
write.table(tidydata, "./data/tidydata.txt", sep="\t", row.names=FALSE)
######################################################################################################