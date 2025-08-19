
# R packages needed for this script
library(ggplot2)
library(olsrr)

# importing 2024 NFL regular season data set from main branch on GitHub
regular_season_2024 <- read.csv("https://raw.githubusercontent.com/petecht66/nfl-games-won/refs/heads/main/data/2024%20NFL%20Games%20Won.csv")

# the initial full multiple linear regression model with all predictor variables considered
full_MLR_model <- lm(Wins ~ RushYds + PassYds + PuntAvg + FG. + TO. + PenaltyYds + Rush. + OppRushYds + OppPassYds, data = regular_season_2024)

# stepwise selection model that removes NFL game factors if they are not considered statistically significant
ols_step_best_subset(full_MLR_model) # Mallow's Cp for criteria