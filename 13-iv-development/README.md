# Project 13: IV in Development — Miguel, Satyanath & Sergenti (2004)

## Economic Question
Do economic shocks cause civil conflict in Africa?

## What You're Learning
Applied IV in development economics and *critically assessing* instrument validity. The meta-question: how convincing is this instrument?

## Before You Start
Skim MSS (2004), JPE 112(4). Focus on the identification strategy and the debate it generated.

## R Packages Needed
```r
library(tidyverse)
library(fixest)
library(modelsummary)
library(haven)
```

---

## Session 1: Data and First Stage (~30 min)

### Step 1: Get the data
Download replication files from Edward Miguel's website: https://emiguel.econ.berkeley.edu/research/

Look for "Economic Shocks and Civil Conflict" replication data. It will likely be a Stata file.
```r
library(tidyverse)
library(haven)
library(fixest)

mss <- read_dta("MSS_data.dta")  # adjust filename
glimpse(mss)
```
Key variables (names may vary): conflict indicator (any_prio or similar), GDP growth, rainfall growth, country ID, year.

### Step 2: First stage — does rainfall predict GDP growth?
```r
first_stage <- feols(gdp_growth ~ rainfall_growth | country + year,
                     data = mss, cluster = ~country)
summary(first_stage)
fitstat(first_stage, "ivf")
```
Does the F-statistic exceed 10?

---

## Session 2: 2SLS (~20 min)

### Step 1: OLS (biased — reverse causality)
```r
m_ols <- feols(conflict ~ gdp_growth | country + year,
               data = mss, cluster = ~country)
```

### Step 2: IV using rainfall
```r
m_iv <- feols(conflict ~ 1 | country + year | gdp_growth ~ rainfall_growth,
              data = mss, cluster = ~country)
summary(m_iv)
```
In fixest: `conflict ~ 1 | country + year | gdp_growth ~ rainfall_growth` means "regress conflict on GDP growth, with country and year FE, instrumenting GDP growth with rainfall."

### Step 3: Compare
```r
library(modelsummary)
modelsummary(list("OLS" = m_ols, "IV" = m_iv),
             stars = c("***" = 0.01, "**" = 0.05, "*" = 0.1))
```

---

## Sessions 3–4: Critical Assessment (~40 min)

This is the most important part of this project. Write a structured critique:

```r
# EXCLUSION RESTRICTION CRITIQUE
#
# Claim: rainfall → GDP growth → conflict (rainfall affects conflict
# ONLY through its effect on the economy)
#
# Possible violations:
#
# 1. Direct agricultural channel: drought → crop failure → competition
#    over land/water → conflict. This doesn't go through GDP growth
#    as measured; it's a direct resource competition effect.
#
# 2. Migration: drought → pastoral migration → conflict over grazing
#    land. Again, this is not an income channel.
#
# 3. Climate and long-run adaptation: countries that experience more
#    rainfall variability may have different institutions, governance,
#    or social structures that independently affect conflict risk.
#
# Assessment: [your overall judgment — is this instrument convincing?]
```

**Save and commit: "Project 13: complete".**

---

## What "Done" Looks Like
- `analysis.R` with IV replication and a substantive written critique
- You can explain why "rainfall as instrument" is both appealing and problematic
- **Phase 2c complete.** Consider calibration review.

## Estimated Sessions: ~4
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `13-iv-development/analysis.R` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.R` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 13: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.R`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
