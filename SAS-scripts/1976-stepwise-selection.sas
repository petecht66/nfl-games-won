/* importing data from Excel; I converted the .xlsx file to a .csv file */
/* setting column names to match Excel file */
data football;
infile '/home/u63996162/STAT611/football.csv' dlm = ',' firstobs=2;
input y x1 x2 x3 x4 x5 x6 x7 x8 x9;
run;

/* selection step limited to just x1, x2, x4, x7, x8, x9 */
/* table should include cp, adjusted R-squared, and mean square residual */
/* output predicted and residuals, which SAS does for top model listed */
proc reg data=football;
model y = x1 x2 x4 x7 x8 x9 / selection = cp rsquare adjrsq mse;
output out=residuals predicted=predict residual=res;
run;

/* beginning of residual analysis; normal probability plot of residuals */
proc univariate data=residuals;
    var res;
    probplot res / normal (mu=est sigma=est);
    title "Normal Probability Plot of Residuals";
run;

/* running the recommended model from SAS */
/* predicted and residuals match above step */
/* including diagnostic tests, which shows predicted versus predictor variables */
proc reg data=football plots=diagnostics;
model y = x2 x7 x8;
output out=residuals predicted=predict residual=res;
run;

/* second normal probability plot; matches NPP from above */
proc univariate data=residuals;
    var res;
    probplot res / normal (mu=est sigma=est);
    title "Normal Probability Plot of Residuals";
run;

/* scatter plot of predicted versus residuals for constant variance test */
proc sgplot data=residuals;
    scatter x=predict y=res;
    refline 0 / axis=y;
    title "Plot of Predicted Values Versus Residuals";
run;

data residuals_time;
   set residuals;
   obs_number + 1;  /* creates a time-like variable starting at 1 */
run;

/* scatter plot of residuals versus the time that they come in */
proc sgplot data=residuals_time;
    scatter x=obs_number y=res;
    refline 0 / axis=y;
    title "Independence of Errors Test";
run;