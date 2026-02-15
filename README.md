# Human Activity Recognition - Data Cleaning Project

## Overview
This project demonstrates the cleaning and tidying of the UCI HAR Dataset, which contains accelerometer and gyroscope measurements from Samsung Galaxy S smartphones for 30 subjects performing six different activities.

## Files in the Repository
- `run_analysis.R` - Main R script for cleaning and tidying data
- `tidy_data.txt` - The final tidy dataset with averages for each variable by subject and activity
- `CodeBook.md` - Describes variables, transformations, and dataset details

## How to run the analysis
1. Clone the repository.
2. Open R or RStudio.
3. Set your working directory to the project folder (optional in the script).
4. Run the script `run_analysis.R`.
5. After execution, `tidy_data.txt` will be created in the project directory.

## Notes
- The script downloads the dataset if it is not present.
- Uses `dplyr` for data manipulation.
