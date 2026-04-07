# Project 7: First Fixed Effects Model

## Economic Question
Does the association between some economic variable and an outcome survive when we control for time-invariant country characteristics?

## What You're Learning
`feols()` in the `fixest` package. Entity fixed effects vs pooled OLS. Understanding what FE controls for and what it does not.

## Theory to Read
*The Effect*, Chapter 16 (Fixed Effects) — full chapter. Key concepts: the within-estimator, what FE eliminates (all time-invariant unobservables), what it does NOT eliminate (time-varying confounders). The Mundlak insight: FE is equivalent to including group means as controls.

## Data Source
Penn World Tables 10.01 (same as Project 6).

## R Packages Needed
`tidyverse`, `fixest`, `modelsummary`, `pwt10`

## Steps

### Session 1: Pooled OLS
- Using your PWT panel, run a pooled OLS ignoring panel structure:
  `lm(gdp_growth ~ human_capital + trade_openness, data = pwt)`
- This treats all country-year observations as independent. What's wrong with that?

### Session 2: Entity fixed effects
- Run the same model with country fixed effects:
  `feols(gdp_growth ~ human_capital + trade_openness | country, data = pwt)`
- Compare coefficients to the pooled OLS. *They will differ.* The FE absorbed all time-invariant differences between countries (geography, colonial history, culture...)
- Why did the coefficient change? What was the FE absorbing?

### Session 3: Compare and present
- Add year fixed effects (two-way FE):
  `feols(gdp_growth ~ human_capital | country + year, data = pwt)`
- Produce a regression table with `modelsummary` showing pooled OLS, entity FE, and two-way FE side by side
- Cluster standard errors by country: `feols(..., cluster = ~country)`

## What "Done" Looks Like
- R Markdown with pooled OLS, entity FE, and two-way FE specifications compared
- You can explain what the `|` operator does in `feols()` and why the coefficients changed
- You can state the strict exogeneity assumption and what it requires

## Estimated Sessions: ~3
