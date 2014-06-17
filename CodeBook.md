CodeBook for Assignment on Course Module Getting and Cleaning Data
==================================================================

Introduction
------------

Taken from the file __README.txt__ that came with the data that was analysed 
>*"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."*

Source Data
-----------

The source data was in a zip file the contents of which where extracted into a folder called __UCI HAR Dataset__ retaining any embedded sub directories. 

The source data was downloaded from __https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip__ on _10 June 2014 at 12:35_ and extracted to __./UCI HAR Dataset__.

The folder layout was such that in the root of the extracted data were files that contained data or instructions common to both the training and test data set while the subfolders __train__ and __test__ contained data relative to the different readings.

The following is the list of folders and files generated from the output:

File Name | Notes
--------- | -----
__./activity_labels.txt__ | Text file consisting of 6 rows of data, each row consisting of a single digit integer a space and a description 
__./features.txt__ | Text file consisting of 561 rows of data, each row consisting of an integer followed by a space and a description
__./features_info.txt__ | Text file giving information on the meaning of the variables defined in __./features.txt__
__./README.txt__ | General information about the project and the data
--------- | -----
__./train/y_train.txt__ | Text file containing one integer per line representing the activity. The description of the activity could be obtained by cross referencing __./activity_labels.txt__
__./train/X_train.txt__ | Space delimited text file containing 561 readings generated during the experiment. The column headings of each datum corresponds to the entries in __./features.txt__
__./train/subject_train.txt__ | Text file containing one integer per line representing the partecipant who took part in the study
--------- | -----
__./train/Inertial Signals/body_acc_x_train.txt__ | The acceleration signal from the smartphone accelerometer X axis in standard gravity units  
__./train/Inertial Signals/body_acc_y_train.txt__ | The acceleration signal from the smartphone accelerometer Y axis in standard gravity units  
__./train/Inertial Signals/body_acc_z_train.txt__ | The acceleration signal from the smartphone accelerometer Z axis in standard gravity units  
__./train/Inertial Signals/body_gyro_x_train.txt__ | The body acceleration signal along the X axis  obtained by subtracting the gravity from the total acceleration  
__./train/Inertial Signals/body_gyro_y_train.txt__ | The body acceleration signal along the Y axis  obtained by subtracting the gravity from the total acceleration  
__./train/Inertial Signals/body_gyro_z_train.txt__ | The body acceleration signal along the Z axis  obtained by subtracting the gravity from the total acceleration  
__./train/Inertial Signals/total_acc_x_train.txt__ | The angular velocity vector along the X axis measured by the gyroscope  
__./train/Inertial Signals/total_acc_y_train.txt__ | The angular velocity vector along the Y axis measured by the gyroscope  
__./train/Inertial Signals/total_acc_z_train.txt__ | The angular velocity vector along the Z axis measured by the gyroscope  
--------- | -----
__./test/y_test.txt__ | Text file containing one integer per line representing the activity. The description of the activity could be obtained by cross referencing __./activity_labels.txt__
__./test/X_test.txt__ | Space delimited text file containing 561 readings generated during the experiment. The column headings of each datum corresponds to the entries in __./features.txt__
__./test/subject_test.txt__ | Text file containing one integer per line representing the partecipant who took part in the study 
--------- | -----
__./test/Inertial Signals/body_acc_x_test.txt__ | The acceleration signal from the smartphone accelerometer X axis in standard gravity units
__./test/Inertial Signals/body_acc_y_test.txt__ | The acceleration signal from the smartphone accelerometer Y axis in standard gravity units
__./test/Inertial Signals/body_acc_z_test.txt__ | The acceleration signal from the smartphone accelerometer Z axis in standard gravity units  
__./test/Inertial Signals/body_gyro_x_test.txt__ | The body acceleration signal along the X axis  obtained by subtracting the gravity from the total acceleration
__./test/Inertial Signals/body_gyro_y_test.txt__ | The body acceleration signal along the Y axis  obtained by subtracting the gravity from the total acceleration 
__./test/Inertial Signals/body_gyro_z_test.txt__ | The body acceleration signal along the Z axis  obtained by subtracting the gravity from the total acceleration  
__./test/Inertial Signals/total_acc_x_test.txt__ | The angular velocity vector along the X axis measured by the gyroscope  
__./test/Inertial Signals/total_acc_y_test.txt__ | The angular velocity vector along the Y axis measured by the gyroscope 
__./test/Inertial Signals/total_acc_z_test.txt__ | The angular velocity vector along the Z axis measured by the gyroscope  

---

Generating the tidy data
------------------------

1. The first stage was to read in (__./activity_labels.txt__) and split the data on the space separating the integer from the description.  
**_Tidy Data: The description was converted from block letters to Proper case_**  

2. The row headings for the various readings was read and a character vector was generated from the features data (__./features.txt__).  

3. Given the naming convention used by the authors of the study, it was possible to use the same module to process both the training and test data based upon a parameter passed to the module. For the purposes of this document, the files related to the training data will be used.    
  1. The subjects who participated in the analysis were read from (__./train/subject_train.txt__). There was one row for every record.   
**_Tidy Data: The column name student.no was added to the processed information_**  
  2. The activity list was read from (__./train/y_train.txt__). The data here was an integer. There was one row for every record.  
 **_Tidy Data: The read column was called activity.ref_**.  
 **_Tidy Data: Another second column was added to the read data that cross referenced the integer with the corresponding description (see point 1)_**.  
 **_Tidy Data: The added column was called activity.desc_**.  
  3. The sensor readings where read from (__./train/X_train.txt__).  
 **_Tidy Data: The column data that had been read where incorporated into this data frame (see point 2)_**.  
 
4. **_Tidy Data: The data files generated above (point 1, 2 and 3) were combined together using `cbind()` into one data frame that is complete and properly labelled_**. The resulting data frame is called **trainData**.  

5. Point 3 was repeated on the test data with the same tidying actions described in point 3. The resulting data frame is called **testData**.  

6. **_Tidy Data: The two data frames generated from the training and test data are combined using `data <- rbind(trainData, testData)`_**.  

7. **_Tidy Data: The means of those columns of the data that have the phrase "-mean()"" in their name is computed as shown here:_**
```
means <- lapply("-mean\\(\\)", function(name) { apply(data[,grep(name, names(data))], 2, mean)})
```   

8. **_Tidy Data: The standard deviation of those columns of the data that have the phrase "-std()"" in their name is computed as shown here:_**
```
std <-  lapply("-std\\(\\)", function(name) { apply(data[,grep(name, names(data))], 2, sd)})
```   

9. **_Tidy Data: Using the package data.table, the data frame is converted into a data table. The mean of the 561 numeric factors columns is computed after the data has been grouped by student.no and activity.ref. The resulting data table is converted back into a data frame and is sorted by student.no, activity.ref_**
```
gData <- dt[, lapply(.SD, mean), by=list(student.no, activity.ref), .SDcols=4:ncol(dt)]

 # Convert the data table to a data frame
gData <- as.data.frame(gData)
    
 # sort the data on student.no and activity.reference
groupData <- gData[with(gData, order(student.no, activity.ref)),]
``` 

-----

The resulting files
===================


Data Frame: **data**
--------------------

Contains the raw data from the training and test sets.

```
str(data)
```

>'data.frame':    10299 obs. of  564 variables:  
> _output truncated_

```
colnames(data)
```
>  [1] "student.no"                           "activity.ref"                         "activity.desc"                       
  [4] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                    "tBodyAcc-mean()-Z"                   
  [7] "tBodyAcc-std()-X"                     "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
 [10] "tBodyAcc-mad()-X"                     "tBodyAcc-mad()-Y"                     "tBodyAcc-mad()-Z"                    
 [13] "tBodyAcc-max()-X"                     "tBodyAcc-max()-Y"                     "tBodyAcc-max()-Z"                    
 [16] "tBodyAcc-min()-X"                     "tBodyAcc-min()-Y"                     "tBodyAcc-min()-Z"                    
 [19] "tBodyAcc-sma()"                       "tBodyAcc-energy()-X"                  "tBodyAcc-energy()-Y"                 
 [22] "tBodyAcc-energy()-Z"                  "tBodyAcc-iqr()-X"                     "tBodyAcc-iqr()-Y"                    
 [25] "tBodyAcc-iqr()-Z"                     "tBodyAcc-entropy()-X"                 "tBodyAcc-entropy()-Y"                
 [28] "tBodyAcc-entropy()-Z"                 "tBodyAcc-arCoeff()-X,1"               "tBodyAcc-arCoeff()-X,2"              
 [31] "tBodyAcc-arCoeff()-X,3"               "tBodyAcc-arCoeff()-X,4"               "tBodyAcc-arCoeff()-Y,1"              
 [34] "tBodyAcc-arCoeff()-Y,2"               "tBodyAcc-arCoeff()-Y,3"               "tBodyAcc-arCoeff()-Y,4"              
 [37] "tBodyAcc-arCoeff()-Z,1"               "tBodyAcc-arCoeff()-Z,2"               "tBodyAcc-arCoeff()-Z,3"              
 [40] "tBodyAcc-arCoeff()-Z,4"               "tBodyAcc-correlation()-X,Y"           "tBodyAcc-correlation()-X,Z"          
 [43] "tBodyAcc-correlation()-Y,Z"           "tGravityAcc-mean()-X"                 "tGravityAcc-mean()-Y"                
 [46] "tGravityAcc-mean()-Z"                 "tGravityAcc-std()-X"                  "tGravityAcc-std()-Y"                 
 [49] "tGravityAcc-std()-Z"                  "tGravityAcc-mad()-X"                  "tGravityAcc-mad()-Y"                 
 [52] "tGravityAcc-mad()-Z"                  "tGravityAcc-max()-X"                  "tGravityAcc-max()-Y"                 
 [55] "tGravityAcc-max()-Z"                  "tGravityAcc-min()-X"                  "tGravityAcc-min()-Y"                 
 [58] "tGravityAcc-min()-Z"                  "tGravityAcc-sma()"                    "tGravityAcc-energy()-X"              
 [61] "tGravityAcc-energy()-Y"               "tGravityAcc-energy()-Z"               "tGravityAcc-iqr()-X"                 
 [64] "tGravityAcc-iqr()-Y"                  "tGravityAcc-iqr()-Z"                  "tGravityAcc-entropy()-X"             
 [67] "tGravityAcc-entropy()-Y"              "tGravityAcc-entropy()-Z"              "tGravityAcc-arCoeff()-X,1"           
 [70] "tGravityAcc-arCoeff()-X,2"            "tGravityAcc-arCoeff()-X,3"            "tGravityAcc-arCoeff()-X,4"           
 [73] "tGravityAcc-arCoeff()-Y,1"            "tGravityAcc-arCoeff()-Y,2"            "tGravityAcc-arCoeff()-Y,3"           
 [76] "tGravityAcc-arCoeff()-Y,4"            "tGravityAcc-arCoeff()-Z,1"            "tGravityAcc-arCoeff()-Z,2"           
 [79] "tGravityAcc-arCoeff()-Z,3"            "tGravityAcc-arCoeff()-Z,4"            "tGravityAcc-correlation()-X,Y"       
 [82] "tGravityAcc-correlation()-X,Z"        "tGravityAcc-correlation()-Y,Z"        "tBodyAccJerk-mean()-X"               
 [85] "tBodyAccJerk-mean()-Y"                "tBodyAccJerk-mean()-Z"                "tBodyAccJerk-std()-X"                
 [88] "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                 "tBodyAccJerk-mad()-X"                
 [91] "tBodyAccJerk-mad()-Y"                 "tBodyAccJerk-mad()-Z"                 "tBodyAccJerk-max()-X"                
 [94] "tBodyAccJerk-max()-Y"                 "tBodyAccJerk-max()-Z"                 "tBodyAccJerk-min()-X"                
 [97] "tBodyAccJerk-min()-Y"                 "tBodyAccJerk-min()-Z"                 "tBodyAccJerk-sma()"                  
[100] "tBodyAccJerk-energy()-X"              "tBodyAccJerk-energy()-Y"              "tBodyAccJerk-energy()-Z"             
[103] "tBodyAccJerk-iqr()-X"                 "tBodyAccJerk-iqr()-Y"                 "tBodyAccJerk-iqr()-Z"                
[106] "tBodyAccJerk-entropy()-X"             "tBodyAccJerk-entropy()-Y"             "tBodyAccJerk-entropy()-Z"            
[109] "tBodyAccJerk-arCoeff()-X,1"           "tBodyAccJerk-arCoeff()-X,2"           "tBodyAccJerk-arCoeff()-X,3"          
[112] "tBodyAccJerk-arCoeff()-X,4"           "tBodyAccJerk-arCoeff()-Y,1"           "tBodyAccJerk-arCoeff()-Y,2"          
[115] "tBodyAccJerk-arCoeff()-Y,3"           "tBodyAccJerk-arCoeff()-Y,4"           "tBodyAccJerk-arCoeff()-Z,1"          
[118] "tBodyAccJerk-arCoeff()-Z,2"           "tBodyAccJerk-arCoeff()-Z,3"           "tBodyAccJerk-arCoeff()-Z,4"          
[121] "tBodyAccJerk-correlation()-X,Y"       "tBodyAccJerk-correlation()-X,Z"       "tBodyAccJerk-correlation()-Y,Z"      
[124] "tBodyGyro-mean()-X"                   "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                  
[127] "tBodyGyro-std()-X"                    "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                   
[130] "tBodyGyro-mad()-X"                    "tBodyGyro-mad()-Y"                    "tBodyGyro-mad()-Z"                   
[133] "tBodyGyro-max()-X"                    "tBodyGyro-max()-Y"                    "tBodyGyro-max()-Z"                   
[136] "tBodyGyro-min()-X"                    "tBodyGyro-min()-Y"                    "tBodyGyro-min()-Z"                   
[139] "tBodyGyro-sma()"                      "tBodyGyro-energy()-X"                 "tBodyGyro-energy()-Y"                
[142] "tBodyGyro-energy()-Z"                 "tBodyGyro-iqr()-X"                    "tBodyGyro-iqr()-Y"                   
[145] "tBodyGyro-iqr()-Z"                    "tBodyGyro-entropy()-X"                "tBodyGyro-entropy()-Y"               
[148] "tBodyGyro-entropy()-Z"                "tBodyGyro-arCoeff()-X,1"              "tBodyGyro-arCoeff()-X,2"             
[151] "tBodyGyro-arCoeff()-X,3"              "tBodyGyro-arCoeff()-X,4"              "tBodyGyro-arCoeff()-Y,1"             
[154] "tBodyGyro-arCoeff()-Y,2"              "tBodyGyro-arCoeff()-Y,3"              "tBodyGyro-arCoeff()-Y,4"             
[157] "tBodyGyro-arCoeff()-Z,1"              "tBodyGyro-arCoeff()-Z,2"              "tBodyGyro-arCoeff()-Z,3"             
[160] "tBodyGyro-arCoeff()-Z,4"              "tBodyGyro-correlation()-X,Y"          "tBodyGyro-correlation()-X,Z"         
[163] "tBodyGyro-correlation()-Y,Z"          "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"              
[166] "tBodyGyroJerk-mean()-Z"               "tBodyGyroJerk-std()-X"                "tBodyGyroJerk-std()-Y"               
[169] "tBodyGyroJerk-std()-Z"                "tBodyGyroJerk-mad()-X"                "tBodyGyroJerk-mad()-Y"               
[172] "tBodyGyroJerk-mad()-Z"                "tBodyGyroJerk-max()-X"                "tBodyGyroJerk-max()-Y"               
[175] "tBodyGyroJerk-max()-Z"                "tBodyGyroJerk-min()-X"                "tBodyGyroJerk-min()-Y"               
[178] "tBodyGyroJerk-min()-Z"                "tBodyGyroJerk-sma()"                  "tBodyGyroJerk-energy()-X"            
[181] "tBodyGyroJerk-energy()-Y"             "tBodyGyroJerk-energy()-Z"             "tBodyGyroJerk-iqr()-X"               
[184] "tBodyGyroJerk-iqr()-Y"                "tBodyGyroJerk-iqr()-Z"                "tBodyGyroJerk-entropy()-X"           
[187] "tBodyGyroJerk-entropy()-Y"            "tBodyGyroJerk-entropy()-Z"            "tBodyGyroJerk-arCoeff()-X,1"         
[190] "tBodyGyroJerk-arCoeff()-X,2"          "tBodyGyroJerk-arCoeff()-X,3"          "tBodyGyroJerk-arCoeff()-X,4"         
[193] "tBodyGyroJerk-arCoeff()-Y,1"          "tBodyGyroJerk-arCoeff()-Y,2"          "tBodyGyroJerk-arCoeff()-Y,3"         
[196] "tBodyGyroJerk-arCoeff()-Y,4"          "tBodyGyroJerk-arCoeff()-Z,1"          "tBodyGyroJerk-arCoeff()-Z,2"         
[199] "tBodyGyroJerk-arCoeff()-Z,3"          "tBodyGyroJerk-arCoeff()-Z,4"          "tBodyGyroJerk-correlation()-X,Y"     
[202] "tBodyGyroJerk-correlation()-X,Z"      "tBodyGyroJerk-correlation()-Y,Z"      "tBodyAccMag-mean()"                  
[205] "tBodyAccMag-std()"                    "tBodyAccMag-mad()"                    "tBodyAccMag-max()"                   
[208] "tBodyAccMag-min()"                    "tBodyAccMag-sma()"                    "tBodyAccMag-energy()"                
[211] "tBodyAccMag-iqr()"                    "tBodyAccMag-entropy()"                "tBodyAccMag-arCoeff()1"              
[214] "tBodyAccMag-arCoeff()2"               "tBodyAccMag-arCoeff()3"               "tBodyAccMag-arCoeff()4"              
[217] "tGravityAccMag-mean()"                "tGravityAccMag-std()"                 "tGravityAccMag-mad()"                
[220] "tGravityAccMag-max()"                 "tGravityAccMag-min()"                 "tGravityAccMag-sma()"                
[223] "tGravityAccMag-energy()"              "tGravityAccMag-iqr()"                 "tGravityAccMag-entropy()"            
[226] "tGravityAccMag-arCoeff()1"            "tGravityAccMag-arCoeff()2"            "tGravityAccMag-arCoeff()3"           
[229] "tGravityAccMag-arCoeff()4"            "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"               
[232] "tBodyAccJerkMag-mad()"                "tBodyAccJerkMag-max()"                "tBodyAccJerkMag-min()"               
[235] "tBodyAccJerkMag-sma()"                "tBodyAccJerkMag-energy()"             "tBodyAccJerkMag-iqr()"               
[238] "tBodyAccJerkMag-entropy()"            "tBodyAccJerkMag-arCoeff()1"           "tBodyAccJerkMag-arCoeff()2"          
[241] "tBodyAccJerkMag-arCoeff()3"           "tBodyAccJerkMag-arCoeff()4"           "tBodyGyroMag-mean()"                 
[244] "tBodyGyroMag-std()"                   "tBodyGyroMag-mad()"                   "tBodyGyroMag-max()"                  
[247] "tBodyGyroMag-min()"                   "tBodyGyroMag-sma()"                   "tBodyGyroMag-energy()"               
[250] "tBodyGyroMag-iqr()"                   "tBodyGyroMag-entropy()"               "tBodyGyroMag-arCoeff()1"             
[253] "tBodyGyroMag-arCoeff()2"              "tBodyGyroMag-arCoeff()3"              "tBodyGyroMag-arCoeff()4"             
[256] "tBodyGyroJerkMag-mean()"              "tBodyGyroJerkMag-std()"               "tBodyGyroJerkMag-mad()"              
[259] "tBodyGyroJerkMag-max()"               "tBodyGyroJerkMag-min()"               "tBodyGyroJerkMag-sma()"              
[262] "tBodyGyroJerkMag-energy()"            "tBodyGyroJerkMag-iqr()"               "tBodyGyroJerkMag-entropy()"          
[265] "tBodyGyroJerkMag-arCoeff()1"          "tBodyGyroJerkMag-arCoeff()2"          "tBodyGyroJerkMag-arCoeff()3"         
[268] "tBodyGyroJerkMag-arCoeff()4"          "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
[271] "fBodyAcc-mean()-Z"                    "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                    
[274] "fBodyAcc-std()-Z"                     "fBodyAcc-mad()-X"                     "fBodyAcc-mad()-Y"                    
[277] "fBodyAcc-mad()-Z"                     "fBodyAcc-max()-X"                     "fBodyAcc-max()-Y"                    
[280] "fBodyAcc-max()-Z"                     "fBodyAcc-min()-X"                     "fBodyAcc-min()-Y"                    
[283] "fBodyAcc-min()-Z"                     "fBodyAcc-sma()"                       "fBodyAcc-energy()-X"                 
[286] "fBodyAcc-energy()-Y"                  "fBodyAcc-energy()-Z"                  "fBodyAcc-iqr()-X"                    
[289] "fBodyAcc-iqr()-Y"                     "fBodyAcc-iqr()-Z"                     "fBodyAcc-entropy()-X"                
[292] "fBodyAcc-entropy()-Y"                 "fBodyAcc-entropy()-Z"                 "fBodyAcc-maxInds-X"                  
[295] "fBodyAcc-maxInds-Y"                   "fBodyAcc-maxInds-Z"                   "fBodyAcc-meanFreq()-X"               
[298] "fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"                "fBodyAcc-skewness()-X"               
[301] "fBodyAcc-kurtosis()-X"                "fBodyAcc-skewness()-Y"                "fBodyAcc-kurtosis()-Y"               
[304] "fBodyAcc-skewness()-Z"                "fBodyAcc-kurtosis()-Z"                "fBodyAcc-bandsEnergy()-1,8"          
[307] "fBodyAcc-bandsEnergy()-9,16"          "fBodyAcc-bandsEnergy()-17,24"         "fBodyAcc-bandsEnergy()-25,32"        
[310] "fBodyAcc-bandsEnergy()-33,40"         "fBodyAcc-bandsEnergy()-41,48"         "fBodyAcc-bandsEnergy()-49,56"        
[313] "fBodyAcc-bandsEnergy()-57,64"         "fBodyAcc-bandsEnergy()-1,16"          "fBodyAcc-bandsEnergy()-17,32"        
[316] "fBodyAcc-bandsEnergy()-33,48"         "fBodyAcc-bandsEnergy()-49,64"         "fBodyAcc-bandsEnergy()-1,24"         
[319] "fBodyAcc-bandsEnergy()-25,48"         "fBodyAcc-bandsEnergy()-1,8"           "fBodyAcc-bandsEnergy()-9,16"         
[322] "fBodyAcc-bandsEnergy()-17,24"         "fBodyAcc-bandsEnergy()-25,32"         "fBodyAcc-bandsEnergy()-33,40"        
[325] "fBodyAcc-bandsEnergy()-41,48"         "fBodyAcc-bandsEnergy()-49,56"         "fBodyAcc-bandsEnergy()-57,64"        
[328] "fBodyAcc-bandsEnergy()-1,16"          "fBodyAcc-bandsEnergy()-17,32"         "fBodyAcc-bandsEnergy()-33,48"        
[331] "fBodyAcc-bandsEnergy()-49,64"         "fBodyAcc-bandsEnergy()-1,24"          "fBodyAcc-bandsEnergy()-25,48"        
[334] "fBodyAcc-bandsEnergy()-1,8"           "fBodyAcc-bandsEnergy()-9,16"          "fBodyAcc-bandsEnergy()-17,24"        
[337] "fBodyAcc-bandsEnergy()-25,32"         "fBodyAcc-bandsEnergy()-33,40"         "fBodyAcc-bandsEnergy()-41,48"        
[340] "fBodyAcc-bandsEnergy()-49,56"         "fBodyAcc-bandsEnergy()-57,64"         "fBodyAcc-bandsEnergy()-1,16"         
[343] "fBodyAcc-bandsEnergy()-17,32"         "fBodyAcc-bandsEnergy()-33,48"         "fBodyAcc-bandsEnergy()-49,64"        
[346] "fBodyAcc-bandsEnergy()-1,24"          "fBodyAcc-bandsEnergy()-25,48"         "fBodyAccJerk-mean()-X"               
[349] "fBodyAccJerk-mean()-Y"                "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-std()-X"                
[352] "fBodyAccJerk-std()-Y"                 "fBodyAccJerk-std()-Z"                 "fBodyAccJerk-mad()-X"                
[355] "fBodyAccJerk-mad()-Y"                 "fBodyAccJerk-mad()-Z"                 "fBodyAccJerk-max()-X"                
[358] "fBodyAccJerk-max()-Y"                 "fBodyAccJerk-max()-Z"                 "fBodyAccJerk-min()-X"                
[361] "fBodyAccJerk-min()-Y"                 "fBodyAccJerk-min()-Z"                 "fBodyAccJerk-sma()"                  
[364] "fBodyAccJerk-energy()-X"              "fBodyAccJerk-energy()-Y"              "fBodyAccJerk-energy()-Z"             
[367] "fBodyAccJerk-iqr()-X"                 "fBodyAccJerk-iqr()-Y"                 "fBodyAccJerk-iqr()-Z"                
[370] "fBodyAccJerk-entropy()-X"             "fBodyAccJerk-entropy()-Y"             "fBodyAccJerk-entropy()-Z"            
[373] "fBodyAccJerk-maxInds-X"               "fBodyAccJerk-maxInds-Y"               "fBodyAccJerk-maxInds-Z"              
[376] "fBodyAccJerk-meanFreq()-X"            "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"           
[379] "fBodyAccJerk-skewness()-X"            "fBodyAccJerk-kurtosis()-X"            "fBodyAccJerk-skewness()-Y"           
[382] "fBodyAccJerk-kurtosis()-Y"            "fBodyAccJerk-skewness()-Z"            "fBodyAccJerk-kurtosis()-Z"           
[385] "fBodyAccJerk-bandsEnergy()-1,8"       "fBodyAccJerk-bandsEnergy()-9,16"      "fBodyAccJerk-bandsEnergy()-17,24"    
[388] "fBodyAccJerk-bandsEnergy()-25,32"     "fBodyAccJerk-bandsEnergy()-33,40"     "fBodyAccJerk-bandsEnergy()-41,48"    
[391] "fBodyAccJerk-bandsEnergy()-49,56"     "fBodyAccJerk-bandsEnergy()-57,64"     "fBodyAccJerk-bandsEnergy()-1,16"     
[394] "fBodyAccJerk-bandsEnergy()-17,32"     "fBodyAccJerk-bandsEnergy()-33,48"     "fBodyAccJerk-bandsEnergy()-49,64"    
[397] "fBodyAccJerk-bandsEnergy()-1,24"      "fBodyAccJerk-bandsEnergy()-25,48"     "fBodyAccJerk-bandsEnergy()-1,8"      
[400] "fBodyAccJerk-bandsEnergy()-9,16"      "fBodyAccJerk-bandsEnergy()-17,24"     "fBodyAccJerk-bandsEnergy()-25,32"    
[403] "fBodyAccJerk-bandsEnergy()-33,40"     "fBodyAccJerk-bandsEnergy()-41,48"     "fBodyAccJerk-bandsEnergy()-49,56"    
[406] "fBodyAccJerk-bandsEnergy()-57,64"     "fBodyAccJerk-bandsEnergy()-1,16"      "fBodyAccJerk-bandsEnergy()-17,32"    
[409] "fBodyAccJerk-bandsEnergy()-33,48"     "fBodyAccJerk-bandsEnergy()-49,64"     "fBodyAccJerk-bandsEnergy()-1,24"     
[412] "fBodyAccJerk-bandsEnergy()-25,48"     "fBodyAccJerk-bandsEnergy()-1,8"       "fBodyAccJerk-bandsEnergy()-9,16"     
[415] "fBodyAccJerk-bandsEnergy()-17,24"     "fBodyAccJerk-bandsEnergy()-25,32"     "fBodyAccJerk-bandsEnergy()-33,40"    
[418] "fBodyAccJerk-bandsEnergy()-41,48"     "fBodyAccJerk-bandsEnergy()-49,56"     "fBodyAccJerk-bandsEnergy()-57,64"    
[421] "fBodyAccJerk-bandsEnergy()-1,16"      "fBodyAccJerk-bandsEnergy()-17,32"     "fBodyAccJerk-bandsEnergy()-33,48"    
[424] "fBodyAccJerk-bandsEnergy()-49,64"     "fBodyAccJerk-bandsEnergy()-1,24"      "fBodyAccJerk-bandsEnergy()-25,48"    
[427] "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                   "fBodyGyro-mean()-Z"                  
[430] "fBodyGyro-std()-X"                    "fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"                   
[433] "fBodyGyro-mad()-X"                    "fBodyGyro-mad()-Y"                    "fBodyGyro-mad()-Z"                   
[436] "fBodyGyro-max()-X"                    "fBodyGyro-max()-Y"                    "fBodyGyro-max()-Z"                   
[439] "fBodyGyro-min()-X"                    "fBodyGyro-min()-Y"                    "fBodyGyro-min()-Z"                   
[442] "fBodyGyro-sma()"                      "fBodyGyro-energy()-X"                 "fBodyGyro-energy()-Y"                
[445] "fBodyGyro-energy()-Z"                 "fBodyGyro-iqr()-X"                    "fBodyGyro-iqr()-Y"                   
[448] "fBodyGyro-iqr()-Z"                    "fBodyGyro-entropy()-X"                "fBodyGyro-entropy()-Y"               
[451] "fBodyGyro-entropy()-Z"                "fBodyGyro-maxInds-X"                  "fBodyGyro-maxInds-Y"                 
[454] "fBodyGyro-maxInds-Z"                  "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"              
[457] "fBodyGyro-meanFreq()-Z"               "fBodyGyro-skewness()-X"               "fBodyGyro-kurtosis()-X"              
[460] "fBodyGyro-skewness()-Y"               "fBodyGyro-kurtosis()-Y"               "fBodyGyro-skewness()-Z"              
[463] "fBodyGyro-kurtosis()-Z"               "fBodyGyro-bandsEnergy()-1,8"          "fBodyGyro-bandsEnergy()-9,16"        
[466] "fBodyGyro-bandsEnergy()-17,24"        "fBodyGyro-bandsEnergy()-25,32"        "fBodyGyro-bandsEnergy()-33,40"       
[469] "fBodyGyro-bandsEnergy()-41,48"        "fBodyGyro-bandsEnergy()-49,56"        "fBodyGyro-bandsEnergy()-57,64"       
[472] "fBodyGyro-bandsEnergy()-1,16"         "fBodyGyro-bandsEnergy()-17,32"        "fBodyGyro-bandsEnergy()-33,48"       
[475] "fBodyGyro-bandsEnergy()-49,64"        "fBodyGyro-bandsEnergy()-1,24"         "fBodyGyro-bandsEnergy()-25,48"       
[478] "fBodyGyro-bandsEnergy()-1,8"          "fBodyGyro-bandsEnergy()-9,16"         "fBodyGyro-bandsEnergy()-17,24"       
[481] "fBodyGyro-bandsEnergy()-25,32"        "fBodyGyro-bandsEnergy()-33,40"        "fBodyGyro-bandsEnergy()-41,48"       
[484] "fBodyGyro-bandsEnergy()-49,56"        "fBodyGyro-bandsEnergy()-57,64"        "fBodyGyro-bandsEnergy()-1,16"        
[487] "fBodyGyro-bandsEnergy()-17,32"        "fBodyGyro-bandsEnergy()-33,48"        "fBodyGyro-bandsEnergy()-49,64"       
[490] "fBodyGyro-bandsEnergy()-1,24"         "fBodyGyro-bandsEnergy()-25,48"        "fBodyGyro-bandsEnergy()-1,8"         
[493] "fBodyGyro-bandsEnergy()-9,16"         "fBodyGyro-bandsEnergy()-17,24"        "fBodyGyro-bandsEnergy()-25,32"       
[496] "fBodyGyro-bandsEnergy()-33,40"        "fBodyGyro-bandsEnergy()-41,48"        "fBodyGyro-bandsEnergy()-49,56"       
[499] "fBodyGyro-bandsEnergy()-57,64"        "fBodyGyro-bandsEnergy()-1,16"         "fBodyGyro-bandsEnergy()-17,32"       
[502] "fBodyGyro-bandsEnergy()-33,48"        "fBodyGyro-bandsEnergy()-49,64"        "fBodyGyro-bandsEnergy()-1,24"        
[505] "fBodyGyro-bandsEnergy()-25,48"        "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                   
[508] "fBodyAccMag-mad()"                    "fBodyAccMag-max()"                    "fBodyAccMag-min()"                   
[511] "fBodyAccMag-sma()"                    "fBodyAccMag-energy()"                 "fBodyAccMag-iqr()"                   
[514] "fBodyAccMag-entropy()"                "fBodyAccMag-maxInds"                  "fBodyAccMag-meanFreq()"              
[517] "fBodyAccMag-skewness()"               "fBodyAccMag-kurtosis()"               "fBodyBodyAccJerkMag-mean()"          
[520] "fBodyBodyAccJerkMag-std()"            "fBodyBodyAccJerkMag-mad()"            "fBodyBodyAccJerkMag-max()"           
[523] "fBodyBodyAccJerkMag-min()"            "fBodyBodyAccJerkMag-sma()"            "fBodyBodyAccJerkMag-energy()"        
[526] "fBodyBodyAccJerkMag-iqr()"            "fBodyBodyAccJerkMag-entropy()"        "fBodyBodyAccJerkMag-maxInds"         
[529] "fBodyBodyAccJerkMag-meanFreq()"       "fBodyBodyAccJerkMag-skewness()"       "fBodyBodyAccJerkMag-kurtosis()"      
[532] "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-std()"               "fBodyBodyGyroMag-mad()"              
[535] "fBodyBodyGyroMag-max()"               "fBodyBodyGyroMag-min()"               "fBodyBodyGyroMag-sma()"              
[538] "fBodyBodyGyroMag-energy()"            "fBodyBodyGyroMag-iqr()"               "fBodyBodyGyroMag-entropy()"          
[541] "fBodyBodyGyroMag-maxInds"             "fBodyBodyGyroMag-meanFreq()"          "fBodyBodyGyroMag-skewness()"         
[544] "fBodyBodyGyroMag-kurtosis()"          "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"          
[547] "fBodyBodyGyroJerkMag-mad()"           "fBodyBodyGyroJerkMag-max()"           "fBodyBodyGyroJerkMag-min()"          
[550] "fBodyBodyGyroJerkMag-sma()"           "fBodyBodyGyroJerkMag-energy()"        "fBodyBodyGyroJerkMag-iqr()"          
[553] "fBodyBodyGyroJerkMag-entropy()"       "fBodyBodyGyroJerkMag-maxInds"         "fBodyBodyGyroJerkMag-meanFreq()"     
[556] "fBodyBodyGyroJerkMag-skewness()"      "fBodyBodyGyroJerkMag-kurtosis()"      "angle(tBodyAccMean,gravity)"         
[559] "angle(tBodyAccJerkMean),gravityMean)" "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)"  
>[562] "angle(X,gravityMean)"                 "angle(Y,gravityMean)"                 "angle(Z,gravityMean)"                

Col Number | Column Name | Description
---------- | ----------- | -----------
1 | student.no | numeric reference to the student from whom the readings were sourced  
2 | activity.ref | numeric reference to the type of activity measured
3 | activity.desc | textual description of the activity
4 - 562 | | See the supplied file __./features_info.txt__ for column description



Data Frame: **groupData**
-------------------------

```
str(groupData)
```

Stores the information shown in data grouped by student and activity. The mean value of numeric columns is taken.

>'data.frame':    180 obs. of  564 variables:  
> _output truncated_

```
colnames(groupData)
```
>   [1] "student.no"                           "activity.ref"                         "tBodyAcc-mean()-X"                   
  [4] "tBodyAcc-mean()-Y"                    "tBodyAcc-mean()-Z"                    "tBodyAcc-std()-X"                    
  [7] "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                     "tBodyAcc-mad()-X"                    
 [10] "tBodyAcc-mad()-Y"                     "tBodyAcc-mad()-Z"                     "tBodyAcc-max()-X"                    
 [13] "tBodyAcc-max()-Y"                     "tBodyAcc-max()-Z"                     "tBodyAcc-min()-X"                    
 [16] "tBodyAcc-min()-Y"                     "tBodyAcc-min()-Z"                     "tBodyAcc-sma()"                      
 [19] "tBodyAcc-energy()-X"                  "tBodyAcc-energy()-Y"                  "tBodyAcc-energy()-Z"                 
 [22] "tBodyAcc-iqr()-X"                     "tBodyAcc-iqr()-Y"                     "tBodyAcc-iqr()-Z"                    
 [25] "tBodyAcc-entropy()-X"                 "tBodyAcc-entropy()-Y"                 "tBodyAcc-entropy()-Z"                
 [28] "tBodyAcc-arCoeff()-X,1"               "tBodyAcc-arCoeff()-X,2"               "tBodyAcc-arCoeff()-X,3"              
 [31] "tBodyAcc-arCoeff()-X,4"               "tBodyAcc-arCoeff()-Y,1"               "tBodyAcc-arCoeff()-Y,2"              
 [34] "tBodyAcc-arCoeff()-Y,3"               "tBodyAcc-arCoeff()-Y,4"               "tBodyAcc-arCoeff()-Z,1"              
 [37] "tBodyAcc-arCoeff()-Z,2"               "tBodyAcc-arCoeff()-Z,3"               "tBodyAcc-arCoeff()-Z,4"              
 [40] "tBodyAcc-correlation()-X,Y"           "tBodyAcc-correlation()-X,Z"           "tBodyAcc-correlation()-Y,Z"          
 [43] "tGravityAcc-mean()-X"                 "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                
 [46] "tGravityAcc-std()-X"                  "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                 
 [49] "tGravityAcc-mad()-X"                  "tGravityAcc-mad()-Y"                  "tGravityAcc-mad()-Z"                 
 [52] "tGravityAcc-max()-X"                  "tGravityAcc-max()-Y"                  "tGravityAcc-max()-Z"                 
 [55] "tGravityAcc-min()-X"                  "tGravityAcc-min()-Y"                  "tGravityAcc-min()-Z"                 
 [58] "tGravityAcc-sma()"                    "tGravityAcc-energy()-X"               "tGravityAcc-energy()-Y"              
 [61] "tGravityAcc-energy()-Z"               "tGravityAcc-iqr()-X"                  "tGravityAcc-iqr()-Y"                 
 [64] "tGravityAcc-iqr()-Z"                  "tGravityAcc-entropy()-X"              "tGravityAcc-entropy()-Y"             
 [67] "tGravityAcc-entropy()-Z"              "tGravityAcc-arCoeff()-X,1"            "tGravityAcc-arCoeff()-X,2"           
 [70] "tGravityAcc-arCoeff()-X,3"            "tGravityAcc-arCoeff()-X,4"            "tGravityAcc-arCoeff()-Y,1"           
 [73] "tGravityAcc-arCoeff()-Y,2"            "tGravityAcc-arCoeff()-Y,3"            "tGravityAcc-arCoeff()-Y,4"           
 [76] "tGravityAcc-arCoeff()-Z,1"            "tGravityAcc-arCoeff()-Z,2"            "tGravityAcc-arCoeff()-Z,3"           
 [79] "tGravityAcc-arCoeff()-Z,4"            "tGravityAcc-correlation()-X,Y"        "tGravityAcc-correlation()-X,Z"       
 [82] "tGravityAcc-correlation()-Y,Z"        "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"               
 [85] "tBodyAccJerk-mean()-Z"                "tBodyAccJerk-std()-X"                 "tBodyAccJerk-std()-Y"                
 [88] "tBodyAccJerk-std()-Z"                 "tBodyAccJerk-mad()-X"                 "tBodyAccJerk-mad()-Y"                
 [91] "tBodyAccJerk-mad()-Z"                 "tBodyAccJerk-max()-X"                 "tBodyAccJerk-max()-Y"                
 [94] "tBodyAccJerk-max()-Z"                 "tBodyAccJerk-min()-X"                 "tBodyAccJerk-min()-Y"                
 [97] "tBodyAccJerk-min()-Z"                 "tBodyAccJerk-sma()"                   "tBodyAccJerk-energy()-X"             
[100] "tBodyAccJerk-energy()-Y"              "tBodyAccJerk-energy()-Z"              "tBodyAccJerk-iqr()-X"                
[103] "tBodyAccJerk-iqr()-Y"                 "tBodyAccJerk-iqr()-Z"                 "tBodyAccJerk-entropy()-X"            
[106] "tBodyAccJerk-entropy()-Y"             "tBodyAccJerk-entropy()-Z"             "tBodyAccJerk-arCoeff()-X,1"          
[109] "tBodyAccJerk-arCoeff()-X,2"           "tBodyAccJerk-arCoeff()-X,3"           "tBodyAccJerk-arCoeff()-X,4"          
[112] "tBodyAccJerk-arCoeff()-Y,1"           "tBodyAccJerk-arCoeff()-Y,2"           "tBodyAccJerk-arCoeff()-Y,3"          
[115] "tBodyAccJerk-arCoeff()-Y,4"           "tBodyAccJerk-arCoeff()-Z,1"           "tBodyAccJerk-arCoeff()-Z,2"          
[118] "tBodyAccJerk-arCoeff()-Z,3"           "tBodyAccJerk-arCoeff()-Z,4"           "tBodyAccJerk-correlation()-X,Y"      
[121] "tBodyAccJerk-correlation()-X,Z"       "tBodyAccJerk-correlation()-Y,Z"       "tBodyGyro-mean()-X"                  
[124] "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                   "tBodyGyro-std()-X"                   
[127] "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                    "tBodyGyro-mad()-X"                   
[130] "tBodyGyro-mad()-Y"                    "tBodyGyro-mad()-Z"                    "tBodyGyro-max()-X"                   
[133] "tBodyGyro-max()-Y"                    "tBodyGyro-max()-Z"                    "tBodyGyro-min()-X"                   
[136] "tBodyGyro-min()-Y"                    "tBodyGyro-min()-Z"                    "tBodyGyro-sma()"                     
[139] "tBodyGyro-energy()-X"                 "tBodyGyro-energy()-Y"                 "tBodyGyro-energy()-Z"                
[142] "tBodyGyro-iqr()-X"                    "tBodyGyro-iqr()-Y"                    "tBodyGyro-iqr()-Z"                   
[145] "tBodyGyro-entropy()-X"                "tBodyGyro-entropy()-Y"                "tBodyGyro-entropy()-Z"               
[148] "tBodyGyro-arCoeff()-X,1"              "tBodyGyro-arCoeff()-X,2"              "tBodyGyro-arCoeff()-X,3"             
[151] "tBodyGyro-arCoeff()-X,4"              "tBodyGyro-arCoeff()-Y,1"              "tBodyGyro-arCoeff()-Y,2"             
[154] "tBodyGyro-arCoeff()-Y,3"              "tBodyGyro-arCoeff()-Y,4"              "tBodyGyro-arCoeff()-Z,1"             
[157] "tBodyGyro-arCoeff()-Z,2"              "tBodyGyro-arCoeff()-Z,3"              "tBodyGyro-arCoeff()-Z,4"             
[160] "tBodyGyro-correlation()-X,Y"          "tBodyGyro-correlation()-X,Z"          "tBodyGyro-correlation()-Y,Z"         
[163] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"               "tBodyGyroJerk-mean()-Z"              
[166] "tBodyGyroJerk-std()-X"                "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
[169] "tBodyGyroJerk-mad()-X"                "tBodyGyroJerk-mad()-Y"                "tBodyGyroJerk-mad()-Z"               
[172] "tBodyGyroJerk-max()-X"                "tBodyGyroJerk-max()-Y"                "tBodyGyroJerk-max()-Z"               
[175] "tBodyGyroJerk-min()-X"                "tBodyGyroJerk-min()-Y"                "tBodyGyroJerk-min()-Z"               
[178] "tBodyGyroJerk-sma()"                  "tBodyGyroJerk-energy()-X"             "tBodyGyroJerk-energy()-Y"            
[181] "tBodyGyroJerk-energy()-Z"             "tBodyGyroJerk-iqr()-X"                "tBodyGyroJerk-iqr()-Y"               
[184] "tBodyGyroJerk-iqr()-Z"                "tBodyGyroJerk-entropy()-X"            "tBodyGyroJerk-entropy()-Y"           
[187] "tBodyGyroJerk-entropy()-Z"            "tBodyGyroJerk-arCoeff()-X,1"          "tBodyGyroJerk-arCoeff()-X,2"         
[190] "tBodyGyroJerk-arCoeff()-X,3"          "tBodyGyroJerk-arCoeff()-X,4"          "tBodyGyroJerk-arCoeff()-Y,1"         
[193] "tBodyGyroJerk-arCoeff()-Y,2"          "tBodyGyroJerk-arCoeff()-Y,3"          "tBodyGyroJerk-arCoeff()-Y,4"         
[196] "tBodyGyroJerk-arCoeff()-Z,1"          "tBodyGyroJerk-arCoeff()-Z,2"          "tBodyGyroJerk-arCoeff()-Z,3"         
[199] "tBodyGyroJerk-arCoeff()-Z,4"          "tBodyGyroJerk-correlation()-X,Y"      "tBodyGyroJerk-correlation()-X,Z"     
[202] "tBodyGyroJerk-correlation()-Y,Z"      "tBodyAccMag-mean()"                   "tBodyAccMag-std()"                   
[205] "tBodyAccMag-mad()"                    "tBodyAccMag-max()"                    "tBodyAccMag-min()"                   
[208] "tBodyAccMag-sma()"                    "tBodyAccMag-energy()"                 "tBodyAccMag-iqr()"                   
[211] "tBodyAccMag-entropy()"                "tBodyAccMag-arCoeff()1"               "tBodyAccMag-arCoeff()2"              
[214] "tBodyAccMag-arCoeff()3"               "tBodyAccMag-arCoeff()4"               "tGravityAccMag-mean()"               
[217] "tGravityAccMag-std()"                 "tGravityAccMag-mad()"                 "tGravityAccMag-max()"                
[220] "tGravityAccMag-min()"                 "tGravityAccMag-sma()"                 "tGravityAccMag-energy()"             
[223] "tGravityAccMag-iqr()"                 "tGravityAccMag-entropy()"             "tGravityAccMag-arCoeff()1"           
[226] "tGravityAccMag-arCoeff()2"            "tGravityAccMag-arCoeff()3"            "tGravityAccMag-arCoeff()4"           
[229] "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"                "tBodyAccJerkMag-mad()"               
[232] "tBodyAccJerkMag-max()"                "tBodyAccJerkMag-min()"                "tBodyAccJerkMag-sma()"               
[235] "tBodyAccJerkMag-energy()"             "tBodyAccJerkMag-iqr()"                "tBodyAccJerkMag-entropy()"           
[238] "tBodyAccJerkMag-arCoeff()1"           "tBodyAccJerkMag-arCoeff()2"           "tBodyAccJerkMag-arCoeff()3"          
[241] "tBodyAccJerkMag-arCoeff()4"           "tBodyGyroMag-mean()"                  "tBodyGyroMag-std()"                  
[244] "tBodyGyroMag-mad()"                   "tBodyGyroMag-max()"                   "tBodyGyroMag-min()"                  
[247] "tBodyGyroMag-sma()"                   "tBodyGyroMag-energy()"                "tBodyGyroMag-iqr()"                  
[250] "tBodyGyroMag-entropy()"               "tBodyGyroMag-arCoeff()1"              "tBodyGyroMag-arCoeff()2"             
[253] "tBodyGyroMag-arCoeff()3"              "tBodyGyroMag-arCoeff()4"              "tBodyGyroJerkMag-mean()"             
[256] "tBodyGyroJerkMag-std()"               "tBodyGyroJerkMag-mad()"               "tBodyGyroJerkMag-max()"              
[259] "tBodyGyroJerkMag-min()"               "tBodyGyroJerkMag-sma()"               "tBodyGyroJerkMag-energy()"           
[262] "tBodyGyroJerkMag-iqr()"               "tBodyGyroJerkMag-entropy()"           "tBodyGyroJerkMag-arCoeff()1"         
[265] "tBodyGyroJerkMag-arCoeff()2"          "tBodyGyroJerkMag-arCoeff()3"          "tBodyGyroJerkMag-arCoeff()4"         
[268] "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                    "fBodyAcc-mean()-Z"                   
[271] "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                     "fBodyAcc-std()-Z"                    
[274] "fBodyAcc-mad()-X"                     "fBodyAcc-mad()-Y"                     "fBodyAcc-mad()-Z"                    
[277] "fBodyAcc-max()-X"                     "fBodyAcc-max()-Y"                     "fBodyAcc-max()-Z"                    
[280] "fBodyAcc-min()-X"                     "fBodyAcc-min()-Y"                     "fBodyAcc-min()-Z"                    
[283] "fBodyAcc-sma()"                       "fBodyAcc-energy()-X"                  "fBodyAcc-energy()-Y"                 
[286] "fBodyAcc-energy()-Z"                  "fBodyAcc-iqr()-X"                     "fBodyAcc-iqr()-Y"                    
[289] "fBodyAcc-iqr()-Z"                     "fBodyAcc-entropy()-X"                 "fBodyAcc-entropy()-Y"                
[292] "fBodyAcc-entropy()-Z"                 "fBodyAcc-maxInds-X"                   "fBodyAcc-maxInds-Y"                  
[295] "fBodyAcc-maxInds-Z"                   "fBodyAcc-meanFreq()-X"                "fBodyAcc-meanFreq()-Y"               
[298] "fBodyAcc-meanFreq()-Z"                "fBodyAcc-skewness()-X"                "fBodyAcc-kurtosis()-X"               
[301] "fBodyAcc-skewness()-Y"                "fBodyAcc-kurtosis()-Y"                "fBodyAcc-skewness()-Z"               
[304] "fBodyAcc-kurtosis()-Z"                "fBodyAcc-bandsEnergy()-1,8"           "fBodyAcc-bandsEnergy()-9,16"         
[307] "fBodyAcc-bandsEnergy()-17,24"         "fBodyAcc-bandsEnergy()-25,32"         "fBodyAcc-bandsEnergy()-33,40"        
[310] "fBodyAcc-bandsEnergy()-41,48"         "fBodyAcc-bandsEnergy()-49,56"         "fBodyAcc-bandsEnergy()-57,64"        
[313] "fBodyAcc-bandsEnergy()-1,16"          "fBodyAcc-bandsEnergy()-17,32"         "fBodyAcc-bandsEnergy()-33,48"        
[316] "fBodyAcc-bandsEnergy()-49,64"         "fBodyAcc-bandsEnergy()-1,24"          "fBodyAcc-bandsEnergy()-25,48"        
[319] "fBodyAcc-bandsEnergy()-1,8"           "fBodyAcc-bandsEnergy()-9,16"          "fBodyAcc-bandsEnergy()-17,24"        
[322] "fBodyAcc-bandsEnergy()-25,32"         "fBodyAcc-bandsEnergy()-33,40"         "fBodyAcc-bandsEnergy()-41,48"        
[325] "fBodyAcc-bandsEnergy()-49,56"         "fBodyAcc-bandsEnergy()-57,64"         "fBodyAcc-bandsEnergy()-1,16"         
[328] "fBodyAcc-bandsEnergy()-17,32"         "fBodyAcc-bandsEnergy()-33,48"         "fBodyAcc-bandsEnergy()-49,64"        
[331] "fBodyAcc-bandsEnergy()-1,24"          "fBodyAcc-bandsEnergy()-25,48"         "fBodyAcc-bandsEnergy()-1,8"          
[334] "fBodyAcc-bandsEnergy()-9,16"          "fBodyAcc-bandsEnergy()-17,24"         "fBodyAcc-bandsEnergy()-25,32"        
[337] "fBodyAcc-bandsEnergy()-33,40"         "fBodyAcc-bandsEnergy()-41,48"         "fBodyAcc-bandsEnergy()-49,56"        
[340] "fBodyAcc-bandsEnergy()-57,64"         "fBodyAcc-bandsEnergy()-1,16"          "fBodyAcc-bandsEnergy()-17,32"        
[343] "fBodyAcc-bandsEnergy()-33,48"         "fBodyAcc-bandsEnergy()-49,64"         "fBodyAcc-bandsEnergy()-1,24"         
[346] "fBodyAcc-bandsEnergy()-25,48"         "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
[349] "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                
[352] "fBodyAccJerk-std()-Z"                 "fBodyAccJerk-mad()-X"                 "fBodyAccJerk-mad()-Y"                
[355] "fBodyAccJerk-mad()-Z"                 "fBodyAccJerk-max()-X"                 "fBodyAccJerk-max()-Y"                
[358] "fBodyAccJerk-max()-Z"                 "fBodyAccJerk-min()-X"                 "fBodyAccJerk-min()-Y"                
[361] "fBodyAccJerk-min()-Z"                 "fBodyAccJerk-sma()"                   "fBodyAccJerk-energy()-X"             
[364] "fBodyAccJerk-energy()-Y"              "fBodyAccJerk-energy()-Z"              "fBodyAccJerk-iqr()-X"                
[367] "fBodyAccJerk-iqr()-Y"                 "fBodyAccJerk-iqr()-Z"                 "fBodyAccJerk-entropy()-X"            
[370] "fBodyAccJerk-entropy()-Y"             "fBodyAccJerk-entropy()-Z"             "fBodyAccJerk-maxInds-X"              
[373] "fBodyAccJerk-maxInds-Y"               "fBodyAccJerk-maxInds-Z"               "fBodyAccJerk-meanFreq()-X"           
[376] "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"            "fBodyAccJerk-skewness()-X"           
[379] "fBodyAccJerk-kurtosis()-X"            "fBodyAccJerk-skewness()-Y"            "fBodyAccJerk-kurtosis()-Y"           
[382] "fBodyAccJerk-skewness()-Z"            "fBodyAccJerk-kurtosis()-Z"            "fBodyAccJerk-bandsEnergy()-1,8"      
[385] "fBodyAccJerk-bandsEnergy()-9,16"      "fBodyAccJerk-bandsEnergy()-17,24"     "fBodyAccJerk-bandsEnergy()-25,32"    
[388] "fBodyAccJerk-bandsEnergy()-33,40"     "fBodyAccJerk-bandsEnergy()-41,48"     "fBodyAccJerk-bandsEnergy()-49,56"    
[391] "fBodyAccJerk-bandsEnergy()-57,64"     "fBodyAccJerk-bandsEnergy()-1,16"      "fBodyAccJerk-bandsEnergy()-17,32"    
[394] "fBodyAccJerk-bandsEnergy()-33,48"     "fBodyAccJerk-bandsEnergy()-49,64"     "fBodyAccJerk-bandsEnergy()-1,24"     
[397] "fBodyAccJerk-bandsEnergy()-25,48"     "fBodyAccJerk-bandsEnergy()-1,8"       "fBodyAccJerk-bandsEnergy()-9,16"     
[400] "fBodyAccJerk-bandsEnergy()-17,24"     "fBodyAccJerk-bandsEnergy()-25,32"     "fBodyAccJerk-bandsEnergy()-33,40"    
[403] "fBodyAccJerk-bandsEnergy()-41,48"     "fBodyAccJerk-bandsEnergy()-49,56"     "fBodyAccJerk-bandsEnergy()-57,64"    
[406] "fBodyAccJerk-bandsEnergy()-1,16"      "fBodyAccJerk-bandsEnergy()-17,32"     "fBodyAccJerk-bandsEnergy()-33,48"    
[409] "fBodyAccJerk-bandsEnergy()-49,64"     "fBodyAccJerk-bandsEnergy()-1,24"      "fBodyAccJerk-bandsEnergy()-25,48"    
[412] "fBodyAccJerk-bandsEnergy()-1,8"       "fBodyAccJerk-bandsEnergy()-9,16"      "fBodyAccJerk-bandsEnergy()-17,24"    
[415] "fBodyAccJerk-bandsEnergy()-25,32"     "fBodyAccJerk-bandsEnergy()-33,40"     "fBodyAccJerk-bandsEnergy()-41,48"    
[418] "fBodyAccJerk-bandsEnergy()-49,56"     "fBodyAccJerk-bandsEnergy()-57,64"     "fBodyAccJerk-bandsEnergy()-1,16"     
[421] "fBodyAccJerk-bandsEnergy()-17,32"     "fBodyAccJerk-bandsEnergy()-33,48"     "fBodyAccJerk-bandsEnergy()-49,64"    
[424] "fBodyAccJerk-bandsEnergy()-1,24"      "fBodyAccJerk-bandsEnergy()-25,48"     "fBodyGyro-mean()-X"                  
[427] "fBodyGyro-mean()-Y"                   "fBodyGyro-mean()-Z"                   "fBodyGyro-std()-X"                   
[430] "fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"                    "fBodyGyro-mad()-X"                   
[433] "fBodyGyro-mad()-Y"                    "fBodyGyro-mad()-Z"                    "fBodyGyro-max()-X"                   
[436] "fBodyGyro-max()-Y"                    "fBodyGyro-max()-Z"                    "fBodyGyro-min()-X"                   
[439] "fBodyGyro-min()-Y"                    "fBodyGyro-min()-Z"                    "fBodyGyro-sma()"                     
[442] "fBodyGyro-energy()-X"                 "fBodyGyro-energy()-Y"                 "fBodyGyro-energy()-Z"                
[445] "fBodyGyro-iqr()-X"                    "fBodyGyro-iqr()-Y"                    "fBodyGyro-iqr()-Z"                   
[448] "fBodyGyro-entropy()-X"                "fBodyGyro-entropy()-Y"                "fBodyGyro-entropy()-Z"               
[451] "fBodyGyro-maxInds-X"                  "fBodyGyro-maxInds-Y"                  "fBodyGyro-maxInds-Z"                 
[454] "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"              
[457] "fBodyGyro-skewness()-X"               "fBodyGyro-kurtosis()-X"               "fBodyGyro-skewness()-Y"              
[460] "fBodyGyro-kurtosis()-Y"               "fBodyGyro-skewness()-Z"               "fBodyGyro-kurtosis()-Z"              
[463] "fBodyGyro-bandsEnergy()-1,8"          "fBodyGyro-bandsEnergy()-9,16"         "fBodyGyro-bandsEnergy()-17,24"       
[466] "fBodyGyro-bandsEnergy()-25,32"        "fBodyGyro-bandsEnergy()-33,40"        "fBodyGyro-bandsEnergy()-41,48"       
[469] "fBodyGyro-bandsEnergy()-49,56"        "fBodyGyro-bandsEnergy()-57,64"        "fBodyGyro-bandsEnergy()-1,16"        
[472] "fBodyGyro-bandsEnergy()-17,32"        "fBodyGyro-bandsEnergy()-33,48"        "fBodyGyro-bandsEnergy()-49,64"       
[475] "fBodyGyro-bandsEnergy()-1,24"         "fBodyGyro-bandsEnergy()-25,48"        "fBodyGyro-bandsEnergy()-1,8"         
[478] "fBodyGyro-bandsEnergy()-9,16"         "fBodyGyro-bandsEnergy()-17,24"        "fBodyGyro-bandsEnergy()-25,32"       
[481] "fBodyGyro-bandsEnergy()-33,40"        "fBodyGyro-bandsEnergy()-41,48"        "fBodyGyro-bandsEnergy()-49,56"       
[484] "fBodyGyro-bandsEnergy()-57,64"        "fBodyGyro-bandsEnergy()-1,16"         "fBodyGyro-bandsEnergy()-17,32"       
[487] "fBodyGyro-bandsEnergy()-33,48"        "fBodyGyro-bandsEnergy()-49,64"        "fBodyGyro-bandsEnergy()-1,24"        
[490] "fBodyGyro-bandsEnergy()-25,48"        "fBodyGyro-bandsEnergy()-1,8"          "fBodyGyro-bandsEnergy()-9,16"        
[493] "fBodyGyro-bandsEnergy()-17,24"        "fBodyGyro-bandsEnergy()-25,32"        "fBodyGyro-bandsEnergy()-33,40"       
[496] "fBodyGyro-bandsEnergy()-41,48"        "fBodyGyro-bandsEnergy()-49,56"        "fBodyGyro-bandsEnergy()-57,64"       
[499] "fBodyGyro-bandsEnergy()-1,16"         "fBodyGyro-bandsEnergy()-17,32"        "fBodyGyro-bandsEnergy()-33,48"       
[502] "fBodyGyro-bandsEnergy()-49,64"        "fBodyGyro-bandsEnergy()-1,24"         "fBodyGyro-bandsEnergy()-25,48"       
[505] "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                    "fBodyAccMag-mad()"                   
[508] "fBodyAccMag-max()"                    "fBodyAccMag-min()"                    "fBodyAccMag-sma()"                   
[511] "fBodyAccMag-energy()"                 "fBodyAccMag-iqr()"                    "fBodyAccMag-entropy()"               
[514] "fBodyAccMag-maxInds"                  "fBodyAccMag-meanFreq()"               "fBodyAccMag-skewness()"              
[517] "fBodyAccMag-kurtosis()"               "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-std()"           
[520] "fBodyBodyAccJerkMag-mad()"            "fBodyBodyAccJerkMag-max()"            "fBodyBodyAccJerkMag-min()"           
[523] "fBodyBodyAccJerkMag-sma()"            "fBodyBodyAccJerkMag-energy()"         "fBodyBodyAccJerkMag-iqr()"           
[526] "fBodyBodyAccJerkMag-entropy()"        "fBodyBodyAccJerkMag-maxInds"          "fBodyBodyAccJerkMag-meanFreq()"      
[529] "fBodyBodyAccJerkMag-skewness()"       "fBodyBodyAccJerkMag-kurtosis()"       "fBodyBodyGyroMag-mean()"             
[532] "fBodyBodyGyroMag-std()"               "fBodyBodyGyroMag-mad()"               "fBodyBodyGyroMag-max()"              
[535] "fBodyBodyGyroMag-min()"               "fBodyBodyGyroMag-sma()"               "fBodyBodyGyroMag-energy()"           
[538] "fBodyBodyGyroMag-iqr()"               "fBodyBodyGyroMag-entropy()"           "fBodyBodyGyroMag-maxInds"            
[541] "fBodyBodyGyroMag-meanFreq()"          "fBodyBodyGyroMag-skewness()"          "fBodyBodyGyroMag-kurtosis()"         
[544] "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"           "fBodyBodyGyroJerkMag-mad()"          
[547] "fBodyBodyGyroJerkMag-max()"           "fBodyBodyGyroJerkMag-min()"           "fBodyBodyGyroJerkMag-sma()"          
[550] "fBodyBodyGyroJerkMag-energy()"        "fBodyBodyGyroJerkMag-iqr()"           "fBodyBodyGyroJerkMag-entropy()"      
[553] "fBodyBodyGyroJerkMag-maxInds"         "fBodyBodyGyroJerkMag-meanFreq()"      "fBodyBodyGyroJerkMag-skewness()"     
[556] "fBodyBodyGyroJerkMag-kurtosis()"      "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"  
> [559] "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)"         
> [562] "angle(Y,gravityMean)"                 "angle(Z,gravityMean)"                 "activity.desc"  

Col Number | Column Name | Description
---------- | ----------- | -----------
1 | student.no | numeric reference to the student from whom the readings were sourced  
2 | activity.ref | numeric reference to the type of activity measured
3 | activity.desc | textual description of the activity
4 - 562 | | See the supplied file __./features_info.txt__ for column description   
  
List: **means**
-------------------------

The mean of fields have have mean() in their name.

```
str(means)
```
>List of 1  
> $ : Named num [1:33] 0.27435 -0.01774 -0.10893 0.66923 0.00404 ...  
>  ..- attr(*, "names")= chr [1:33] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tGravityAcc-mean()-X" ... 



List: **std**
-------------------------

The standard deviation of fields have have std() in their name.

```
str(std)
```
>List of 1  
> $ : Named num [1:33] 0.4387 0.5002 0.4037 0.0777 0.0853 ...  
>  ..- attr(*, "names")= chr [1:33] "tBodyAcc-std()-X" "tBodyAcc-std()-Y" "tBodyAcc-std()-Z" "tGravityAcc-std()-X" ...  