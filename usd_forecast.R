# Loading libraries
library(tidyverse)
library(readr)
library(data.table)
library(forecast)
library(tseries)

# Loading the forex data 
fx <- read_csv("forexKE2016_2025.csv") |> data.table()

# EDA
View(fx);glimpse(fx)
sum(is.na(fx)) # no missing values
fx[duplicated(fx),] # no duplicates


# Filtering USD currency
usd <- fx |> 
  filter(currency == "US DOLLAR")

# EDA
glimpse(usd) # 2,114 rates from 1st December 2016 upto 13th June 2025 

# Generating Time-Series data structures
usd.ts <- data.table("period" = seq(1, nrow(usd), 1),
                     "date" = usd$date,
                     "rate" = usd$rate)

# Training set
usd_train <- usd.ts[c(1:(0.75*nrow(usd))), 3] |> ts()

# Testing set
usd_test <- usd.ts[c((nrow(usd_train)+1):nrow(usd)), 3] |> ts()


# Fitting the model
model <- auto.arima(usd_train) # ARIMA(1,2,1)

about_model <- model |> summary()

# Checking the model components p and q
## ACF
# The model has been differenced twice.
diff(usd_train, differences = 2) |> acf()

## PACF
diff(usd_train, differences = 2) |> pacf()

## Residual analysis
plot(x=about_model$residuals, pch=".",las=1, # visualizing residuals
     xlab = "Time", ylab = "Residuals", las = 1, main = "Residuals plot")

checkresiduals(about_model$residuals, plot = FALSE) |> pander::pander() # Box.L test independence test

