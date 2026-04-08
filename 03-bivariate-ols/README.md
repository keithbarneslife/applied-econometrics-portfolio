# Project 3: Bivariate OLS

## Economic Question
Is national income associated with financial inclusion? What does the slope coefficient mean in economic terms — and what can it *not* tell you?

## What You're Learning
`lm()` for simple OLS regression. Interpreting regression output. Understanding what OLS estimates (the conditional expectation function) and why this regression does not estimate a causal effect.

## Theory to Read
*The Effect*, Chapters 6–7 (Causal Diagrams and Drawing Causal Diagrams). These explain *why* a simple regression of Y on X doesn't estimate a causal effect when confounders exist. This is the conceptual foundation for everything that follows.

**Maths thread:** Before starting, work through the Expected Values and Variance/Covariance sections of `docs/maths-foundations.md`. You need to understand that the OLS slope is β = Cov(X,Y) / Var(X).

## Data Source
Same datasets from Projects 1 and 2, merged by country code. You already built this merged dataset in Project 2.

## R Packages Needed
`tidyverse`

## Steps

### Session 1: Estimate
- Merge your WDI and Findex datasets (if not already merged)
- Run: `model <- lm(account_ownership ~ gdp_per_capita, data = merged)`
- Examine: `summary(model)`
- Interpret the slope: "A one-unit increase in GDP per capita is associated with a ___-point increase in account ownership"

### Session 2: Visualise and interpret
- Scatter plot with fitted regression line: `geom_smooth(method = "lm")`
- Discuss: why does this NOT estimate a causal effect? Draw a DAG (on paper or using `ggdag` package) showing confounders (education, institutions, urbanisation) that affect both GDP and financial inclusion
- Write a paragraph explaining what the coefficient means and what it cannot tell you

## What "Done" Looks Like
- An R Markdown file with the regression, scatter + fitted line, and a written interpretation
- You can explain what the conditional expectation function is and why OLS estimates it
- You can articulate at least two reasons why this regression is not causal

## Estimated Sessions: ~2


---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `03-bivariate-ols/`
4. Create `analysis.Rmd` (tap + → New File), paste your code, save
5. Commit with a message like "Project 03: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.Rmd` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
