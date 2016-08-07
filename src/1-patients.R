# 1-patients.R
#
# get list of patient encounters

library(dirr)
library(edwr)
library(dplyr)
library(lubridate)

data.raw <- "data/raw"

# compress data files
gzip_files(data.raw)

# change the date to update for new patients
dc.date <- "4/1/2016"

raw.patients <- read_data(data.raw, "patients") %>%
    as.patients() %>%
    filter(age >= 18,
           discharge.datetime >= mdy(dc.date, tz = "US/Central"))

# use the output below to run EDW query: Orders - Prompt
print(concat_encounters(raw.patients$pie.id))
