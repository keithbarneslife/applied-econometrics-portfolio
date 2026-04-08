# Project 11: Event Study Design

## Economic Question
Depends on the paper/dataset chosen. The point is the dynamic structure: estimating period-by-period treatment effects rather than a single average.

## What You're Learning
Event study designs: leads and lags, dynamic treatment effects, and the modern standard for presenting DiD results. Also awareness of staggered treatment timing issues.

## Theory to Read
*The Effect*, Chapter 18 (the event study section). Also skim: Goodman-Bacon, A. (2021). "Difference-in-differences with variation in treatment timing." For awareness, not full comprehension.

## Data Source
**Option A (recommended):** Use the `did` R package example data:
```r
install.packages("did")
library(did)
data(mpdta)  # Minimum wage dataset with staggered adoption
```

**Option B:** Stevenson & Wolfers (2006) data on no-fault divorce laws — widely available online.

## R Packages Needed
`tidyverse`, `fixest`

## Steps

### Session 1: Set up the event study
- Using `fixest`, estimate an event study with leads and lags:
```r
feols(y ~ i(time_to_treat, ref = -1) | unit + year, data = df, cluster = ~unit)
```
- `i()` creates indicator variables for each period relative to treatment
- `ref = -1` sets the period just before treatment as the reference (normalised to zero)

### Session 2: Plot
- Use `coefplot()` from fixest or extract coefficients and plot with ggplot2
- Pre-treatment coefficients should be statistically indistinguishable from zero (supporting parallel trends)
- Post-treatment coefficients trace out the dynamic treatment effect

### Session 3: Interpret
- Do the pre-trends support the parallel trends assumption?
- Is the treatment effect immediate or gradual? Does it persist or fade?
- Write a brief note on staggered treatment timing: why does it complicate standard two-way FE?
- **This completes Phase 2b.** Do a calibration review.

## What "Done" Looks Like
- R Markdown with an event study estimation and a clean event study plot with confidence intervals
- You can explain what pre-treatment coefficients near zero mean for identification

## Estimated Sessions: ~3


---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `11-event-study/`
4. Create `analysis.Rmd` (tap + → New File), paste your code, save
5. Commit with a message like "Project 11: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.Rmd` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
