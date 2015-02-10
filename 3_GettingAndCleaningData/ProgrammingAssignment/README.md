# GetData010
Course Project for Coursera Course "Getting and Cleaning Data"  
The folder contains:
* RawData - A folder having all the raw data for the project.
* run_analysis.R - The R Script that produces the result and output text file.
* run_analysis_Output.txt - The output text file containing final data.
* CodeBook.pdf - The Code book that explains the variable names.

The description of the **run_analysis.R** R script:  
1. The training and test data is read from respective folders.  
2. The *variable names* were updated according to the features.txt file.  
3. The *subject number* were added to the data frame according to the subject_test/train.txt file.  
4. The *activity names* were updated according to the activity_labels.txt file.  
5. Both the data sets were combined to form a large data set.  
6. The data was filtered to **data2** which contained only "-mean()" or "-std()" in their names.  
7. **data2** was aggregated to **finaldata** which is the independent tidy data set with the *average of each variable for each activity and each subject*.  
8. The **finaldata** was written into **run_analysis_Output.txt** file.  
*Comments in the code can help better.*
