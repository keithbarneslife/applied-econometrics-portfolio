# Project 8: EU Structural Funds Revisited

## Economic Question
Did EU structural funds improve regional GDP convergence in the 2007–2013 Multiannual Financial Framework? (Your MSc dissertation question, reimplemented in R.)

## What You're Learning
Two-way fixed effects with clustered standard errors on a real, messy dataset. This is where your dormant MSc knowledge reactivates, supported by the 7 projects that built up to it.

## Theory to Read
Re-read your own MSc dissertation if you still have it. Then read *The Effect*, Chapter 16 again with fresh eyes. Key question: under what assumptions does your two-way FE specification estimate a causal effect of structural funds on regional GDP?

## Data Source
**Eurostat NUTS2 regional GDP:**
- https://ec.europa.eu/eurostat/web/regions/data/database
- Table: `nama_10r_2gdp` (GDP at NUTS2 level)

**EU Cohesion fund allocations:**
- https://cohesiondata.ec.europa.eu/
- Download allocations by region and programming period

This is the most complex data assembly in the portfolio so far. Budget 1–2 sessions just for data preparation.

## R Packages Needed
`tidyverse`, `fixest`, `modelsummary`, `eurostat` (optional — R package for Eurostat data)

## Steps

### Session 1: Data assembly
- Download NUTS2 GDP data and structural fund allocations
- Merge by region code and year
- Inspect: how many regions? How many years? Any missing data?

### Session 2: Replicate your original approach
- If you remember your original specification, replicate it in R
- If not, start with: `feols(gdp_pc ~ fund_intensity | region + year, data = panel, cluster = ~region)`

### Session 3: Improve
- Try different specifications: log GDP, fund intensity per capita, different clustering
- Visualise: plot fund allocations vs GDP changes across regions

### Session 4: Write up
- Compare your R results to what you remember from your MSc
- Discuss: what assumptions does this specification require? Are they plausible?
- **This completes Phase 2a.** Do a calibration review before starting DiD.

## What "Done" Looks Like
- R Markdown reimplementing your MSc dissertation analysis in R with fixest
- You can explain two-way FE assumptions and assess their plausibility for this specific application
- This is a strong portfolio piece: it shows you can revisit and improve your own earlier work

## Estimated Sessions: ~4
