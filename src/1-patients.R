# 1-patients.R
#
# get list of patient encounters

# Run EDW Query:
#   - Patients - by End Date - Clinical Event Prompt
#      * Set admit date range to desired time frame

library(dirr)
library(edwr)
library(tidyverse)
library(lubridate)

data.raw <- "data/raw"

# compress data files
gzip_files(data.raw)

# get list of patients already pulled
completed_pie <- "data/final/patients_completed.csv"
pulled <- tibble("pie.id" = "")

if (file.exists(completed_pie)) {
    pulled <- read_csv(completed_pie, col_types = "c?icc")
}

# generate list of patients to retrieve data
raw_patients <- read_data(data.raw, "patients") %>%
    as.patients() %>%
    arrange(pie.id) %>%
    anti_join(pulled, by = "pie.id")

pie_edw <- concat_encounters(raw_patients$pie.id, 950)

save_pie <- raw_patients %>%
    filter(!is.na(discharge.datetime))

if (!file.exists(completed_pie)) {
    x <- FALSE
} else {
    x <- TRUE
}
write_csv(save_pie, completed_pie, append = x)

# use the output from pie_edw below to run EDW queries:
#   Orders - Prompt
#   Medications - Inpatient Intermittent - Prompt
#   Labs - Coags
#   Labs - CBC
