library(dplyr)
library(tidyr)
library(readr)

# Import feature names, training data and test data
# feature_names <- read_delim('./dataset/features.txt', " ", col_names = F)
feature_names <- read_table('./dataset/features.txt', col_names = F)
x_test <- read_table('./dataset/test/X_test.txt', col_names = F)
y_test <- read_table('./dataset/test/y_test.txt', col_names = F)
x_train <- read_table('./dataset/train/X_train.txt', col_names = F)
y_train <- read_table('./dataset/train/y_train.txt', col_names = F)

# Add feature names to each dataset
names(x_test) <- feature_names$X1
names(x_train) <- feature_names$X1

# Add activity variables
x_test$activity <- y_test$X1
x_train$activity <- y_train$X1

x_test <- x_test %>%
  select(activity, contains('mean()'), contains('std()')) %>%
  mutate(activity = case_when(
    activity == 1 ~ 'WALKING',
    activity == 2 ~ 'WALKING_UPSTAIRS',
    activity == 3 ~ 'WALKING_DOWNSTAIRS',
    activity == 4 ~ 'SITTING',
    activity == 5 ~ 'STANDING',
    activity == 6 ~ 'LAYING'
  ))

# Tidy column names
names(x_test) <- gsub(x = names(x_test), pattern = ' ', replacement = '')
names(x_test) <- gsub(x = names(x_test), pattern = '\\(\\)', replacement = '')
names(x_test) <- gsub(x = names(x_test), pattern = '[0-9]', replacement = '')
names(x_test) <- gsub(x = names(x_test), pattern = 'Acc', replacement = 'Acceleration')
names(x_test) <- gsub(x = names(x_test), pattern = 'Mag', replacement = 'Magnitude')
names(x_test) <- gsub(x = names(x_test), pattern = 'mean', replacement = 'Mean')
names(x_test) <- gsub(x = names(x_test), pattern = 'std', replacement = 'Std')







