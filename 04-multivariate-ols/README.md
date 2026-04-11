# Project 4: Multivariate OLS — Adding Controls

## Economic Question
How much of the GDP–financial inclusion association survives when we control for observable confounders?

## What You're Learning
Multiple regression, robust standard errors, and omitted variable bias as a visible phenomenon.

## Before You Start
Read *The Effect*, Chapters 8–9. Key concept: omitted variable bias formula: bias = (effect of omitted variable on Y) × (correlation of omitted variable with X).

## R Packages Needed
```r
library(tidyverse)
library(WDI)
library(sandwich)
library(lmtest)
```

---

## Session 1: Add Controls (~30 min)

### Step 1: Rebuild your dataset
Run the code from Projects 1–2 to get `findex_clean` with `account`, `gdp_pc`, `literacy`, `urban`.

### Step 2: Check you have enough data
Some countries may be missing literacy or urbanisation data. Check:
```r
findex_clean %>%
  summarise(
    n_total = n(),
    n_complete = sum(complete.cases(account, gdp_pc, literacy, urban))
  )
```
If the complete-case count is much smaller than the total, you'll lose observations when adding controls. That's normal and fine, but worth noting.

### Step 3: Run three nested models
```r
# Model 1: GDP only (same as Project 3)
m1 <- lm(account ~ gdp_pc, data = findex_clean)

# Model 2: Add literacy and urbanisation
m2 <- lm(account ~ gdp_pc + literacy + urban, data = findex_clean)

# Model 3: Add all controls including income group
m3 <- lm(account ~ gdp_pc + literacy + urban + income_group, data = findex_clean)
```

### Step 4: Compare the GDP coefficient across models
```r
coef(m1)["gdp_pc"]
coef(m2)["gdp_pc"]
coef(m3)["gdp_pc"]
```

**The coefficient should change.** Write down the three values. If the GDP coefficient gets smaller when you add controls, that means part of what looked like a GDP effect was actually driven by education or urbanisation. This is omitted variable bias made visible.

### Step 5: Look at full summaries
```r
summary(m2)
```
Check: which controls are statistically significant? Does R-squared increase meaningfully from m1 to m2?

**Save and commit.**

---

## Session 2: Robust Standard Errors (~20 min)

### Step 1: Why robust standard errors?
OLS assumes homoskedasticity (constant variance of errors). If this is violated — and in cross-country data it almost always is — the standard errors from `summary()` are wrong. Robust standard errors fix this.

### Step 2: Apply robust SEs
```r
library(sandwich)
library(lmtest)

coeftest(m2, vcov = vcovHC(m2, type = "HC1"))
```
`vcovHC()` computes a heteroskedasticity-consistent covariance matrix. `HC1` is the version that matches Stata's default `robust` option.

### Step 3: Compare
```r
# Default SEs
summary(m2)$coefficients[, "Std. Error"]

# Robust SEs
coeftest(m2, vcov = vcovHC(m2, type = "HC1"))[, "Std. Error"]
```
Are the robust SEs larger or smaller? If they're meaningfully different, heteroskedasticity is present. Are any coefficients that were significant before now insignificant (or vice versa)?

**Save and commit.**

---

## Session 3: Interpret (~20 min)

### Step 1: Coefficient plot
Visualise how the GDP coefficient changes across specifications:
```r
results <- tibble(
  model = c("Bivariate", "With controls", "With income group"),
  estimate = c(coef(m1)["gdp_pc"], coef(m2)["gdp_pc"], coef(m3)["gdp_pc"]),
  se = c(
    summary(m1)$coefficients["gdp_pc", "Std. Error"],
    summary(m2)$coefficients["gdp_pc", "Std. Error"],
    summary(m3)$coefficients["gdp_pc", "Std. Error"]
  )
)

ggplot(results, aes(x = model, y = estimate)) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = estimate - 1.96*se, ymax = estimate + 1.96*se), width = 0.1) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey50") +
  labs(
    title = "GDP Coefficient Across Specifications",
    y = "Coefficient on GDP per capita",
    x = ""
  ) +
  theme_minimal()
```

### Step 2: Write your interpretation
Add a comment block to your code:
```r
# INTERPRETATION
# The GDP coefficient drops from [X] in the bivariate model to [Y] when
# controls are added. This means roughly [Z]% of the apparent GDP effect
# was actually driven by [literacy/urbanisation/institutions].
#
# The omitted variable bias formula explains this:
# bias = (effect of literacy on account) × (correlation of literacy with GDP)
# Both terms are positive, so the omitted variable biased the GDP coefficient
# upward in the bivariate model.
```

**Save and commit: "Project 04: complete".**

---

## What "Done" Looks Like
- `analysis.R` with 3 nested specifications, robust SEs, a coefficient plot, and a written interpretation
- You can explain the OVB formula and demonstrate it with your own results
- You understand why default and robust standard errors can differ

## Estimated Sessions: ~3

---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `04-multivariate-ols/`
4. Create `analysis.R` (tap + → New File), paste your code, save
5. Commit with a message like "Project 04: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.R` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
