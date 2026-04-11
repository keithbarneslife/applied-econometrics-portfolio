# Project 7: First Fixed Effects Model

## Economic Question
Does the relationship between human capital and GDP survive when we control for all time-invariant country characteristics?

## What You're Learning
`feols()` in fixest. Entity FE vs pooled OLS. Understanding what FE absorbs.

## Before You Start
Read *The Effect*, Chapter 16 (full chapter). Key concepts: within-estimator, strict exogeneity, Mundlak's result.

## R Packages Needed
```r
library(tidyverse)
library(pwt10)
library(fixest)
library(modelsummary)
```

---

## Session 1: Pooled OLS (~20 min)

### Step 1: Prepare panel data
```r
library(tidyverse)
library(pwt10)
library(fixest)

data("pwt10.01")

panel <- pwt10.01 %>%
  filter(year >= 1990) %>%
  mutate(gdp_pc = rgdpna / pop, log_gdp = log(gdp_pc)) %>%
  select(country, isocode, year, log_gdp, hc) %>%
  drop_na()
```

### Step 2: Run pooled OLS (ignoring panel structure)
```r
m_pooled <- lm(log_gdp ~ hc, data = panel)
summary(m_pooled)
```
This treats every country-year as an independent observation. The coefficient on `hc` (human capital) captures both between-country and within-country variation. Countries with higher human capital have higher GDP — but is that because human capital *causes* growth, or because rich countries invest more in education?

---

## Session 2: Entity Fixed Effects (~30 min)

### Step 1: Run entity FE with fixest
```r
m_fe <- feols(log_gdp ~ hc | isocode, data = panel)
summary(m_fe)
```
The `| isocode` tells fixest to include a separate intercept for every country. This absorbs ALL time-invariant differences between countries: geography, colonial history, culture, institutions (to the extent they don't change over time).

### Step 2: Compare coefficients
```r
coef(m_pooled)["hc"]
coef(m_fe)["hc"]
```
The FE coefficient is typically smaller. Why? Because part of what the pooled OLS attributed to human capital was actually driven by other time-invariant country characteristics (geography, institutions) that are correlated with human capital.

### Step 3: Add year fixed effects (two-way FE)
```r
m_twoway <- feols(log_gdp ~ hc | isocode + year, data = panel)
summary(m_twoway)
```
Now you're also absorbing common time shocks (global recessions, oil price changes). The identifying variation is: *within a given country, in a given year, does higher-than-average human capital predict higher-than-average GDP?*

### Step 4: Cluster standard errors
```r
m_twoway_cl <- feols(log_gdp ~ hc | isocode + year, data = panel, cluster = ~isocode)
summary(m_twoway_cl)
```
Clustering by country accounts for serial correlation within each country's time series. Standard errors will typically get larger.

---

## Session 3: Present Results (~20 min)

### Step 1: Regression table
```r
library(modelsummary)

modelsummary(
  list(
    "Pooled OLS" = m_pooled,
    "Country FE" = m_fe,
    "Two-way FE" = m_twoway,
    "Clustered SEs" = m_twoway_cl
  ),
  stars = c("***" = 0.01, "**" = 0.05, "*" = 0.1),
  gof_map = c("nobs", "r.squared", "r.squared.within"),
  title = "Human Capital and GDP: Pooled OLS vs Fixed Effects"
)
```
Notice `r.squared.within` — this is the R² from within-country variation only, which is the relevant measure for FE.

### Step 2: Interpretation
```r
# The FE estimator removes all time-invariant confounders.
# The coefficient on hc drops from [X] (pooled) to [Y] (two-way FE).
# This means [describe what the FE absorbed].
#
# Strict exogeneity assumption: E[ε_it | hc_i1, ..., hc_iT, α_i] = 0
# This requires that human capital is uncorrelated with the error term
# in ALL periods, not just the current one. This rules out feedback
# from GDP shocks to future human capital investment.
```

**Save and commit: "Project 07: complete".**

---

## What "Done" Looks Like
- `analysis.R` comparing pooled OLS, entity FE, two-way FE, and clustered SEs
- You can explain what `| isocode` does in `feols()` and why the coefficient changed
- You can state the strict exogeneity assumption

## Estimated Sessions: ~3

---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `07-first-fixed-effects/`
4. Create `analysis.R` (tap + → New File), paste your code, save
5. Commit with a message like "Project 07: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.R` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
