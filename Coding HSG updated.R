# Load libraries
library(dplyr)
library(ggplot2)
library(zoo)

# Helper function for stock analysis
analyze_stock <- function(data, ticker) {
  stock <- data %>%
    filter(ticker == !!ticker) %>%
    arrange(date) %>%
    mutate(
      return = (adj / lag(adj)) - 1,
      cum_return = cumprod(1 + coalesce(return, 0)),
      rolling_vol = rollapply(return, width = 21, FUN = sd, fill = NA, align = "right")
    )
  
  # Summary statistics
  avg_return <- mean(stock$return, na.rm = TRUE)
  sd_return <- sd(stock$return, na.rm = TRUE)
  var_return <- var(stock$return, na.rm = TRUE)
  sharpe_ratio <- avg_return / sd_return
  
  print(paste("Summary for", ticker))
  print(data.frame(
    Mean = avg_return,
    SD = sd_return,
    Variance = var_return,
    Sharpe = sharpe_ratio
  ))
  
  # Plots
  p1 <- ggplot(stock, aes(x = date, y = return)) +
    geom_line() +
    labs(title = paste(ticker, "- Daily Returns"), x = "Date", y = "Return") +
    theme_minimal()
  
  p2 <- ggplot(stock, aes(x = date, y = cum_return)) +
    geom_line(color = "darkblue") +
    labs(title = paste(ticker, "- Cumulative Return"), x = "Date", y = "Cumulative Return") +
    theme_minimal()
  
  p3 <- ggplot(stock, aes(x = date, y = rolling_vol)) +
    geom_line(color = "darkred") +
    labs(title = paste(ticker, "- 21-Day Rolling Volatility"), x = "Date", y = "Volatility") +
    theme_minimal()
  
  print(p1)
  print(p2)
  print(p3)
  
  return(stock)
}

# Run analysis for AAPL and MSFT
AAPL <- analyze_stock(sp500_prc, "AAPL")
MSFT <- analyze_stock(sp500_prc, "MSFT")

# Correlation between AAPL and MSFT returns
combined_returns <- inner_join(
  AAPL %>% select(date, AAPL_return = return),
  MSFT %>% select(date, MSFT_return = return),
  by = "date"
)

correlation <- cor(combined_returns$AAPL_return, combined_returns$MSFT_return, use = "complete.obs")
print(paste("Correlation between AAPL and MSFT returns:", round(correlation, 4)))