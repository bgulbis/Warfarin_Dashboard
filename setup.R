# setup.R

# create project directory structure

make_dirs <- function(x) {
    if (!dir.exists(x)) dir.create(x)
}

list_dirs <- list(
    "data",
    "data/raw",
    "data/tidy",
    "data/external",
    "data/final",
    "explore",
    "figs",
    "doc",
    "report",
    "src"
)

lapply(list_dirs, make_dirs)
