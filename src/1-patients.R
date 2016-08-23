# 1-patients.R
#
# get list of patient encounters

# Run EDW Query: Patients - by Medication
#   * Set admit date range to desired time frame

library(dirr)
library(edwr)
library(dplyr)
library(lubridate)

data.raw <- "data/raw"

# compress data files
gzip_files(data.raw)

# check for patients that already have data pulled
data.warfarin <- read_data(data.raw, "meds") %>%
    as.meds_sched() %>%
    distinct(pie.id)

# generate list of patients to retrieve data
raw.patients <- read_data(data.raw, "patients") %>%
    as.patients() %>%
    arrange(pie.id)

pie.raw <- concat_encounters(raw.patients$pie.id)

new.patients <- raw.patients %>%
    filter(age >= 18,
           !(pie.id %in% data.warfarin$pie.id) | is.na(discharge.datetime))

# use the output below to run EDW queries:
#   Orders - Prompt
#   Medications - Inpatient Intermittent - Prompt
#   Labs - Coags
print(concat_encounters(new.patients$pie.id))
