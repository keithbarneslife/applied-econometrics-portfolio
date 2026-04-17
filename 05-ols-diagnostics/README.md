# Project 5: OLS Diagnostics and Professional Presentation

## Economic Question
Same as Project 4, now presented as a polished empirical analysis with diagnostic checks.

## What You're Learning
Residual diagnostics, functional form (logs vs levels), and `modelsummary` for publication-quality tables.

## Before You Start
- Read *The Effect*, Chapter 10 (skim — functional form section).
- Optional: Wooldridge Chapter 8 (Heteroskedasticity) for the formal Gauss-Markov treatment.

## R Packages Needed
```r
library(tidyverse)
library(WDI)
library(sandwich)
library(lmtest)
library(modelsummary)
```

---

## Session 1: Diagnostics (~30 min)

### Step 1: Rebuild your dataset and best model from Project 4
Run Projects 1–2 code to get `findex_clean`, then rerun `m2`:
```r
m2 <- lm(account ~ gdp_pc + literacy + urban, data = findex_clean)
```

### Step 2: Residual vs fitted plot
```r
plot(m2, which = 1)
```
This shows residuals (vertical axis) against fitted values (horizontal axis). Look for:
- **Fan shape** (residuals spread out as fitted values increase) → heteroskedasticity
- **Curve** (residuals are systematically positive then negative) → wrong functional form

### Step 3: Residuals vs each regressor
```r
findex_complete <- findex_clean %>% filter(complete.cases(account, gdp_pc, literacy, urban))
findex_complete$resid <- residuals(m2)

ggplot(findex_complete, aes(x = gdp_pc, y = resid)) +
  geom_point(alpha = 0.5) +
  geom_hline(yintercept = 0, colour = "red") +
  labs(title = "Residuals vs GDP per capita", y = "Residuals", x = "GDP per capita") +
  theme_minimal()
```
If you see a curve, the linear specification in GDP is wrong and you should try logs.

### Step 4: Formal heteroskedasticity test
```r
bptest(m2)
```
`bptest()` runs the Breusch-Pagan test. If the p-value is small (< 0.05), reject the null of homoskedasticity. This confirms you should use robust standard errors (which you already did in Project 4).

**Save and commit.**

---

## Session 2: Functional Form (~30 min)

### Step 1: Log-linear model
```r
m_log <- lm(account ~ log(gdp_pc) + literacy + urban, data = findex_clean)
summary(m_log)
```
Interpretation: "A 1% increase in GDP per capita is associated with a β₁/100 percentage-point increase in account ownership." Actually, since the dependent variable is in levels and the independent in logs, the interpretation is: "A 1% increase in GDP is associated with a β₁/100 percentage-point change in account ownership."

### Step 2: Log-log model
```r
m_loglog <- lm(log(account) ~ log(gdp_pc) + literacy + urban, data = findex_clean)
summary(m_loglog)
```
Now the coefficient is an elasticity: "A 1% increase in GDP per capita is associated with a β₁% increase in account ownership."

**Warning:** If any country has `account == 0`, `log(account)` will be `-Inf`. Check:
```r
sum(findex_clean$account == 0, na.rm = TRUE)
```
If there are zeros, you can use `log(account + 1)` or just exclude them.

### Step 3: Compare residual plots
```r
plot(m_log, which = 1)
```
Is this better behaved than the level-level model? If the curve has gone, the log specification is more appropriate.

**Save and commit.**

---

## Session 3: Professional Presentation (~30 min)

### Step 1: Multi-column regression table
```r
library(modelsummary)

modelsummary(
  list(
    "Bivariate" = lm(account ~ gdp_pc, data = findex_clean),
    "Controls" = m2,
    "Log GDP" = m_log,
    "Log-Log" = m_loglog
  ),
  stars = c("***" = 0.01, "**" = 0.05, "*" = 0.1),
  gof_map = c("nobs", "r.squared", "adj.r.squared"),
  title = "Financial Account Ownership: OLS Estimates"
)
```
This produces a table showing all four specifications side by side with standard errors, significance stars, and goodness-of-fit statistics. This is what a table in a published paper looks like.

### Step 2: Same table with robust SEs
```r
modelsummary(
  list("Controls" = m2, "Log GDP" = m_log),
  vcov = "HC1",
  stars = c("***" = 0.01, "**" = 0.05, "*" = 0.1),
  gof_map = c("nobs", "r.squared"),
  title = "With Robust Standard Errors"
)
```
`vcov = "HC1"` tells modelsummary to use robust standard errors automatically.

### Step 3: Write a brief summary
Add to your code:
```r
# SUMMARY
# The Breusch-Pagan test confirms heteroskedasticity (p = [X]).
# The log-linear specification is preferred: residuals are better behaved
# and the coefficient has a cleaner interpretation.
#
# After controlling for literacy and urbanisation with robust SEs,
# a 1% increase in GDP per capita is associated with a [Y] pp increase
# in financial account ownership.
#
# PHASE 1 COMPLETE. Do a calibration review before starting Phase 2.
# See docs/tracking.md for the template. Save in reviews/.
```

**Save and commit: "Project 05: complete — Phase 1 done".**

---

## What "Done" Looks Like
- `analysis.R` with diagnostics, log specifications, and a `modelsummary` table
- You understand the Gauss-Markov assumptions and what heteroskedasticity does to inference
- **Phase 1 is complete.** Create your calibration review in `reviews/phase1-calibration.md`.

## Estimated Sessions: ~3
---

## Workflow

Open `05-ols-diagnostics/analysis.R` in Working Copy, webRios alongside. Paste file contents into webRios to reload state. Write new commands in the file, copy over to webRios to run. Commit and push at the end.

See [WORKFLOW.md](../WORKFLOW.md) for the full version.
