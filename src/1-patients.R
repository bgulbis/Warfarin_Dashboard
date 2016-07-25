# 1-patients.R
#
# get list of patient encounters

library(edwr)
library(dplyr)
library(lubridate)

data.raw <- "data/raw"

# change the date to update for new patients
dc.date <- "4/1/2016"

raw.patients <- read_data(data.raw, "patients") %>%
    as.patients() %>%
    filter(age >= 18,
           discharge.datetime >= mdy(dc.date, tz = "US/Central"))

concat_encounters(raw.patients$pie.id)
