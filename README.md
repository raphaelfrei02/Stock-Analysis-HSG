# Stock-Analysis-HSG

# 📈 Stock Return Analysis in R

This R script performs a detailed time series analysis of stock returns for two major companies — Apple Inc. (AAPL) and Microsoft Corp. (MSFT). The script includes return calculations, volatility estimation, visualization, and correlation analysis between the two stocks.

## 🔧 Features

- Computes daily returns from adjusted closing prices.
- Calculates cumulative returns over time.
- Measures 21-day rolling volatility using standard deviation.
- Summarizes key performance metrics: mean return, standard deviation, variance, and Sharpe ratio.
- Generates three time-series plots:
  - Daily returns
  - Cumulative returns
  - Rolling volatility
- Computes and displays the correlation between AAPL and MSFT daily returns.

## 📦 Requirements

Make sure the following R libraries are installed and loaded:

```r
library(dplyr)
library(ggplot2)
library(zoo)
