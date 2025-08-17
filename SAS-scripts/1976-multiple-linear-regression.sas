/* Homework 3 Question 1; problem 2.1 Part E on page 59 */
/* directly importing data from Excel; I converted the .xlsx file to a .csv file */
/* SAS deals with incomplete rows of data */
proc import datafile='/home/u63996162/STAT611/football.csv'
    out=football
    dbms=csv
    replace;
    getnames=yes;
run;

/* Proc reg with CLM to find 95% confidence limit around the mean */
proc reg data=football plots=none alpha=.05;
id x8;
model y=x8/p clm;
title 'Predicted Number of Games Won Using the LSR Equation';
run;

/* Homework 3 Question 2; problem 2.2 on page 59 */
/* Proc reg with CLI to find 90% confidence limit around an individual value */
proc reg data=football plots=none alpha=.1;
id x8;
model y=x8/p cli;
title 'Predicted Number of Games Won Using the LSR Equation';
run;

/* 3.1 multiple linear regression model relating team's passing yardage (x2),
percentage of rushing plays (x7), and opponent rushing yards (x8) */
proc reg data=football;
model y = x2 x7 x8;
title 'Multiple Linear Regression for Team Games Won';
run;

/* 3.3 part A, 95% CI on beta 7 */
proc reg data=football;
model y = x2 x7 x8 / clb;
title '95% Confidence Intervals for Slope Parameters';
run;

/* 3.3 part B, 95% CI on mean number of team games won (y) when  
team passing yards (x2) is 2300, team percentage of rushing plays (x7)
is 56.0, and opponent rushing yards (x8) is 2100*/

/* Create new data point with three new inputs */
data newData;
input x2 x7 x8;
datalines;
2300 56.0 2100
;
run;

/* Add new data point to original dataset */
data football;
set football newData;
run;
quit;

/* Run MLR model again, this time with 95% CI on mean number of team games won */
proc reg data=football;
model y = x2 x7 x8 / clm; 
title '95% Confidence Intervals for Mean Number of Team Games Won';
run;

/* 3.1 Part C on page 125; performing t test on beta 7 to compare to partial F test*/
proc reg data=football;
model y = x2 x7 x8;
title 'Multiple Linear Regression for Team Games Won';
run;

/* 3.1 Part E on page 125; partial F test on beta 7 */
proc glm data=football plots=diagnostics;
model y = x7 x2 x8;
run;