/* importing data from Excel; I converted the .xlsx file to a .csv file */
/* setting column names to match Excel file */
data football;
infile 'https://raw.githubusercontent.com/petecht66/nfl-games-won/refs/heads/main/data/1976%20NFL%20Games%20Won.csv' dlm = ',';
input y x1 x2 x3 x4 x5 x6 x7 x8 x9;
run;

/* run proc reg, make sure residuals are in output statement for all 3 parts */
/* also make sure predicted values are in output statement for 4.1 B */
proc reg data=football plots=none;
    model y = x8;
    output out=residuals predicted=predict residual=res;
run;

/* proc corr to find Pearson's correlation coefficient to check R-squared */
proc corr data=football pearson;
var x8 y;
title "Pearson's Linear Correlation Coefficient Between The Number of Yards";
title2 "Gained Rushing By Opponent and the Number of Games Won By a Team";
run;

/* 4.1 A; constructing a normal probability plot of the residuals */ 
proc univariate data=residuals;
    var res;
    probplot res / normal (mu=est sigma=est);
    title "Normal Probability Plot of Residuals";
run;

/* 4.1 B; graphing predicted games won values versus residuals */
proc sgplot data=residuals;
    scatter x=predict y=res;
    refline 0 / axis=y;
    title "Plot of Predicted Games Won Values Versus Residuals";
run;

/* 4.1 C; graphing team passing yards versus residuals */
proc sgplot data=residuals;
    scatter x=x2 y=res;
    refline 0 / axis=y;
    title "Plot of Team Passing Yards Versus Residuals";
    xaxis label = "Team Passing Yards";
run;