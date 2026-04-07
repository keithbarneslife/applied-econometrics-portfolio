# Project 1: LAC GDP Trends

## Economic Question
How has GDP per capita evolved across Latin American economies since 2010?

## What You're Learning
Tidyverse data wrangling: importing, reshaping, filtering, computing new variables, and visualising data. No statistics, no regression. Pure data plumbing. This is the foundation everything else sits on.

## Theory to Read
*The Effect*, Chapter 5 (first half only — the section on describing variables). You need to understand what it means to describe data before you model it.

## Data Source
**World Development Indicators (WDI)** — GDP per capita, constant 2015 US$

Option A (recommended): Use the `WDI` R package:
```r
install.packages("WDI")
library(WDI)
data <- WDI(indicator = "NY.GDP.PCAP.KD", country = "all", start = 2000, end = 2024)
```

Option B: Download CSV from https://databank.worldbank.org/source/world-development-indicators — select indicator NY.GDP.PCAP.KD, all countries, all years.

## R Packages Needed
`tidyverse` (includes dplyr, tidyr, ggplot2, readr)

## Steps

### Session 1: Import and explore
- Load the WDI data (either via the R package or CSV import with `read_csv()`)
- Inspect with `glimpse()`, `head()`, `summary()`
- How many countries? How many years? Any missing values?

### Session 2: Reshape and filter
- If using CSV download: reshape from wide to long with `pivot_longer()`
- Filter to LAC countries (use ISO codes: ARG, BRA, CHL, COL, MEX, PER, ECU, BOL, etc.)
- Compute GDP growth rates with `mutate()`: growth = (gdp - lag(gdp)) / lag(gdp) * 100
- Group by country with `group_by()` and compute mean growth with `summarise()`

### Session 3: Visualise
- Line chart of GDP per capita over time, one line per country, using `ggplot2`
- Faceted plot: `facet_wrap(~country)` for individual country panels
- Apply a clean theme (`theme_minimal()` or `theme_classic()`)
- Export as PNG: `ggsave("gdp_trends.png", width = 10, height = 6)`

## What "Done" Looks Like
- An R Markdown file (`analysis.Rmd`) that imports WDI data, reshapes it, filters to LAC countries, computes growth rates, and produces a publication-quality multi-country time-series plot
- The plot is saved as a PNG in this folder
- You can explain what `pivot_longer()`, `filter()`, `mutate()`, `group_by()`, and `ggplot()` do

## Estimated Sessions: ~3
