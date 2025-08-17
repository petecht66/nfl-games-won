/* importing data from Excel; I converted the .xlsx file to a .csv file */
/* setting column names to match Excel file */
data football;
infile 'https://raw.githubusercontent.com/petecht66/nfl-games-won/refs/heads/main/data/1976%20NFL%20Games%20Won.csv' dlm = ',';
input y x1 x2 x3 x4 x5 x6 x7 x8 x9;
run;

/* proc reg to perform the simple linear regression model between x8 and y */
/* plots turned off for organization */
proc reg data=football plots=none;
model y = x8;
title 'Simple Linear Regression Estimates for Least Squares Regression Equation';
run;

/* proc corr to find Pearson's correlation coefficient to check R-squared */
proc corr data=football pearson;
var x8 y;
title "Pearson's Linear Correlation Coefficient Between The Number of Yards";
title2 "Gained Rushing By Opponent and the Number of Games Won By a Team";
run;