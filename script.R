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

data  %>% 
  pivot_wider(names_from = KØN, values_from = INDHOLD) %>% 
  mutate(dif = Kvinder - Mænd)  %>% 
  pivot_longer(2:4, names_to = "type", values_to = "value") %>%  
  ggplot(aes(TID, value, color = type, group = type))+
  geom_line()


data %>% 
  ggplot(aes(x = TID, y = INDHOLD, color = KØN)) +
  geom_point() 


https://www.esundhed.dk/Emner/Hvad-doer-vi-af/Doedsaarsager


https://www.listendata.com/2019/06/create-infographics-with-r.html
https://www.r-bloggers.com/2015/02/r-how-to-layout-and-design-an-infographic/
  https://www.trm.dk/nyheder/2022/ny-undersoegelse-om-omfanget-af-vold-og-overgreb-i-danmark-2021


if(capabilities()[["X11"]]) withAutoprint({
  X11Fonts()
  X11Fonts("mono")
  utopia <- X11Font("-*-utopia-*-*-*-*-*-*-*-*-*-*-*-*")
  X11Fonts(utopia = utopia)
})
