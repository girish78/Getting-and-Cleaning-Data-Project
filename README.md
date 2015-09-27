# Getting-and-Cleaning-Data-Project
Getting and Cleaning Data Course Project 
The Project is completed in multiple phases as given below
 Step 1 -  Download & Unzip data file
           Download the file from the given url and unzip the data
 Step 2 -  Read Data Set in Tables
           Read Training Subject data in variable trainsubject
           Read Training Activity data in variable trainactivity
           Read Training data set in variable trainset
           Read Test Subject data in variable trainsubject
           Read Test Activity data in variable trainactivity
           Read Test data set in variable testset
           Read features in variable features
 Step 3    Merge Train Data Sets
           Merge Data in Test & Training data Sets
           Find the indexes in vector features having string as mean add 2 to offset for subject & activity column
           Find the indexes in vector features having string as std add 2 to offset for subject & activity column
           Combine the two index vectors meancol & std col
            mean_std_data extracts only the measurements on the mean and standard deviation
  Step 4  Uses descriptive activity names to name the activities in the data set mergedata
           Use gsub function to name the activities in the data set mergedata
  Step 5  Appropriately labels the data set with descriptive variable names
          varnames is a charcter vector havinf descriptive variables for mergedata
          varnames is created by concatenating the Subject & Activity names with the features V2 column
          setname function(library (data.table)) sets the descriptive names for mergedata columns
  Step 6  Create independent tidy data set with  each subject
          Melt Data by Subject & Activity
          dcast data by Subject & Activity as var and take mean of all the other variables
