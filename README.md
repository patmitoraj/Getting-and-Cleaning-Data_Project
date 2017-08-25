# Getting-and-Cleaning-Data_Project
## Data Summary
All data comed from the "Human Activity Recognition Using Smartphone Dataset". The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The dataset consists of the following files:

**'README.txt'**

**'features_info.txt'**: Shows information about the variables used on the feature vector.

**'features.txt'**: List of all features.

**'activity_labels.txt'**: Links the class labels with their activity name.

**'train/X_train.txt'**: Training set.

**'train/y_train.txt'**: Training labels.

**'test/X_test.txt'**: Test set.

**'test/y_test.txt'**: Test labels.

## run_analysis.R
The purpose of the 'run_analysis.R' file is to combine the training and test datasets from the data and create a tidy dataset. The script accomplishes these goals by: 

**1)** Applying the column headers in the 'features.txt' file to both the train and test datasets.

**2)** Adding both the the subjects and activitys datasets to the train and test datasets.

**3)** Combining the train and test datasets by using the 'rbind' function. This creates one dataframe with the data from both sets.

**4)** The script then extracts only those columns that have measure the mean or the standard deviation of a variable. This is done using the 'select' function from the dplyr package.

**5)** The numeric values in the 'Activitys' column are replaced with descriptive string values. These values describe the activity the subject was doing when the measurements were taken.

**6)** Descriptive column headers are applied tp the combined dataset, making it clear what the values in the column represent.

**7)** A new, tidy dataset is created with the average of each variable for each activity and each subject. This is dones using the groupby function, so that there is a separate row for each combination of subject and activity.

## codebook.md
The codebook has a description of each of the variables in the tidy dataset.
