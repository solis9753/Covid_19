tidy_CYdata <- function(dataframe){
  df <- dataframe %>% 
    mutate(Date = as.Date(date, format = "%d/%m/%y")) %>%   
    rename(newcases = daily.new.cases,
           newdeaths = daily.deaths, 
           newrecovered = daily.recovered.cases,
           newtests = daily.tests.performed,
           totalcases = total.cases, 
           totaldeaths = total.deaths, 
           totalrecovered = total.recovered, 
           totaltests = total.tests) %>%
    mutate_if(is.numeric, ~replace(., is.na(.), 0)) %>%
    select(Date, newcases, newdeaths, newrecovered, totalcases, totaldeaths, totalrecovered, newtests, totaltests)
  
  return(df) #return output
  
} #end function


# creating new variables
Manage_CYdata <- function(dataframe) {
  df <- dataframe %>%
    mutate(CFR = (totaldeaths/totalcases)* 100, 
           GF = totalcases / lag(totalcases, default = first(totalcases)))
}

tidy_ECDCdata <- function(dataframe){
  df <- dataframe %>% 
    mutate(Date = as.Date(date)) %>%   
    rename(newcases = cases,
           newdeaths = deaths, 
           #newrecovered = daily.recovered.cases,
           #newtests = daily.tests.performed,
           totalcases = cases_cum, 
           totaldeaths = deaths_cum, 
           #totalrecovered = total.recovered, 
           #totaltests = total.tests
           ) %>%
    mutate_if(is.numeric, ~replace(., is.na(.), 0)) %>%
    select(Date, country, code, newcases, newdeaths, totalcases, totaldeaths, population, continentExp)
  
  return(df) #return output
  
} #end function

Manage_ECDCdata <- function(dataframe) {
  df <- dataframe %>%
    mutate(CFR = (totaldeaths/totalcases)* 100, 
           GF = totalcases / lag(totalcases, default = first(totalcases)))
}

collect_ECDCdata <- function(dataframe){
  df <- dataframe  %>% group_by(country) %>% 
    # Remove all rows of country if there aren't any rows with values==0
    filter(any(newcases==0)) %>% 
    # Remove all rows with values != 0
    filter(newcases != 0) %>% 
    # Keep the first row of each variable, after sorting by Date
    # This gives us the first non-zero row
    arrange(Date) %>% 
    slice(1) %>% 
    # Use complete to bring back a row for any level of variable that
    # didn't start with any rows with values==0
    ungroup() %>% 
    complete(country)
  return(df)
}
