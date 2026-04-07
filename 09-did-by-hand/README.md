# Project 9: DiD by Hand

## Economic Question
None — this is pure method transparency. You will build a DiD estimator from scratch so there is nothing opaque about it when you apply it to real data.

## What You're Learning
The mechanics of difference-in-differences: two groups, two periods, four means, one double difference. Then verifying that a regression reproduces the same number.

## Theory to Read
*The Effect*, Chapter 18 (Difference-in-Differences). Key concept: the parallel trends assumption. DiD estimates the ATT *if and only if* the treated group's outcome would have followed the same trend as the control group absent treatment. This is untestable.

## Data Source
None — you will simulate data in R.

## R Packages Needed
`tidyverse`

## Steps

### Session 1: Simulate and compute manually
- Create a dataset with 200 observations: 100 treated, 100 control; 2 periods each
```r
set.seed(42)
n <- 100
df <- tibble(
  id = rep(1:(2*n), each = 2),
  treated = rep(c(0, 1), each = 2*n),
  post = rep(c(0, 1), times = 2*n),
  y = 5 + 2*treated + 3*post + 1.5*treated*post + rnorm(4*n)
)
```
- Compute the four cell means: E[Y | treated=0, post=0], E[Y | treated=0, post=1], E[Y | treated=1, post=0], E[Y | treated=1, post=1]
- Compute DiD manually: (mean_11 - mean_10) - (mean_01 - mean_00)
- The answer should be approximately 1.5 (the true treatment effect)

### Session 2: Verify with regression
- Run: `lm(y ~ treated + post + treated:post, data = df)`
- Confirm the coefficient on `treated:post` equals your manual DiD estimate
- Visualise: plot the four group means as a 2x2 diagram. Draw the counterfactual trend.
- Vary the simulation: what happens if you violate parallel trends (add a differential pre-trend)?

## What "Done" Looks Like
- R Markdown showing manual DiD computation, regression verification, and a visualisation of the 2x2 structure
- You can explain the parallel trends assumption and demonstrate what happens when it's violated

## Estimated Sessions: ~2
