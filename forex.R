# LOADING LIBRARIES
library(tidyverse)
library(readr)

# READING DATASETS FROM WD
## 2005-2015 DATA
forex5 = read_csv("Key-CBK-Indicative-Exchange-Rates-2005.csv")
forex6 = read_csv("Key-CBK-Indicative-Exchange-Rates-2006.csv")
forex7 = read_csv("Key-CBK-Indicative-Exchange-Rates-2007.csv")
forex8 = read_csv("Key-CBK-Indicative-Exchange-Rates-2008.csv")
forex9 = read_csv("Key-CBK-Indicative-Exchange-Rates-2009.csv")
forex10 = read_csv("Key-CBK-Indicative-Exchange-Rates-2010.csv")
forex11 = read_csv("Key-CBK-Indicative-Exchange-Rates-2011.csv")
forex12 = read_csv("Key-CBK-Indicative-Exchange-Rates-2012.csv")
forex13 = read_csv("Key-CBK-Indicative-Exchange-Rates-2013.csv")
forex14 = read_csv("Key-CBK-Indicative-Exchange-Rates-2014.csv")
forex15 = read_csv("Key-CBK-Indicative-Exchange-Rates-2015.csv")


## MERGING FOREX DATA (2005-2016)
fx5to15=bind_rows(forex5,forex6,forex7,forex8,forex9,
                  forex10,forex11,forex12,forex13,forex14,forex15)

## CLEANING 2005 TO 2015 FOREX DATA
# A.Removing duplicates
fx5to15 = fx5to15[!duplicated(fx5to15),] # 583 duplicates removed

# B.Date
fx5to15$Date <- dmy(fx5to15$Date)

# C.SELECTING THE AVERAGE INDICATIVE RATE
fx5to15 <- fx5to15 |> 
  select(-Buy, -Sell) |> 
  rename("Rate" = Mean)

# D.Currency
## a.KES TO KSH
fx5to15$Currency <- fx5to15$Currency |> 
  str_replace(pattern = "KES", replacement = "KSH")

## b.KSH/RWF
fx5to15$Currency <- fx5to15$Currency |> 
  str_replace(pattern = "KSH / RWF",replacement = "KSH/RWF")


## c.KSH/BIF
fx5to15$Currency <-fx5to15$Currency |> 
  str_replace(pattern = "KSH / BIF",replacement = "KSH/BIF")


## d.KSH/USHS
fx5to15$Currency <- fx5to15$Currency |> 
  str_replace(pattern = "KSH / USHS",replacement = "KSH/USHS")


## e.KSH/TSHS
fx5to15$Currency <- fx5to15$Currency |> 
  str_replace(pattern = "KSH / TSHS",replacement = "KSH/TSHS")


## f.JPY(100)
fx5to15$Currency <- fx5to15$Currency |> 
  str_replace(pattern = "JPY [(]100[)]",replacement = "JPY(100)") 

## g.$ to DOLLAR
fx5to15$Currency <- fx5to15$Currency |> 
  str_replace(pattern = "[$]",replacement = "DOLLAR")

## h.CAN TO CANADIAN
fx5to15$Currency <- fx5to15$Currency |> 
  str_replace(pattern = "CAN",replacement = "CANADIAN")

## i.CURRENCY FORMAT
fx5to15$Currency <- as.factor(fx5to15$Currency)

# E. ADDING PERIODICAL COLUMNS
## a. year
fx5to15 <- fx5to15 |> 
  mutate(yr = year(fx5to15$Date),
         qtr = quarter(fx5to15$Date),
         mth = month(fx5to15$Date),
         wk = week(fx5to15$Date),
        dte = day(fx5to15$Date)) 

## F. EXPORTING
# write_csv(fx5to15, "forexKE2005_2015.csv")



# ***       



## 1ST DECEMBER 2016 - 13TH JUNE 2025
historical <- read_csv("historical_data2016_2023.csv", 
                       col_names = FALSE)

## A.REMOVING SELECT ROWS (1 to 11) ,COLUMNS (4 AND 5) 
# and RENAMING
hist <- historical[-c(1:11),-c(4,5)] |> 
  rename("date"=X1, "currency"=X2, "rate"=X3)

## B.REMOVING DUPLICATES
hist<-hist[!duplicated(hist),] #269 DUPLICATES REMOVED

## C. DATE VARIABLE
hist$date <-ymd(hist$date)

### D.SELECTING RATES BEYOND DECEMBER 2016
hist <- hist |> 
  filter(date > "2016-11-30")

## E.CURRENCY
### a.KSH
hist$currency <- hist$currency |> 
  str_replace(pattern = "KES",replacement = "KSH")

### b.DOLLAR
hist$currency <- hist$currency |> 
  str_replace(pattern = "[$]",replacement = "DOLLAR")

### c.CANADIAN
hist$currency <- hist$currency |> 
  str_replace(pattern = "CAN",replacement = "CANADIAN")

### d.JPY(100)
hist$currency <- hist$currency |> 
  str_replace(pattern = "JPY [(]100[)]",replacement = "JPY(100)") 

### e.KSH/USHS
hist$currency <- hist$currency |> 
  str_replace(pattern = "KSH / USHS",replacement = "KSH/USHS")

### f.KSH/TSHS
hist$currency <- hist$currency |> 
  str_replace(pattern = "KSH / TSHS",replacement = "KSH/TSHS")

### g.KSH/RWF
hist$currency <- hist$currency |> 
  str_replace(pattern = "KSH / RWF",replacement = "KSH/RWF")

### h.KSH/BIF
hist$currency <- hist$currency |> 
  str_replace(pattern = "KSH / BIF",replacement = "KSH/BIF")



## 2024/25 FOREX RATES
forex2425 <- read_csv("TRADE WEIGHTED AVERAGE INDICATIVE RATES UPTO 13JULY2025.csv")

## A.REMOVING DUPLICATES
forex2425<-forex2425[!duplicated(forex2425),] ## NO DUPLICATES

## B.RENAMING COLUMNS
forex2425 <- forex2425 |> 
  rename("date" = Date,"currency" = Currency,"rate" = `EXCHANGE RATE`)

## C.CURRENCY
### a.KSH
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "KES",replacement = "KSH")

### b.DOLLAR
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "[$]",replacement = "DOLLAR")

### c.CANADIAN
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "CAN",replacement = "CANADIAN")

### d.JPY(100)
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "JPY [(]100[)]",replacement = "JPY(100)") 

### e.KSH/USHS
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "KSH / USHS",replacement = "KSH/USHS")

### f.KSH/TSHS
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "KSH / TSHS",replacement = "KSH/TSHS")

### g.KSH/RWF
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "KSH / RWF",replacement = "KSH/RWF")

### h.KSH/BIF
forex2425$currency <- forex2425$currency |> 
  str_replace(pattern = "KSH / BIF",replacement = "KSH/BIF")

## D.DATE
### CONVERSION
forex2425$date <- as.Date(forex2425$date, tryFormats = c("%d/%m/%Y"))

### ORDERING BY DATE
forex2425 <- forex2425 |> 
  arrange(date)


# COMBINING FOREX DATA FROM DEC 2016 UPTO 13 JUNE 2025
fx16to25 <- bind_rows(hist, forex2425)

# fx16to25[duplicated(fx16to25),] # NO DUPLICATES


## A. CURRENCY
fx16to25$currency <- as.factor(fx16to25$currency)

# B. ADDING PERIODICAL COLUMNS
fx16to25 <- fx16to25 |> 
  mutate(yr = year(fx16to25$date),
         qtr = quarter(fx16to25$date),
         mth = month(fx16to25$date),
         wk = week(fx16to25$date),
         dte = day(fx16to25$date)) 

## C. EXPORTING
# write_csv(fx16to25, "forexKE2016_2025.csv")

 
