
Code Book

• Downloaded file and unzip the file using code in R.
• Using read.table, read in the training, test data, sub_training, sub_test, activity labels and features files for the study, and store them into appropriately named variables. 
• Assigined columns name, using cbind merger x_train, y_train, sub_train and aslo all 3 test data set tables.
• Using rbind merged training and test data sets together and result into one overall merged dataset.
• As the objective of script is to retrieve means and standard deviations, used grep function to search the features for values containing "mean" or "sd" and created necessary subset.
• For descriptive variable names using merged function join activitylabels and subsetformeanandstd variable by activityID.
• Finally using aggregate function created second tidy data set and using write.table function created secondtidydata.txt.
