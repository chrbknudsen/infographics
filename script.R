library(httr)
library(tidyverse)
library(jsonlite)


"HISB7"

"https://api.statbank.dk/v1/subjects"
"https://api.statbank.dk/v1/tables"
"https://api.statbank.dk/v1/tableinfo"
"https://api.statbank.dk/v1/data"


endpoint <- "https://api.statbank.dk/v1/tableinfo"

body <- list(table = "HISB7")
resultater <- POST(endpoint, body = body, encode = "json")
resultater %>% content() %>% fromJSON()

variables <- list(list(code = "KØN", values = I("*")),
             list(code = "Tid", values  = I("*")))
body <- list(table = "HISB7", lang = "da", format  = "csv", 
             variables = variables)
endpoint <- "https://api.statbank.dk/v1/data"

resultater <- POST( endpoint, body = body, encode = "json")
data <- resultater %>% 
  content(type  ="text") %>% read_csv2()


view(data)  
data %>% 
  ggplot(aes(x = TID, y = INDHOLD)) +
  geom_point()


https://www.esundhed.dk/Emner/Hvad-doer-vi-af/Doedsaarsager