# The Data Transformation
The tidying of this data took a total of 8 steps:
1. First I imported all of the un-tidy data that would be needed `(features.txt, X_test.txt, y_test.txt, subject_test.txt, X_train.txt, y_train.txt, subject_train.txt)`
2. I added the feature names to both the `x_test` and `x_train` data.
3. I added the `activity` and `subject` variables (columns) to the `x_test` and `y_train` data.
4. I combinied the `x_test` and `x_train` data into a single dataset and called this dataset `tidy_data`.
5. I filtered out all columns  except for `subject`, `activity` and any column that contained "mean()" or "std()." Here, I also changed the activity labels to strings (they were previously coded as numbers)
6. I tidyed all of the column names by changing abreviations to their full names, (Ex: "Acc" to "Acceleration"). I also removed any spaces `" "`, parentheses `()` and numbers `0-9` from the column names.
7. I created a second tidy dataset called `summarized_tidy_data` which is just the `tidy_data` that took the mean of each variable by subject and activity.
8. I removed all outdated (unneeded) variables from the environment so that we are left with only `tidy_data` and `summarized_tidy_data`


# The Variables and the Data
After running the `run_analysis.R` script you will be left with two tidy pieces of data. The first is called `tidy_data`. This data frame is our core piece of tidy data. It contains three types of variables:

### 1. The subject variable
This variable is an integer and simply identifies the unique id of the person who is performing the movement test. There were 30 total subjects, so the ids range from a minimum of 1 to a maximum of 30.

### 2. The activity variable
This variable type is a character and represents what activity the subject was doing during each particular observation. There are a total of 6 different activities in the data set. They include "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", and "LAYING."

### 3. The movement variables
The rest of the dataset consists of the movement data that was picked up by the sensors. For our tidy data, filtered down the data to only include sensor data that measured the mean of different activities. The sensors used during this experiment included an accelerometer, and a gyroscope. So variable names that have "acceleration" in the name come from the accelerometer data. Variables that have "gyro" in the name come from the gyroscope. Variables with the name "jerk" in them are variables that were derived from the acceleration measurements and the angular velocity measurements. Furthermore, many of the variables were measured in three dimensions (X, Y, Z) and in all relevant cases the dimension that was measured is appended to the end of the variable name. Finally, these variables are prepended with either a "t" or an "f." The "t" prefix means that this variable denotes time and the "f" prefix means that this is a frequency domain variable. The "t" or "f" is then followed by either "Body" or "Gravity". This describes _what_ was being measured for the variable.

*** The second piece of data is called `summarized_tidy_data` and that contains all of the variables described above EXCEPT this piece of data shows the average of each variable, grouped by subject and activity.