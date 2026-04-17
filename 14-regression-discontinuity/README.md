# Project 14: Regression Discontinuity — Lee (2008)

## Economic Question
Does winning an election by a tiny margin give the incumbent party an advantage next time?

## What You're Learning
RD design, `rdrobust` package, bandwidth selection, and RD plots.

## Before You Start
Read *The Effect*, Chapter 20 (Regression Discontinuity).

## R Packages Needed
```r
library(tidyverse)
library(rdrobust)
```

---

## Session 1: Visualise the Discontinuity (~30 min)

### Step 1: Load built-in data
```r
library(tidyverse)
library(rdrobust)

data(rdrobust_RDsenate)
# This gives you two vectors: R (running variable: vote margin) and Y (outcome: next-election vote share)

rd_data <- tibble(margin = R, vote = Y)
glimpse(rd_data)
```

### Step 2: Scatter plot
```r
ggplot(rd_data, aes(x = margin, y = vote)) +
  geom_point(alpha = 0.3, size = 0.8) +
  geom_vline(xintercept = 0, colour = "red", linetype = "dashed") +
  labs(title = "RD Plot: US Senate Elections",
       x = "Vote margin at t (positive = won)",
       y = "Vote share at t+1") +
  theme_minimal()
```
You should see a visible jump at margin = 0. Candidates who *barely* won do better next time than candidates who *barely* lost. The jump at the threshold is the causal effect of incumbency.

### Step 3: Official RD plot with binning
```r
rdplot(y = rd_data$vote, x = rd_data$margin,
       title = "RD Plot: Incumbency Advantage",
       x.label = "Vote margin", y.label = "Next-election vote share")
```
`rdplot()` bins the data and fits separate polynomials on each side of the cutoff. The discontinuity should be visually clear.

---

## Session 2: Estimate (~20 min)

### Step 1: Run rdrobust
```r
rd_result <- rdrobust(y = rd_data$vote, x = rd_data$margin)
summary(rd_result)
```
Key output:
- **Coef:** The estimated treatment effect at the threshold
- **Robust CI:** The confidence interval using bias-corrected methods
- **BW:** The bandwidth selected by the data-driven procedure
- **N:** The effective sample size within the bandwidth

### Step 2: Try different bandwidths
```r
rd_narrow <- rdrobust(y = rd_data$vote, x = rd_data$margin, h = 5)
rd_wide <- rdrobust(y = rd_data$vote, x = rd_data$margin, h = 15)

cat("Narrow bandwidth (h=5):", rd_narrow$coef[1], "\n")
cat("Default bandwidth:", rd_result$coef[1], "\n")
cat("Wide bandwidth (h=15):", rd_wide$coef[1], "\n")
```
The estimate should be fairly stable across bandwidths. If it changes dramatically, the design may be fragile.

---

## Session 3: Robustness and Write-Up (~20 min)

### Step 1: Placebo test — fake cutoffs
```r
rd_placebo5 <- rdrobust(y = rd_data$vote, x = rd_data$margin, c = 5)
rd_placebo_neg5 <- rdrobust(y = rd_data$vote, x = rd_data$margin, c = -5)

cat("Placebo at +5:", rd_placebo5$coef[1], "p =", rd_placebo5$pv[1], "\n")
cat("Placebo at -5:", rd_placebo_neg5$coef[1], "p =", rd_placebo_neg5$pv[1], "\n")
```
There should be NO discontinuity at fake cutoffs. If there is, something is wrong with the design.

### Step 2: Density test (McCrary test)
```r
rddensity::rddensity(rd_data$margin) %>% summary()
```
If this is significant, there may be manipulation around the threshold (candidates engineering narrow wins). You'll need to install `rddensity` if not already present.

### Step 3: Write-up
```r
# The RD estimate of the incumbency advantage is approximately [X] percentage
# points, meaning barely winning an election causes a [X] pp increase in
# vote share in the next election.
#
# The identification relies on the continuity assumption: candidates just
# above and just below the 50% threshold are comparable in all respects
# except for winning/losing. This is plausible because at very narrow margins,
# the outcome is essentially random.
#
# PHASE 2 COMPLETE. Full calibration review before Phase 3.
```

**Save and commit: "Project 14: complete — Phase 2 done".**

---

## What "Done" Looks Like
- `analysis.R` with RD plot, rdrobust estimation, placebo tests, and written interpretation
- You can explain the continuity assumption and bandwidth selection
- **All four causal inference methods learned.** Calibration review in `reviews/phase2cd-calibration.md`.

## Estimated Sessions: ~3
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `14-regression-discontinuity/analysis.R` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.R` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 14: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.R`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
