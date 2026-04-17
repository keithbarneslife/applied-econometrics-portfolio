# =============================================================================
# Package setup for the applied-econometrics-portfolio
#
# Run this once per device (iPhone webRios, iPad webRios, Mac RStudio).
# Dependencies are installed automatically.
# =============================================================================

install.packages(c(
  "tidyverse",      # data manipulation and ggplot2
  "WDI",            # World Bank data
  "readxl",         # Excel files
  "knitr",          # tables via kable()
  "rmarkdown",      # knitting .Rmd files
  "conflicted",     # explicit namespace conflicts
  "httr",           # HTTP
  "httr2",          # HTTP v2
  "sandwich",       # robust standard errors
  "lmtest",         # coefficient tests
  "modelsummary",   # regression tables
  "pwt10",          # Penn World Tables
  "fixest",         # fast fixed effects, IV, DiD
  "wooldridge",     # textbook datasets
  "did",            # Callaway & Sant'Anna DiD
  "haven",          # read Stata/SPSS data
  "rdrobust",       # regression discontinuity
  "eurostat",       # Eurostat data
  "ggdag"           # causal diagrams
))
