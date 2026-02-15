# CodeBook

## Data
The dataset comes from the UCI HAR Dataset:
- 30 subjects performed six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
- Measurements include accelerometer and gyroscope signals

## Variables
- `subject` : Integer, subject ID (1-30)
- `activity` : Factor, activity name
- Other variables: TimeDomain or FrequencyDomain measurements of mean and standard deviation for each signal

## Transformations
1. Combined training and test datasets
2. Extracted only mean() and std() measurements
3. Replaced activity numbers with descriptive names
4. Renamed variables to descriptive names
5. Created tidy dataset with averages for each variable grouped by subject and activity
