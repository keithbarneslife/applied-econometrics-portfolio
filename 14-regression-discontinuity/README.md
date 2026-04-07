# Project 14: Regression Discontinuity

## Economic Question
Does winning an election by a tiny margin give the incumbent party an advantage in the next election? (Lee, 2008)

## What You're Learning
RD design: the logic of local randomisation at a threshold, bandwidth selection, and the `rdrobust` package. The beauty of RD is that the causal logic is visual.

## Theory to Read
*The Effect*, Chapter 20 (Regression Discontinuity). Key concepts: sharp vs fuzzy RD, bandwidth selection (the bias-variance trade-off), the continuity assumption.

## Data Source
**Lee (2008)** data is built into the `rdrobust` package:
```r
install.packages("rdrobust")
library(rdrobust)
data(rdrobust_RDsenate)
```
Variables: `margin` (running variable: vote margin), `vote` (outcome: vote share in next election)

## R Packages Needed
`tidyverse`, `rdrobust`

## Steps

### Session 1: Visualise
- Plot `vote` (next election outcome) against `margin` (current election margin)
- Add a vertical line at the threshold (margin = 0)
- The discontinuity should be visually obvious: a jump in the outcome at the threshold
- Use `rdplot()` from rdrobust for the binned scatter plot: `rdplot(y = vote, x = margin)`

### Session 2: Estimate
- Run: `rdrobust(y = vote, x = margin)`
- Interpret the output: the local treatment effect at the threshold, the bandwidth chosen, the confidence interval
- Try different bandwidths manually to see how the estimate changes

### Session 3: Robustness and write-up
- Placebo test: is there a discontinuity at fake thresholds (e.g., margin = 5 or margin = -5)?
- Density test: is there bunching of observations just above or below the threshold? (McCrary test — evidence of manipulation)
- Write up: explain the RD logic in plain language. Why is "just above" vs "just below" a plausible comparison?
- **This completes Phase 2.** Do a full calibration review before starting Phase 3.

## What "Done" Looks Like
- R Markdown with RD plot, rdrobust estimation, placebo tests, and written interpretation
- You can explain the continuity assumption and why RD provides a credible causal estimate near the threshold
- **14 projects on GitHub.** The causal inference toolkit is complete.

## Estimated Sessions: ~3
