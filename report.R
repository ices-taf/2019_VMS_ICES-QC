## Prepare plots and tables for report

## Before:
## After:

library(icesTAF)

mkdir("report")



# install vmstools from github
#devtools::install_github("nielshintzen/vmstools/vmstools")

# libraries
library(rmarkdown)
library(icesTAF)
library(jsonlite)

# utiities
source("utilities.R")

# settings
config <- read_json("config.json", simplifyVector = TRUE)

# create report directory
mkdir("report")

# loop over countries
for (country in config$countries) {
  #country <- "EST"
  msg("Running QC for ... ", country)

  # fillin and write template
  fname <- makeQCRmd(country, "bootstrap/data", template = "report_QC_template.Rmd")

  # render Rmd
  ret <- try(render(fname, clean = FALSE, output_format = latex_document()))
  if (inherits(ret, "try-error")) {
    msg("FAILED - ", country)
    next
  }

  # compile pdf
  x <- shell(paste('pdflatex -halt-on-error', ret))

  if (x == 0) {
    # copy report and Rmd file
    copyReport(fname, report_dir = "report", keeps = c("pdf", "knit.md"))
  }

  msg("Done ... ", country)
}
