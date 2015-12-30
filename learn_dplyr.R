
#learning dplyr using cambodia census data and flight data
#using intro to dplyr https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
#and cambodian open data


rm(list = ls())


x <- read.csv(url("http://www.opendevelopmentcambodia.net/download/maps/census_2008_provinces.csv"))


# set up directories

setwd("~/drive/cambodia_open_data")

dir <- getwd()
if(!dir.exists(file.path(dir, 'data'))) {
    dir.create(file.path(dir, 'data'))
}
if(!dir.exists(file.path(dir, 'output'))) {
    dir.create(file.path(dir, 'output'))
}

dd <- "~/drive/cambodia_open_data/data"
od <- "~/drive/cambodia_open_data/output"  