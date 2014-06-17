CodeBook for Assignment on Course Module Getting and Cleaning Data
==================================================================

Introduction
------------

Taken from the file __README.txt__ that came with the data that was analysed 
>*"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."*

Source Data
-----------

The source data was in a zip file the contents of which where extracted into a folder called __UCI HAR Dataset__ retaining any embedded sub directories.

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

Design Decision
---------------

### Saving produced data

Given the static nature of the data (a downloaded zip file) it was decided that once the data tiding process and completed and the required information was generated, the resulting data would be saved in a folder __./data__. This would ensure that subsequent analysis would skip over the processing part and return to the data scients the pre-computed data.

The user would be prompted (if a pre-computed data file is found) whether he would like to use that data or recompute everything from scratch.

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

Generating the tidy data
------------------------

1 The first stage was to read in the [activity (__./activity_labels.txt__) data][ref1] and split the data on the space separating the integer from the description.  
**_Tidy Data: The description was converted from block letters to Proper case_**

2 The row headings for the various readings was read and a character vector was generated
and features (__./features.txt__) data. 

3 Given the naming convention used by the authors of the study, it was possible to use the same module to process both the training and test data based upon a parameter passed to the module. For the purposes of this document, the files related to the training data will be used.

 *  The subjects who participated in the analysis were read from (__./train/subject_train.txt__). There was one row for every record.   
**_Tidy Data: The column name student.no was added to the processed information_**  

 * The activity list was read from (__./train/y_train.txt__). The data here was an integer. There was one row for every record. 
**_Tidy Data: Another second column was added to the read data that cross referenced the integer with the corresponding description ([ref1]: see point 1)_**  


```{r}
summary(cars)
```

You can also embed plots, for example:

```{r fig.width=7, fig.height=6}
plot(cars)
```

