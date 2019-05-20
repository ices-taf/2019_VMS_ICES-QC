# 2019_VMS_ICES-QC
2019 - VMS Quality Control for internal use - WGSFD

## How to run

Install the icesTAF package, version >=2.3 from CRAN.

Then open R in the `2019_VMS_ICES-QC` directory and run:

to download data (as of 1/5/2019, will work to improve this):
```r
library(icesTAF)
setwd("bootstrap")
cp("initial/config", ".")
process.bib("DATA.bib")
setwd("..")
sourceTAF("bootstrap.R", clean = FALSE)
```

then to run the reports (if you don't include the `clean = FALSE` it will delete 
all the previously run reports)
```r
sourceAll(clean = FALSE)
```


## how to rerun

the above can be combined into a single function that allows you to rerun for
different countries and years:
```r
vms_rerun <- function(..., bootstrap = FALSE) {
  # update config file
  config.path = "bootstrap/initial/config/config.json"
  config <- jsonlite::read_json(config.path, simplifyVector = TRUE)

  dots <- list(...)
  unused_names <- setdiff(names(dots), names(config))
  if (length(unused_names)) warning("\n unused names: ", paste0(unused_names, collapse = ", "))
  config <- modifyList(config, dots[names(dots) %in% names(config)])
  jsonlite::write_json(config, config.path, pretty = TRUE)

  # rerun bootstrap
  if (bootstrap) {
    setwd("bootstrap")
    cp("initial/config", ".")
    process.bib("DATA.bib")
    setwd("..")
    sourceTAF("bootstrap.R", clean = FALSE)
  }

  # rerun scripts
  sourceAll(clean = FALSE)
}
```

The following example reruns the report for Norway using the data from 2019
```r
taf_rerun(countries = "NOR", years = 2019)
```
