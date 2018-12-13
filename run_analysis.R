library(tidyr)
library(readr)

# Import feature names, training data and test data
feature_names <- read_delim('./dataset/features.txt', " ", col_names = F)
x_test <- read_table('./dataset/test/X_test.txt', col_names = F)
x_train <- read_table('./dataset/train/X_train.txt', col_names = F)

# Add feature names to each dataset
names(x_test) <- feature_names$X2
names(x_train) <- feature_names$X2