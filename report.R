## Prepare plots and tables for report

## Before:
## After:


# create report directory
mkdir("report")

# libraries
library(rmarkdown)
library(icesTAF)
library(jsonlite)
taf.library(vmstools)

# utiities
source("utilities.R")

# settings
config <- read_json("bootstrap/config/config.json", simplifyVector = TRUE)


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
    copyReport(fname, report_dir = "report", keeps = c("pdf", "knit.md", "Rmd"))
  }

  msg("Done ... ", country)
}
