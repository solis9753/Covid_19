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
    mutate(Date = as.Date(date, format = "%d/%m/%y")) %>%   
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
