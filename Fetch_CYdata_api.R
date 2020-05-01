library("rjson")
library(httr)
json_file <- "https://www.data.gov.cy/api/3/action/package_show?id=f6c70a36-daaf-42c2-80d6-f99a329fdd0f"
get_data <- GET(json_file)
get_data
#names(get_data)
get_data$status_code
get_data$content
this.raw.content <- rawToChar(get_data$content)
#nchar(this.raw.content)
#substr(this.raw.content, 1, 100)
this.content <- fromJSON(this.raw.content)
#class(this.content)
#length(this.content)
  
url <- this.content$result[[1]][[18]][[1]][[3]]
dfcy <- read.csv(url, header = TRUE)

