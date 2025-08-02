##  setup.R
##  PURPOSE:  use github actions to deploy shinylive app to github pages; 

## REF https://github.com/coatless-tutorials/convert-shiny-app-r-shinylive?tab=readme-ov-file

pkg_db <- tools::CRAN_package_db()
shiny_pkg_dependencies <- tools::package_dependencies(
  packages = c("shiny"),
  recursive = TRUE,
  db = pkg_db
)

shiny_pkg_dependencies

#> $shiny
#>  [1] "methods"     "utils"       "grDevices"   "httpuv"      "mime"       
#>  [6] "jsonlite"    "xtable"      "fontawesome" "htmltools"   "R6"         
#> [11] "sourcetools" "later"       "promises"    "tools"       "crayon"     
#> [16] "rlang"       "fastmap"     "withr"       "commonmark"  "glue"       
#> [21] "bslib"       "cachem"      "ellipsis"    "lifecycle"   "base64enc"  
#> [26] "jquerylib"   "memoise"     "sass"        "digest"      "Rcpp"       
#> [31] "cli"         "magrittr"    "stats"       "graphics"    "fs"         
#> [36] "rappdirs"
