# zip_files.R

library(R.utils)

data.raw <- "data/raw"

comp.files <- list.files(data.raw, full.names = TRUE)

lapply(comp.files, function(x) if (!isGzipped(x)) gzip(x, overwrite = TRUE))
