# Project 11: Event Study Design

## Economic Question
How does a treatment effect evolve over time? Are pre-trends consistent with the parallel trends assumption?

## What You're Learning
Event study estimation with leads and lags, the modern standard for presenting DiD results.

## Before You Start
Read *The Effect*, Chapter 18 (event study section). Skim Goodman-Bacon (2021) for awareness of staggered treatment issues.

## R Packages Needed
```r
library(tidyverse)
library(fixest)
library(did)
```

---

## Session 1: Set Up and Estimate (~30 min)

### Step 1: Load example data with staggered treatment
```r
library(tidyverse)
library(fixest)
library(did)

data(mpdta)   # Minimum wage dataset from the did package
glimpse(mpdta)
```
Key variables: `lemp` (log employment), `first.treat` (year of treatment), `year`, `countyreal` (unit ID).

### Step 2: Create time-to-treatment variable
```r
mpdta <- mpdta %>%
  mutate(
    time_to_treat = ifelse(first.treat == 0, -Inf, year - first.treat)
  )
```
Units that are never treated get `-Inf` (they serve as controls throughout).

### Step 3: Estimate event study
```r
es <- feols(lemp ~ i(time_to_treat, ref = -1) | countyreal + year,
            data = mpdta %>% filter(is.finite(time_to_treat) | first.treat == 0),
            cluster = ~countyreal)
summary(es)
```
`i(time_to_treat, ref = -1)` creates a separate coefficient for each period relative to treatment, with t = -1 (one period before) as the reference (normalised to zero).

---

## Session 2: Plot and Interpret (~20 min)

### Step 1: Event study plot
```r
iplot(es,
      xlab = "Time to treatment",
      ylab = "Effect on log employment",
      main = "Event Study: Minimum Wage and Employment")
```
`iplot()` is a fixest convenience function that plots the event study coefficients with confidence intervals.

Alternatively, for more control:
```r
coefplot(es, keep = "time_to_treat")
```

### Step 2: Interpret
Look at the plot:
- **Pre-treatment coefficients (t < -1):** Should be close to zero and statistically insignificant. If they are, this supports the parallel trends assumption.
- **Post-treatment coefficients (t ≥ 0):** These trace out the dynamic treatment effect. Is the effect immediate? Does it grow? Does it fade?

```r
# INTERPRETATION
# Pre-treatment coefficients are [close to zero / trending / concerning].
# This [supports / raises doubts about] the parallel trends assumption.
#
# The treatment effect appears to be [immediate / gradual / growing / fading].
# By t+[X], the effect is approximately [Y] log points, equivalent to
# a [Y*100]% change in employment.
#
# AWARENESS: With staggered treatment timing, standard two-way FE can be
# biased because "already treated" units serve as controls for "newly treated"
# units (Goodman-Bacon, 2021). The did package addresses this.
```

---

## Session 3: Robustness (~20 min)

### Step 1: Try the Callaway-Sant'Anna estimator
```r
cs <- att_gt(yname = "lemp", tname = "year", idname = "countyreal",
             gname = "first.treat", data = mpdta)
summary(cs)
ggdid(cs)
```
This uses the robust estimator from Callaway & Sant'Anna (2021) that handles staggered treatment correctly.

**Save and commit: "Project 11: complete — Phase 2b done". Do calibration review.**

---

## What "Done" Looks Like
- `analysis.R` with event study estimation, an event study plot, and awareness of staggered treatment issues
- You can explain what pre-treatment coefficients near zero mean for identification

## Estimated Sessions: ~3
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `11-event-study/analysis.R` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.R` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 11: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.R`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
