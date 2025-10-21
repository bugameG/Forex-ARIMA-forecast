# Forex-ARIMA-forecast 💹
## Objective
This project sets out to forecasting foreign exchange rates for the `US Dollar` against the `Kenyan Shilling`. 

## Methodology
I chose the ARIMA model to forecast the rates due to its high predictive performance .The first step was to assemble forex data from the Central Bank of Kenya website [here](https://www.centralbank.go.ke/forex/). R version 4.4.0 was used to clean and transform the data for model building. The assembly and cleaning codes are found in the `forex.R` script within this repo. For the model I use daily reported rates spanning over 8 years from 1st December to 13th June 2025. I split the data into a training set running from 1st December 2016 upto 25th April 2023 and a testing set from 26th April 2023 upto 13th June 2025 each having 1585 and 529 observations respectively. ARIMA(1,2,1) model was the optimal model chosen.  

## Analysis
Some of the core libraries used are
[]()
[]()
[]()
Model evaluation results are found in `usd_forecast_doc.pdf`.

## Findings & Recommendations
Forex data is non-stationary in nature. Therefore in order to fit ARIMA models, there is need to check for stationarity before building. ARIMA models have good predictive metrics required for forecasting models. In conclusion other models can be employed in the forecasting domain such as GARCH and Facebook's prophet model.  

 
