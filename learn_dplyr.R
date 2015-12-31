
#learning dplyr using cambodia census data and flight data
#using intro to dplyr https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
#and cambodian open data

#clear environment
rm(list = ls())


#Add libraries
library(dplyr)
library(ggplot2)
library(scales)

# set up directories
#setwd("~/drive/cambodia_open_data")

dir <- getwd()
if(!dir.exists(file.path(dir, 'data'))) {
    dir.create(file.path(dir, 'data'))
}
if(!dir.exists(file.path(dir, 'output'))) {
    dir.create(file.path(dir, 'output'))
}

dd <- "~/drive/cambodia_open_data/data"
od <- "~/drive/cambodia_open_data/output"  

#load cambodia data
e <- read.csv(url("http://www.opendevelopmentcambodia.net/download/maps/census_2008_provinces.csv"))
head(e)
dim(e)

#load flight data
library(nycflights13)
dim(flights)
head(flights)

#lets start with flight commands
filter(flights, month == 1, day == 1)

filter(flights, month == 1 | month == 2)

slice(flights, 1:10)
slice(e, 1:10)

#now lets try filtering with the cambodia data
#we can look at which provinces have more than 5 people per hh
filter(e, avg_hs > 5)

#and we can arrange by HH size
arrange(e, desc(avg_hs))

#now lets take a few interesting variables and play with those using the %>%
#to group operatoins

e1 <- e %>%
  #rename province name, total population, household size
  rename(prov = prov_name, pop = totpop, hh.size = avg_hs) %>%
  #take those variables and urban population and density
  dplyr::select(prov, pop, hh.size, urban, density) %>%
  arrange(desc(pop)) %>%
  #create variable for urban population
  mutate(
    pop.urban = round(urban * pop/100, digits = 0)
  )
e1

#mean urban population
summarise(e1, mean(pop.urban))

#graph population in a bar chart by province
ggplot(e1, aes(x=reorder(prov, -pop), y=pop)) + geom_bar(stat="identity") +
 xlab('Province') +
  ylab('Population') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
         scale_y_continuous(labels=function(x) format(x, big.mark = ",", scientific = FALSE) 
             )