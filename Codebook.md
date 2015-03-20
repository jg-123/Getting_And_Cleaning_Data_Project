Code Book 
==========
##### For the Coursera Getting and Cleaning Data Course Project

# Original UCI Dataset Download Location
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Original Dataset Description
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Data Processing Done by run_analysis.R

"run_analysis.R" (https://github.com/jg-123/Getting_And_Cleaning_Data_Project/blob/master/run_analysis.R) uses the following steps are used to clean, merge, transform, and tidy the data for the final dataset provided for this project (tidy_dataset.txt):

1) Merges the training and test data from the UCI dataset to create a single dataset. This is done by binding the rows together in R using rbind on the data from the following files:
  * X_train.txt and X_test.txt
  * y_train.txt and y_test.txt
  * subject_train.txt and subject_test.txt
   
2) Finds all feature names from the features.txt file that have the terms "mean", "std", "Mean", and "Std" in them and then extracts the corresponding columns from the combined X train/test data. When taking into account upper and lowercase appearances of these strings, 88 columns are extracted. This number will vary in other projects depending upon implementation.

3) Cleans up the activity labels from activity_lables.txt by removing underscores and converting to lowercase, then replaces the combined y test/train data column containing the activity number with the appropriate activity string as follows:
  * 1: walking
  * 2: walkingupstairs
  * 3: walkingdownstairs
  * 4: sitting
  * 5: standing
  * 6: laying
	
4) Renames data columns to values that make sense:
  * y data - "activity" 
  * subject data - "subject"
  * X data - finds corresponding feature names from features.txt and sets these as the column names for the X test/train data, removing parentheses, commas and converting all characters to lowercase
	
5) Combines all 3 sets of data X train/test, y train/test, and subject train/test into a single data frame using the cbind() command in R. This dataset is 10299 observations of 88 variables.

6) Using this newly combined dataset, the R script then counts each unique subject and activity and creates a new data frame with a row for each unique combination resulting in 180 rows in the tidy dataset (30 subjects x 6 activities = 180 rows).

7) The script then loops through each row in the tidy set and finds the corresponding rows in the mean and standard deviation reduced dataset created in step 5 that have the same subject and activity, and finds the mean value of all other features (in this case "mean" and "std" features) with that subject/activity combination. This mean value is then entered as the value for that feature in the tidy dataset.

8) The final tidy dataset is output to a text file using the write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE) command, resulting in a 180 x 88 data set that can be read in using read.table() in R.

### Data Description for Data Found in Tidy Dataset (88 variables)

* **"subject"**  - test subject, number from 1-30
* **"activity"** - activity the subject was performing during measurements (WALKING, SITTING, LAYING, etc.)
* **"tbodyacc-mean-x"** - mean of time domain body acceleration in the x direction 
* **"tbodyacc-mean-y"** - mean of time domain body acceleration in the y direction 
* **"tbodyacc-mean-z"** - mean of time domain body acceleration in the z direction 
* **"tbodyacc-std-x"** - standard deviation of time domain body acceleration in the x direction
* **"tbodyacc-std-y"** - standard deviation of time domain body acceleration in the y direction
* **"tbodyacc-std-z"** - standard deviation of time domain body acceleration in the z direction
* **"tgravityacc-mean-x"** - mean of time domain gravity acceleration in the x direction 
* **"tgravityacc-mean-y"** - mean of time domain gravity acceleration in the y direction 
* **"tgravityacc-mean-z"** - mean of time domain gravity acceleration in the z direction 
* **"tgravityacc-std-x"** - standard deviation of time domain gravity acceleration in the x direction
* **"tgravityacc-std-y"** - standard deviation of time domain gravity acceleration in the y direction
* **"tgravityacc-std-z"** - standard deviation of time domain gravity acceleration in the z direction
* **"tbodyaccjerk-mean-x"** - mean of time domain body acceleration jerk in the x direction
* **"tbodyaccjerk-mean-y"** - mean of time domain body acceleration jerk in the y direction
* **"tbodyaccjerk-mean-z"** - mean of time domain body acceleration jerk in the z direction
* **"tbodyaccjerk-std-x"** - standard deviation of time domain body acceleration jerk in the x direction
* **"tbodyaccjerk-std-y"** - standard deviation of time domain body acceleration jerk in the y direction
* **"tbodyaccjerk-std-z"** - standard deviation of time domain body acceleration jerk in the z direction
* **"tbodygyro-mean-x"** - mean of time domain body gyroscope in the x direction
* **"tbodygyro-mean-y"** - mean of time domain body gyroscope in the y direction
* **"tbodygyro-mean-z"** - mean of time domain body gyroscope in the z direction
* **"tbodygyro-std-x"** - standard deviation of time domain body gyroscope in the x direction
* **"tbodygyro-std-y"** - standard deviation of time domain body gyroscope in the y direction
* **"tbodygyro-std-z"** - standard deviation of time domain body gyroscope in the z direction
* **"tbodygyrojerk-mean-x"** - mean of time domain body gyroscope jerk in the x direction
* **"tbodygyrojerk-mean-y"** - mean of time domain body gyroscope jerk in the y direction
* **"tbodygyrojerk-mean-z"** - mean of time domain body gyroscope jerk in the z direction
* **"tbodygyrojerk-std-x"** - standard deviation of time domain body gyroscope jerk in the x direction
* **"tbodygyrojerk-std-y"** - standard deviation of time domain body gyroscope jerk in the y direction
* **"tbodygyrojerk-std-z"** - standard deviation of time domain body gyroscope jerk in the z direction
* **"tbodyaccmag-mean"** - mean of time domain body acceleration total magnitude 
* **"tbodyaccmag-std"** - standard deviation of time domain body acceleration total magnitude 
* **"tgravityaccmag-mean"** - mean of time domain gravity acceleration total magnitude 
* **"tgravityaccmag-std"** - standard deviation of time domain gravity acceleration total magnitude 
* **"tbodyaccjerkmag-mean"** - mean of time domain body acceleration jerk total magnitude 
* **"tbodyaccjerkmag-std"** - standard deviation of time domain body acceleration jerk total magnitude
* **"tbodygyromag-mean"** - mean of time domain body gyroscope total magnitude
* **"tbodygyromag-std"** - standard deviation of time domain body gyroscope total magnitude
* **"tbodygyrojerkmag-mean"** - mean of time domain body gyroscope jerk total magnitude
* **"tbodygyrojerkmag-std"** - standard deviation of time domain body gyroscope jerk total magnitude
* **"fbodyacc-mean-x"** - mean of frequency domain (fast fourier transform) body acceleration in the x direction
* **"fbodyacc-mean-y"** - mean of frequency domain (fast fourier transform) body acceleration in the y direction
* **"fbodyacc-mean-z"** - mean of frequency domain (fast fourier transform) body acceleration in the z direction
* **"fbodyacc-std-x"** - standard deviation of frequency domain (fast fourier transform) body acceleration in the x direction
* **"fbodyacc-std-y"** - standard deviation of frequency domain (fast fourier transform) body acceleration in the y direction
* **"fbodyacc-std-z"** - standard deviation of frequency domain (fast fourier transform) body acceleration in the z direction
* **"fbodyacc-meanfreq-x"** - weighted average of the frequency components to obtain a mean frequency of body acceleration in the x direction
* **"fbodyacc-meanfreq-y"** - weighted average of the frequency components to obtain a mean frequency of body acceleration in the y direction
* **"fbodyacc-meanfreq-z"** - weighted average of the frequency components to obtain a mean frequency of body acceleration in the z direction
* **"fbodyaccjerk-mean-x"** - mean of frequency domain (fast fourier transform) body acceleration jerk in the x direction
* **"fbodyaccjerk-mean-y"** - mean of frequency domain (fast fourier transform) body acceleration jerk in the x direction
* **"fbodyaccjerk-mean-z"** - mean of frequency domain (fast fourier transform) body acceleration jerk in the x direction
* **"fbodyaccjerk-std-x"** - standard deviation of frequency domain (fast fourier transform) body acceleration jerk in the x direction
* **"fbodyaccjerk-std-y"** - standard deviation of frequency domain (fast fourier transform) body acceleration jerk in the y direction
* **"fbodyaccjerk-std-z"** - standard deviation of frequency domain (fast fourier transform) body acceleration jerk in the z direction
* **"fbodyaccjerk-meanfreq-x"** - weighted average of the frequency components to obtain a mean frequency of body acceleration jerk in the x direction
* **"fbodyaccjerk-meanfreq-y"** - weighted average of the frequency components to obtain a mean frequency of body acceleration jerk in the y direction
* **"fbodyaccjerk-meanfreq-z"** - weighted average of the frequency components to obtain a mean frequency of body acceleration jerk in the z direction
* **"fbodygyro-mean-x"** - mean of frequency domain (fast fourier transform) body gyroscope in the x direction
* **"fbodygyro-mean-y"** - mean of frequency domain (fast fourier transform) body gyroscope in the y direction
* **"fbodygyro-mean-z"** - mean of frequency domain (fast fourier transform) body gyroscope in the z direction
* **"fbodygyro-std-x"** - standard deviation of frequency domain (fast fourier transform) body gyroscope in the x direction
* **"fbodygyro-std-y"** - standard deviation of frequency domain (fast fourier transform) body gyroscope in the y direction
* **"fbodygyro-std-z"** - standard deviation of frequency domain (fast fourier transform) body gyroscope in the z direction
* **"fbodygyro-meanfreq-x"** - weighted average of the frequency components to obtain a mean frequency of body gyroscope in the x direction
* **"fbodygyro-meanfreq-y"** - weighted average of the frequency components to obtain a mean frequency of body gyroscope in the y direction
* **"fbodygyro-meanfreq-z"** - weighted average of the frequency components to obtain a mean frequency of body gyroscope in the z direction
* **"fbodyaccmag-mean"** - mean of frequency domain (fast fourier transform) body acceleration total magnitude
* **"fbodyaccmag-std"** - standard deviation of frequency domain (fast fourier transform) body acceleration total magnitude
* **"fbodyaccmag-meanfreq"** - weighted average of the frequency components to obtain a mean frequency of body acceleration total magnitude
* **"fbodybodyaccjerkmag-mean"** - mean of frequency domain (fast fourier transform) body acceleration jerk total magnitude
* **"fbodybodyaccjerkmag-std"** - standard deviation of frequency domain (fast fourier transform) body acceleration jerk total magnitude
* **"fbodybodyaccjerkmag-meanfreq"** - weighted average of the frequency components to obtain a mean frequency of body acceleration jerk total magnitude
* **"fbodybodygyromag-mean"** - mean of frequency domain (fast fourier transform) body gyroscope total magnitude
* **"fbodybodygyromag-std"** - standard deviation of frequency domain (fast fourier transform) body gyroscope total magnitude
* **"fbodybodygyromag-meanfreq"** - weighted average of the frequency components to obtain a mean frequency of body gyroscope total magnitude
* **"fbodybodygyrojerkmag-mean"** - mean of frequency domain (fast fourier transform) body gyroscope jerk total magnitude
* **"fbodybodygyrojerkmag-std"** - standard deviation of frequency domain (fast fourier transform) body gyroscope jerk total magnitude
* **"fbodybodygyrojerkmag-meanfreq"** - weighted average of the frequency components to obtain a mean frequency of body gyroscope jerk total magnitude
* **"angletbodyaccmean-gravity"** - angle between mean body acceleration and gravity
* **"angletbodyaccjerkmean-gravitymean"** - angle between mean body acceleration jerk and mean gravity
* **"angletbodygyromean-gravitymean"** - angle between mean body gyroscope and mean gravity
* **"angletbodygyrojerkmean-gravitymean"** - angle between mean body gyroscope jerk and mean gravity
* **"anglex-gravitymean"** - obtained by averaging the signals in a signal window sample
* **"angley-gravitymean"** - obtained by averaging the signals in a signal window sample
* **"anglez-gravitymean"** - obtained by averaging the signals in a signal window sample