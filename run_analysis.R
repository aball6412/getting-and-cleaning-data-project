library(dplyr)
library(tidyr)
library(readr)

# Import feature names, training, test, and subject data
feature_names <- read_table('./dataset/features.txt', col_names = F)
x_test <- read_table('./dataset/test/X_test.txt', col_names = F)
y_test <- read_table('./dataset/test/y_test.txt', col_names = F)
sub_test <- read_table('./dataset/test/subject_test.txt', col_names = F)
x_train <- read_table('./dataset/train/X_train.txt', col_names = F)
y_train <- read_table('./dataset/train/y_train.txt', col_names = F)
sub_train <- read_table('./dataset/train/subject_train.txt', col_names = F)

# Add feature names to each dataset
names(x_test) <- feature_names$X1
names(x_train) <- feature_names$X1

# Add activity and subject variables
x_test$activity <- y_test$X1
x_test$subject <- sub_test$X1
x_train$activity <- y_train$X1
x_train$subject <- sub_train$X1

# Bind the training and test sets together
tidy_data <- bind_rows(x_test, x_train)

# Filter out un-wanted columns and format activity column
tidy_data <- tidy_data %>%
  select(subject, activity, contains('mean()'), contains('std()')) %>%
  mutate(activity = case_when(
    activity == 1 ~ 'WALKING',
    activity == 2 ~ 'WALKING_UPSTAIRS',
    activity == 3 ~ 'WALKING_DOWNSTAIRS',
    activity == 4 ~ 'SITTING',
    activity == 5 ~ 'STANDING',
    activity == 6 ~ 'LAYING'
  ))

# Tidy column names
names(tidy_data) <- gsub(x = names(tidy_data), pattern = '(\\s)|(\\(\\))|[0-9]', replacement = '')
names(tidy_data) <- gsub(x = names(tidy_data), pattern = 'Acc', replacement = 'Acceleration')
names(tidy_data) <- gsub(x = names(tidy_data), pattern = 'Mag', replacement = 'Magnitude')
names(tidy_data) <- gsub(x = names(tidy_data), pattern = 'mean', replacement = 'Mean')
names(tidy_data) <- gsub(x = names(tidy_data), pattern = 'std', replacement = 'Std')

# Create separate tidy data that averages each variable by subject and activity
summarized_tidy_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarize_all(mean)

# Remove unneeded variables
remove(list = c('feature_names', 'sub_test', 'sub_train', 'x_test', 'x_train', 'y_test', 'y_train'))
write.table(tidy_data, file = 'tidy-data.txt', row.names = F)