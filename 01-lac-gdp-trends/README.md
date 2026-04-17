# Project 1: LAC GDP Trends

## Economic Question
How has GDP per capita evolved across Latin American economies since 2010?

## What You're Learning
Tidyverse data wrangling: importing, reshaping, filtering, computing new variables, and visualising data. No statistics, no regression. Pure data plumbing.

## Before You Start
Read *The Effect*, Chapter 5 (first half — describing variables). 20 minutes on your iPad, no code needed.

## R Packages Needed
```r
library(tidyverse)
library(WDI)
```

---

## Session 1: Import and Explore (~30 min)

### Step 1: Load packages
```r
library(tidyverse)
library(WDI)
```

### Step 2: Download GDP per capita data
This pulls GDP per capita (constant 2015 US$) for all countries, 2000–2024, directly from the World Bank.
```r
gdp_raw <- WDI(
  indicator = "NY.GDP.PCAP.KD",
  country = "all",
  start = 2000,
  end = 2024
)
```
You should see a data frame appear in your environment. It may take 10–20 seconds to download.

### Step 3: Inspect the data
```r
glimpse(gdp_raw)
```
This shows you the column names, types, and first few values. You should see columns like `country`, `iso2c`, `year`, and `NY.GDP.PCAP.KD`.

```r
head(gdp_raw, 10)
```
This shows the first 10 rows. Notice that some rows are aggregates (e.g. "World", "Sub-Saharan Africa"), not individual countries. We'll filter those out later.

```r
nrow(gdp_raw)
```
How many rows? This tells you the total size of the dataset.

### Step 4: Rename the GDP variable
The variable name `NY.GDP.PCAP.KD` is a World Bank code. Give it a human-readable name:
```r
gdp <- gdp_raw %>%
  rename(gdp_pc = NY.GDP.PCAP.KD)
```
The `%>%` is the pipe operator. Read it as "take gdp_raw, THEN rename the column." You'll use this constantly.

### Step 5: Check for missing values
```r
sum(is.na(gdp$gdp_pc))
```
This counts how many GDP observations are missing. Some countries have gaps, especially in recent years.

**Save your work now.** Copy all the code you've written so far. In Working Copy, navigate to `01-lac-gdp-trends/`, create `analysis.R`, paste, and save. You can commit later or now — "Project 01: session 1 - data import and exploration".

---

## Session 2: Filter and Compute (~30 min)

### Step 1: Load your previous work
Open webRios and run everything from Session 1 again (paste your `analysis.R` file and run it). You need the `gdp` object in memory.

### Step 2: Define your LAC countries
```r
lac_codes <- c("ARG", "BOL", "BRA", "CHL", "COL", "CRI", "ECU",
               "GTM", "HND", "MEX", "NIC", "PAN", "PER", "PRY",
               "SLV", "URY", "VEN")
```
These are ISO 3-letter codes. Note: the WDI data uses `iso2c` (2-letter codes). Let's check which column to use:
```r
head(gdp$iso2c)
head(gdp$iso3c)
```
If `iso3c` doesn't exist, we need to use `iso2c` instead. In that case:
```r
lac_codes <- c("AR", "BO", "BR", "CL", "CO", "CR", "EC",
               "GT", "HN", "MX", "NI", "PA", "PE", "PY",
               "SV", "UY", "VE")
```
Use whichever column exists in your data.

### Step 3: Filter to LAC countries and recent years
```r
lac <- gdp %>%
  filter(iso2c %in% lac_codes, year >= 2010)
```
Read this as: "take gdp, THEN keep only rows where the country code is in our LAC list AND the year is 2010 or later."

Check it worked:
```r
unique(lac$country)
nrow(lac)
```
You should see ~17 countries and roughly 17 × 14 = 238 rows (fewer if some data is missing).

### Step 4: Compute GDP growth rates
```r
lac <- lac %>%
  arrange(country, year) %>%
  group_by(country) %>%
  mutate(gdp_growth = (gdp_pc - lag(gdp_pc)) / lag(gdp_pc) * 100) %>%
  ungroup()
```
Breaking this down:
- `arrange(country, year)` — sorts by country then year (essential before using `lag()`)
- `group_by(country)` — tells R to do the next operation *within each country*
- `mutate(...)` — creates a new column. `lag(gdp_pc)` is the previous year's value
- `ungroup()` — removes the grouping so future operations apply to the whole dataset

Check the result:
```r
lac %>%
  filter(country == "Brazil") %>%
  select(country, year, gdp_pc, gdp_growth)
```
You should see Brazil's GDP per capita and growth rates. The first year (2010) will have `NA` for growth because there's no previous year to compare to.

### Step 5: Compute summary statistics by country
```r
lac_summary <- lac %>%
  group_by(country) %>%
  summarise(
    mean_gdp = mean(gdp_pc, na.rm = TRUE),
    mean_growth = mean(gdp_growth, na.rm = TRUE),
    sd_growth = sd(gdp_growth, na.rm = TRUE)
  )

print(lac_summary)
```
`na.rm = TRUE` tells R to ignore missing values when computing the mean. Without it, any country with a missing value would return `NA` for the whole summary.

**Save your work.** Update `analysis.R` in Working Copy with all the new code. Commit: "Project 01: session 2 - filter and compute growth rates".

---

## Session 3: Visualise (~30 min)

### Step 1: Reload everything
Run all your code from Sessions 1 and 2 to get the `lac` object back in memory.

### Step 2: Line chart — GDP per capita over time
```r
ggplot(lac, aes(x = year, y = gdp_pc, colour = country)) +
  geom_line(linewidth = 0.8) +
  labs(
    title = "GDP per Capita in Latin American Economies",
    subtitle = "Constant 2015 US$, 2010–2024",
    x = "Year",
    y = "GDP per capita (US$)",
    colour = "Country"
  ) +
  theme_minimal()
```
This creates a line chart with one line per country, coloured differently. `theme_minimal()` gives it a clean look.

You should see the plot appear in webRios. If there are too many countries and the legend is cluttered, that's fine — the next plot fixes that.

### Step 3: Faceted plot — one panel per country
```r
ggplot(lac, aes(x = year, y = gdp_pc)) +
  geom_line(colour = "steelblue", linewidth = 0.8) +
  facet_wrap(~country, scales = "free_y") +
  labs(
    title = "GDP per Capita by Country",
    subtitle = "Constant 2015 US$, 2010–2024",
    x = "Year",
    y = "GDP per capita (US$)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))
```
`facet_wrap(~country, scales = "free_y")` creates a separate panel for each country. `scales = "free_y"` lets each panel have its own y-axis scale, which is important because Bolivia's GDP is much lower than Chile's.

### Step 4: Growth rate bar chart
```r
ggplot(lac_summary, aes(x = reorder(country, mean_growth), y = mean_growth)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Average GDP Growth Rate, 2010–2024",
    x = "",
    y = "Mean annual growth (%)"
  ) +
  theme_minimal()
```
`reorder(country, mean_growth)` sorts the bars by growth rate. `coord_flip()` makes it horizontal, which is easier to read with country names.

### Step 5: Save a plot (if webRios supports it)
If you can save files from webRios, try:
```r
ggsave("gdp_trends.png", width = 10, height = 6, dpi = 150)
```
If this doesn't work in webRios, don't worry — you can regenerate the plots later on your Mac. The code is what matters.

**Save your work.** Update `analysis.R` with the visualisation code. Commit: "Project 01: session 3 - visualisation complete".

---

## What "Done" Looks Like
- `analysis.R` in this folder contains working code that imports WDI data, reshapes it, filters to LAC countries, computes growth rates, and produces at least two plots
- You can explain what `%>%`, `filter()`, `mutate()`, `group_by()`, `summarise()`, and `ggplot()` do
- You feel comfortable enough with these functions to use them on a different dataset without copying the exact code

## Estimated Sessions: ~3
---

## Workflow

Open `01-lac-gdp-trends/analysis.R` in Working Copy, webRios alongside. Paste file contents into webRios to reload state. Write new commands in the file, copy over to webRios to run. Commit and push at the end.

See [WORKFLOW.md](../WORKFLOW.md) for the full version.
