# Project 6: Understanding Panel Structure

## Economic Question
None — this project is about understanding *what panel data looks like* and what fixed effects will exploit.

## What You're Learning
The distinction between within-unit and between-unit variation. Fixed effects estimation uses only within-unit variation. If all the action in your data is between units, FE will have little power. You need to see this before estimating anything.

## Theory to Read
*The Effect*, Chapter 16 (Fixed Effects), first half only — the conceptual setup before the estimation.

**Maths thread:** Before starting Phase 2a, work through the Matrix Algebra section of `docs/maths-foundations.md`. You'll need this for Project 7.

## Data Source
**Penn World Tables 10.01**

Option A (recommended): `install.packages("pwt10"); library(pwt10); data("pwt10.01")`

Option B: Download from https://www.rug.nl/ggdc/productivity/pwt/

Key variables: `rgdpna` (real GDP), `pop` (population), `hc` (human capital index), `country`, `year`

## R Packages Needed
`tidyverse`, `pwt10`

## Steps

### Session 1: Explore and compute
- Load PWT data. Filter to a sensible set of countries (e.g., OECD, or a mix of developed/developing)
- Compute GDP per capita: `rgdpna / pop`
- For a variable like GDP growth, compute:
  - **Between variation:** each country's mean across all years → `group_by(country) %>% summarise(mean_gdp = mean(gdp_pc))`
  - **Within variation:** deviation from each country's mean → `group_by(country) %>% mutate(within_gdp = gdp_pc - mean(gdp_pc))`

### Session 2: Visualise
- Plot the between variation: bar chart of country means
- Plot the within variation: line chart of deviations from mean for a selection of countries
- Spaghetti plot: all countries' GDP trajectories on one chart, then the same chart after demeaning (subtracting each country's mean). The demeaned version is what FE "sees"
- **No regression in this project.** Just data exploration.

## What "Done" Looks Like
- R Markdown with visualisations of between and within variation
- You can explain in plain language what "within variation" means and why FE uses only this variation

## Estimated Sessions: ~2
