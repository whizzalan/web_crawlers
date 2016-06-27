# get data from https://stock-ai.com/
library(magrittr)
library(httr)
library(jsonlite)

get_data_from_stock_ai <- function(symbol_code, start_year, start_month, end_year, end_month) {
  url <- "https://stock-ai.com/eomDataQuery.php"
  # url <- "https://stock-ai.com/dailyDataQuery" # the url varies accross different pages
  body = list(a = "c",
              showType = "Value",
              symbolCode = symbol_code,
              startYear = start_year,
              startMonth = start_month,
              endYear = end_year,
              endMonth = end_month,
              hash = "d41d8cd98f00b204e9800998ecf8427e") # need to check whether the hash code will change

  res = POST(url, body = body, encode = "form")
  res_str <- content(res, as = "text", encoding = "utf8")

  res_str %>% fromJSON() %>% .$rows
}

# an example
# get_data_from_stock_ai("twM1BYoY", 2006, 5, 2016, 5)
