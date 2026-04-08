# Project 4: Multivariate OLS — Adding Controls

## Economic Question
How much of the GDP–financial inclusion association survives when we control for observable confounders?

## What You're Learning
Multiple regression, robust standard errors, and omitted variable bias as a visible phenomenon. You will watch a coefficient change when you add controls, and understand *why* it changed.

## Theory to Read
*The Effect*, Chapters 8–9 (Regression and its properties). Key concept: omitted variable bias. The formula: bias = (effect of omitted variable on Y) × (correlation of omitted variable with X).

## Data Source
Same as Project 3, plus **Worldwide Governance Indicators** for institutional quality:
- Download from: https://www.worldbank.org/en/publication/worldwide-governance-indicators
- Key variable: Rule of Law index

Also add from WDI:
- `SE.ADT.LITR.ZS` — Adult literacy rate
- `SP.URB.TOTL.IN.ZS` — Urban population (% of total)

Use the `WDI` R package to pull these alongside GDP.

## R Packages Needed
`tidyverse`, `sandwich`, `lmtest`, `WDI`

## Steps

### Session 1: Add controls
- Pull additional WDI indicators and merge with your existing dataset
- Run Model 1: `lm(account ~ gdp_pc, data = df)` (same as Project 3)
- Run Model 2: `lm(account ~ gdp_pc + literacy + urbanisation, data = df)`
- Run Model 3: `lm(account ~ gdp_pc + literacy + urbanisation + rule_of_law, data = df)`
- Compare the coefficient on `gdp_pc` across all three. *It should change.* Why?

### Session 2: Robust standard errors
- Install/load `sandwich` and `lmtest`
- Run: `coeftest(model3, vcov = vcovHC(model3, type = "HC1"))`
- Compare standard errors with and without robust correction. Are any conclusions affected?

### Session 3: Interpret
- Write up: which controls mattered most? What does the change in the GDP coefficient tell you about omitted variable bias?
- Produce a coefficient plot showing how the GDP coefficient shifts across specifications

## What "Done" Looks Like
- R Markdown with at least 3 nested specifications, robust standard errors, and a written interpretation of omitted variable bias
- You can explain the OVB formula and demonstrate it with your own results

## Estimated Sessions: ~3


---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `04-multivariate-ols/`
4. Create `analysis.Rmd` (tap + → New File), paste your code, save
5. Commit with a message like "Project 04: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.Rmd` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
