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
