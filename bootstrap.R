## download data

## Before:
## After:

library(icesTAF)
library(RODBC)
library(jsonlite)


mkdir("bootstrap/data")


# packages

# utilities
source("utilities.R")

# settings
config <- read_json("bootstrap/config/config.json", simplifyVector = TRUE)

# connect to DB
conn <- odbcDriverConnect(connection = config$db_connection)


for (country in config$countries) {
  msg("downloading LE data for ... ", country)

  # set up sql command
  sqlq <- sprintf("SELECT * FROM [dbo].[_ICES_VMS_Datacall_LE] WHERE country = '%s' and year <= %i", country, max(config$years))
  fname <- paste0("bootstrap/data/ICES_LE_", country, ".csv")

  # fetch
  out <- sqlQuery(conn, sqlq)
  # save to file
  write.csv(out, file = fname, row.names = FALSE)
}


for (country in config$countries) {
  msg("downloading VMS data for ... ", country)

  # set up sql command
  sqlq <- sprintf("SELECT * FROM [dbo].[_ICES_VMS_Datacall_VMS] WHERE country = '%s' and year <= %i", country, max(config$years))
  fname <- paste0("bootstrap/data/ICES_VE_", country, ".csv")

  # fetch
  out <- sqlQuery(conn, sqlq)
  # save to file
  write.csv(out, file = fname, row.names = FALSE)
}

# disconnect
odbcClose(conn)
