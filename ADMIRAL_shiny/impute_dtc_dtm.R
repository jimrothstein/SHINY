# PURPOSE:   Examples of how derive_vars_dt processes tibbles.
library(shiny)
library(admiral)
library(lubridate)
###

dates <- c(
  "2019-07-18T15:25:40",
  "2019-07-18T15:25",
  "2019-07-18T15",
  "2019-07-18",
  "2019-02",
  "2019",
  "2019",
  "2019---07",
  ""
)

# No date imputation (highest_imputation defaulted to "h")
# Missing time part imputed with 00:00:00 portion by default

impute_dtc_dtm(dtc = dates,
               highest_imputation="h")  # h is default

impute_dtc_dtm(dtc = dates,
               highest_imputation="M")  # h is default

impute_dtc_dtm(dtc = dates,
               highest_imputation="D")  # h is default

impute_dtc_dtm(
  c("2020-12"),
  min_dates = list(
    ymd_hms("2020-12-06T12:12:12"),
    ymd_hms("2020-12-05T12:12:11")
  ),
  highest_imputation = "Y"
)

impute_dtc_dtm(
  c(NA_character_),
  min_dates = list(
    ymd_hms( "2020-01-01T01:01:01"),
    ymd_hms( NA)
  ),
  highest_imputation = "Y"
)
impute_dtc_dtm(
  c("2020-12", NA_character_),
  min_dates = list(
    ymd_hms("2020-12-06T12:12:12", "2020-01-01T01:01:01"),
    ymd_hms("2020-11-11T11:11:11", NA)
  ),
  highest_imputation = "Y"
)
# No date imputation (highest_imputation defaulted to "h")
# Missing time part imputed with 23:59:59 portion
impute_dtc_dtm(
  dtc = dates,
  time_imputation = "23:59:59"
)

# Same as above
impute_dtc_dtm(
  dtc = dates,
  time_imputation = "last"
)

# Impute to first day/month if date is partial
# Missing time part imputed with 00:00:00 portion by default
impute_dtc_dtm(
  dtc = dates,
  highest_imputation = "M"
)
# same as above
impute_dtc_dtm(
  dtc = dates,
  highest_imputation = "M",
  date_imputation = "01-01"
)

# Impute to last day/month if date is partial
# Missing time part imputed with 23:59:59 portion
impute_dtc_dtm(
  dtc = dates,
  date_imputation = "last",
  time_imputation = "last"
)

# Impute to mid day/month if date is partial
# Missing time part imputed with 00:00:00 portion by default
impute_dtc_dtm(
  dtc = dates,
  highest_imputation = "M",
  date_imputation = "mid"
)

# Impute a date and ensure that the imputed date is not before a list of
# minimum dates
impute_dtc_dtm(
  "2020-12",
  min_dates = list(
    ymd_hms("2020-12-06T12:12:12"),
    ymd_hms("2020-11-11T11:11:11")
  ),
  highest_imputation = "M"
)

# Impute completely missing dates (only possible if min_dates or max_dates is specified)
impute_dtc_dtm(
  c("2020-12", NA_character_),
  min_dates = list(
    ymd_hms("2020-12-06T12:12:12", "2020-01-01T01:01:01"),
    ymd_hms("2020-11-11T11:11:11", NA)
  ),
  highest_imputation = "Y"
)

###


# table for testing
mhdt <- tribble(
   ~MHSTDTC,
   "2019-07-18T15:25:40",
   "2019-07-18T15:25",
   "2019-07-18",
   "2019-02",
   "2019",
   "2019---07",
   ""
 )

# Create ASTDT and ASTDTF
# No imputation for partial date
res1 =derive_vars_dt(
  mhdt,
  new_vars_prefix = "AST",
  dtc = MHSTDTC,
  highest_imputation="n",   # default
  flag_imputation="auto"   # default, "date", "none"
 )
res2 =derive_vars_dt(
  mhdt,
  new_vars_prefix = "AST",
  dtc = MHSTDTC,
  highest_imputation="M"
 )


