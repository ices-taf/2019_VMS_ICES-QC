# 2019_VMS_ICES-QC
2019 - VMS Quality Control for internal use - WGSFD

## How to run

Install the icesTAF package, version >=2.3 from CRAN.

Then open R in the `2019_VMS_ICES-QC` directory and run:

to download data (as off 1/5/2019, will improve this):
```r
taf.bootstrap()
setwd("bootstrap")
process.bib("DATA.bib")
setwd("..")
```

then to run the reports
```r
sourceAll(clean = FALSE)
```
