#Load libraries
library(httr)
library(dplyr)
library(jsonlite)

# Post to API
payload <- list(code = "ALL")
response <- httr::POST(url = "https://api.statworx.com/covid",
                       body = toJSON(payload, auto_unbox = TRUE), encode = "json")

content <- rawToChar(response$content)
df <- data.frame(fromJSON(content))
