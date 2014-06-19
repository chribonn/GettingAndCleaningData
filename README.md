Getting And Cleaning Data Assignment
====================================

Design Decision
---------------

### Saving produced data

Given the static nature of the data (a downloaded zip file) it was decided that once the data tiding process and completed and the required information was generated, the resulting data would be saved in a folder __./data__. This would ensure that subsequent analysis would skip over the processing part and return to the data scients the pre-computed data.

The user would be prompted (if a pre-computed data file is found) whether he would like to use that data or recompute everything from scratch.

Irrespective of whether the user opts to generate the data from raw information or load pre-saved files, the tidy data text file is always generated. This ensures that the required output is always generated.

### Providing feedback

On a slow computer the processing could take some time. During this time the computer would appear to have hung. In order to cater for this situation, at strategic locations within the code, the user is informed of what is to be done next. 

### Modularity

The solution was designed with modularity in mind. Atomic functions that performed a particular (specialised) task make up the solution. The benefits of this approach are:
1. Once can run performance analysis tests on the modules
2. Modules could be replaced with greater ease without breaking the code


### Avoiding hardcoding

As much as possible hardcoded information was avoided. For example the number of sensor readings column names (__./features.txt__) was not bound to a number but was computed based on the data file supplied. Another example are the activites (__./activity_labels.txt__) which is computed dynamically.

The benfit of this approach is that if, in future studies parameters change the code would be able to handle the output.

### Performance considerations

Another design decision was code efficiency. Besides the choice of code to arrive at a solution, tasks that would generate data that needed to be applied to both the training and test data were done only once and passed to the modules rather than repeated.

### Intermediate and temporary variables

When the program terminates all that remains are the tidy data requested by the question. This ensures that the data scientist can focus on the output rather than be overwhelmed with data that was generated when driving towards the requried task.

----

The Code
--------

The modules making up the solution is described here.

Module name | Notes | Called by
----------- | ----- | ---------
_Main()_ | This module performs the data tidying process and leaves a number of objects that represent the cleaned data |
activityList() | Returns a list of the activity number and description formatted as Proper case | Main()
featureList() | Returns a vector of the column names for the features data. It performs replaces all dashes with dots.  | Main()
combine(folder, activityRef, featureCols) | This module will process the files stored in folder and will build up a data frame of the data built up from the various files. This module will combine data from the test and training modules into one data frame. It will also generate the other tidy data requested in the assignment | Main()
readSubject(folder) | Reads the subject information from folder, adding the column title __student.no__ and returns the data frame to the calling module | combine(folder, activityRef, featureCols)
readActivityfolder, activityRef) | Reads the activity information, and titles the column __activity.ref__. It also adds a column titled __activity.desc__ with the computed activity descriptions. The resulting data frame is returned to the calling module | combine(folder, activityRef, featureCols)
readFeatures(folder, featureCols) | Reads the features information found in a particular folder. Returns a subset of the data containing only those columns that contain __-mean()__ and __-std()__ in their name. | combine(folder, activityRef, featureCols)


Analysing Main()
----------------

Main is the fulcrum of the program and the following notes are ment to discuss the salient commands used to arrive at the desired result.

```
data <- rbind(trainData, testData)
```

The rbind function is used to combine the training and test data frames into one.

---

```
    library(data.table)
    dt <- data.table(data)
    
    # The first three columns are descriptive and do not contain numeric data. 
    # The remaining columns will be grouped by student.no and activity.ref and subsequently averaged 
    gData <- dt[, lapply(.SD, mean), by=list(student.no, activity.ref), .SDcols=4:ncol(dt)]
    
    # Convert the data table to a data frame
    gData <- as.data.frame(gData)
    
    # Sort the data on student.no and activity.reference
    groupData <- gData[with(gData, order(student.no, activity.ref)),]
    
    # Recreate the missing activity.desc column
    groupData$activity.desc <- activityRef[2, groupData$activity.ref]
```

The code listed above summarises the data by student number and activity (sorting the data by these columns).

Reading the tidy data
---------------------

As one of the requirements of the assignment was to have a human-readable format, the write.table function was used to write the resulting tidy data.

The command issued to write the data is

```
    write.table(groupData, "./data/tidyData.txt", row.names = FALSE, sep="\t", quote=FALSE)
```

Use the command `groupData  <- read.table("./data/tidyData.txt", header=TRUE, sep="\t", quote=FALSE)` to load the tidy data file.
