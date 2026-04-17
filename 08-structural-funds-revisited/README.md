# Project 8: EU Structural Funds Revisited

## Economic Question
Did EU structural funds improve regional GDP convergence in the 2007–2013 MFF?

This is your MSc dissertation question, reimplemented in R with modern tools. You've done 7 projects building up to this. Time to reconnect with your own research.

## What You're Learning
Two-way FE with clustered SEs on a real, messy dataset. Data assembly from multiple sources.

## Before You Start
- Re-read your MSc dissertation if you have access to it
- Re-read *The Effect*, Chapter 16 with fresh eyes

## R Packages Needed
```r
library(tidyverse)
library(fixest)
library(modelsummary)
```
Optionally `library(eurostat)` if it installed on webRios. If not, download data manually (see below).

---

## Session 1: Data Assembly (~40 min)

This is the most complex data step so far. Budget extra time.

### Step 1: Get NUTS2 regional GDP data

**Option A — eurostat R package:**
```r
library(eurostat)
nuts2_gdp <- get_eurostat("nama_10r_2gdp",
                          filters = list(unit = "MIO_EUR"))
glimpse(nuts2_gdp)
```

**Option B — manual download (if eurostat package doesn't work on webRios):**
1. Go to https://ec.europa.eu/eurostat/databrowser/view/nama_10r_2gdp/default/table
2. Filter: NUTS level 2, GDP indicator, all years
3. Download CSV
4. In webRios: `nuts2_gdp <- read_csv("path_to_downloaded_file.csv")`

### Step 2: Clean the GDP data
The exact cleaning steps depend on the format you downloaded. The goal is a tidy panel: one row per region-year, with columns for `region_code`, `year`, and `gdp`.
```r
# Example (adjust based on actual column names):
gdp_panel <- nuts2_gdp %>%
  rename(region = geo, gdp = values) %>%
  filter(nchar(region) == 4) %>%     # NUTS2 codes are 4 characters
  mutate(year = as.numeric(time)) %>%
  select(region, year, gdp) %>%
  drop_na()
```

### Step 3: Get structural fund allocations
Download from https://cohesiondata.ec.europa.eu/ — look for allocations by NUTS2 region for the 2007–2013 programming period.

This data is messier. You may need to:
```r
# Example structure after download and import:
funds <- read_csv("cohesion_data.csv") %>%
  select(region = nuts2_code, fund_amount = total_allocation) %>%
  drop_na()
```

### Step 4: Merge
```r
panel <- gdp_panel %>%
  left_join(funds, by = "region")
```

If the data assembly takes a full session, that's fine. Save what you have and continue in Session 2.

---

## Session 2: Estimate (~30 min)

### Step 1: Run two-way FE
```r
# Compute fund intensity (funds per unit of GDP or per capita)
# The exact variable depends on what you downloaded

m_fe <- feols(log(gdp) ~ fund_intensity | region + year,
              data = panel, cluster = ~region)
summary(m_fe)
```

### Step 2: Compare to pooled OLS
```r
m_pooled <- feols(log(gdp) ~ fund_intensity, data = panel)
```
The pooled estimate will be biased because richer regions receive fewer funds (targeting) or more funds (absorption capacity). FE addresses this by comparing each region to *itself* over time.

### Step 3: Try alternative specifications
```r
# GDP per capita instead of total GDP
# Different fund intensity measures
# Lagged fund intensity (funds take time to affect GDP)
m_lag <- feols(log(gdp) ~ l(fund_intensity, 1) | region + year,
               data = panel, cluster = ~region, panel.id = ~region + year)
```

---

## Sessions 3–4: Write Up (~40 min total)

```r
modelsummary(
  list("Pooled" = m_pooled, "Two-way FE" = m_fe),
  stars = c("***" = 0.01, "**" = 0.05, "*" = 0.1),
  title = "EU Structural Funds and Regional GDP"
)
```

Add interpretation:
```r
# INTERPRETATION
# Under what assumptions does this estimate a causal effect?
# 1. Strict exogeneity: fund allocations uncorrelated with time-varying
#    regional shocks (conditional on region and year FE)
# 2. No anticipation effects
# 3. No spillovers between regions
#
# PHASE 2a COMPLETE. Do a calibration review.
```

**Save and commit: "Project 08: complete — Phase 2a done".**

---

## What "Done" Looks Like
- `analysis.R` reimplementing your MSc analysis in R with fixest
- A regression table comparing pooled OLS and two-way FE
- A written assessment of the identifying assumptions
- **Calibration review** saved in `reviews/phase2a-calibration.md`

## Estimated Sessions: ~4
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `08-structural-funds-revisited/analysis.Rmd` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.Rmd` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 08: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.Rmd`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
