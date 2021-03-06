# The following R script will take a data set downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# on 10 June 2014 at 12:35 and extracted to "./UCI HAR Dataset". The folder structure of the archive was retained. 

# The archive contains two basic sets of data:
#   a. A training set located in a folder called train
#   b. A test set located in a folder called test

# The archive also contains a number of support files that give additional information.

# Even though the data within the two files is different the columnar 
# information is consistent across the two data sets. For the purpose of this 
# description, the folder train (located in "./UCI HAR Dataset/train" will be
# used to describe how information links up. Substituting train for test will
# reference the other data set provided.

# The file "./UCI HAR Dataset/train/subject_train.txt" contains a numeric
#     reference ranging from 1:30 representing the participants. There is one entry
#     for each recorded observation. 

# The file "./UCI HAR Dataset/train/y_train.txt" contains a numeric 
#    reference ranging from 1:6 representing the type of activity
#    the participant was undertaking when the measurement was taken. The file 
#    "./UCI HAR Dataset/activity_labels.txt" contains a cross reference between the number and a description of the activity

# The file "./UCI HAR Dataset/train/X_train.txt" contains the various 
#     measurements that each subject generated. The file "./UCI HAR
#     Dataset/features.txt" contains a that describes the 561 columns of this data 
#     set

# The relation between "./UCI HAR Dataset/train/subject_train.txt", "./UCI HAR Dataset/train/y_train.txt" and
#     "./UCI HAR Dataset/train/X_train.txt" is linear meaning that the first row of each record represents the first compound
#     record, the second row represents the second, the nth being the nth row of the data set.


# The requested data will be stored in the folder "./data". This ensures that if
#     the program is run multiple times pre-processing activities are not performed
#     repeatedly.

# The user is given the option to clear any saved data at the beginning fo the
# program. If the user opts to clear the saved data, the required data is
# generated from the source files.

# While generating the data files, the user is periodically prompted that
# activity is taking place. This ensures that on slow computers, the user knows
# that the program has not hung.

##########################################################################
###    Functions
##########################################################################


# Returns a list of the activity number and description formatted as Proper case
activityList <- function() {
    con <- file("./UCI HAR Dataset/activity_labels.txt", open="rt")    
    data <- readLines(con)
    close(con)
    
    # split the list on the space
    data <- strsplit(data," ")
    
    # Capitalize only the first character of the description
    data <- sapply(data, function(x) list (x[1], paste(substring(x[2], 1,1), tolower(substring(x[2], 2)), sep="", collapse=" ")))
}

# Returns a vector of the column names for the features data.
# After the data file is read it is split into column number and column text.
# A string vector is created and every other column text is stored into the string vector
# that will be returned to the calling module.
featureList <- function() {
    con <- file("./UCI HAR Dataset/features.txt", open="rt")    
    data <- readLines(con)
    close(con)
    
    # Create a blank vector - improves overall code performance by pre allocating the number of rows
    c <- vector(mode = "character", length = length(data))
    
    # tidy data: replace all dashes with dots
    data <- gsub("-", ".", data)
    
    # split the list on the space
    data <- strsplit(data," ")
    
    f <- unlist(data)
    for (i in seq(2,length(f),2)) {
        c[i %/% 2] <- f[i]
    }
    
    return (c)
}

# Reads the subject information, adds appropriate column titles and return the data frame to the
# calling module
readSubject <- function(folder) {
    # build the file path to the subject information
    filePath <- paste0("./UCI HAR Dataset/", folder, "/subject_", folder, ".txt")
    data <- read.table(filePath)
    
    # name the column
    names(data)<-c("student.no")
    
    return(data)
}

# reads the activity information, appends a column with the activity description and adds appropriate column heading. The result is returned to the calling module
readActivity <- function(folder, activityRef) {   
    filePath <- paste0("./UCI HAR Dataset/", folder, "/y_", folder, ".txt")
    ydata <- read.table(filePath)
    names(ydata)<-c("activity.ref")
    
    # Add a new column with the description
    ydata[,"activity.desc"] <- apply(ydata, 2, function(x) activityRef[2, x])
    
    return(ydata)
}

# Reads the features information. Extracts only the data that has -mean() and
# -std() in the column name
readFeatures <- function(folder, featureCols) {
    filePath <- paste0("./UCI HAR Dataset/", folder, "/X_", folder, ".txt")
    fdata <- read.table(filePath)
    
    colnames(fdata) <- featureCols
    fdata <- fdata[,grep(".mean\\(\\)|.std\\(\\)", names(fdata))]
    return (fdata)
}

# This module will process the files stored in folder and will build up a data frame of the data built up from the various files.
combine <- function(folder, activityRef, featureCols) {
    sdata <- readSubject(folder)
    ydata <- readActivity(folder, activityRef)
    fdata <- readFeatures(folder, featureCols)
    
    data <- cbind(sdata, ydata, fdata)
    
    return (data)
}

##########################################################################
###    Main Code Body
##########################################################################

# If a previous session has been saved ask user whether he wants to clear it. If
# cleared the processing takes placed again, otherwise the existing data is
# loaded from a file
if (file.exists("./data/tidyData.Rda")) {
    ans <- readline("Clear previous session data? [Y - to clear] ") 
    if (tolower(ans) == "y") {
        file.remove("./data/tidyData.Rda")
    }
    rm (ans)
}

# Since the archive is static code efficiency could be acheived by skipping
# through the processing stage each time the program is executed. If the data
# file is found rather build up the data file from the raw files the saved 
# version is loaded
if (file.exists("./data/tidyData.Rda")) {
    load("./data/tidyData.Rda")
} else {
    ##########  User Feedback
    print ("Building the activity list")
    
    # Read in the list of activities. This is common to both the training and test
    # data and is therefore read only once
    activityRef <- activityList()
    
    ##########  User Feedback
    print ("Building the features list")

    # Read in the list that hols the feature column names. This is common to both the training and test
    # data and is therefore read only once.
    # The function converts the data into a vector of headings.
    featureCols <- featureList()
    
    ##########  User Feedback
    print ("Processing the training data")

    # Process the training data
    trainData <- combine("train", activityRef, featureCols)
    
    ##########  User Feedback
    print ("Processing the test data")

    # Process the test data
    testData <- combine("test", activityRef, featureCols)
    
    ##########  User Feedback
    print ("Combining the training and test data")

    # Combine the two
    data <- rbind(trainData, testData)
    # tidy data: remove the '()' characters from column names
    names(data) <- sub("\\(\\)","",names(data))
    
    ##########  User Feedback
    print ("Grouping data by student no and activity reference")

    # Create a second, independent tidy data set with the average of each variable for each activity and each subject.
    # The data.frame must be converted to a data table in order to arrive at the desired solution. Therefore the library
    # must be loaded and the data frame converted to a data table
    library(data.table)
    dt <- data.table(data)
    
    # The first three columns are descriptive and do not contain numeric data. the remaining columns will be grouped by student.no and activity.ref and subsequently averaged 
    gData <- dt[, lapply(.SD, mean), by=list(student.no, activity.ref), .SDcols=4:ncol(dt)]
    
    # Convert the data table to a data frame
    gData <- as.data.frame(gData)
    
    ##########  User Feedback
    print ("sorting grouped data by student no and activity reference")

    # sort the data on student.no and activity.reference
    groupData <- gData[with(gData, order(student.no, activity.ref)),]
    
    # Recreate the missing activity.desc column
    groupData$activity.desc <- unlist(activityRef[2, groupData$activity.ref])
    
    # and clean up
    rm(gData, dt, activityRef, featureCols, trainData, testData, data)
    

    # Create the folder if necessary
    if (!file.exists("./data")) {
        dir.create("./data")
    }

    # save the various objects to a file. This ensures that processing does not take place again if the code is run multiple times
    save(groupData, file = "./data/tidyData.Rda")    
}

# Save groupData to a tidy data set. This is done everytime irrespective of
# whether the data is generated or automatically read.
write.table(groupData, "./data/tidyData.txt", row.names = FALSE, sep="\t", quote=FALSE)

