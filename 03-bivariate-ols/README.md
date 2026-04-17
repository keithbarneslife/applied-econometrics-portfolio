# Project 3: Bivariate OLS

## Economic Question
Is national income associated with financial inclusion? What does the slope coefficient mean — and what can it *not* tell you?

## What You're Learning
`lm()` for simple OLS. Interpreting regression output. Understanding what OLS estimates and why this particular regression is not causal.

## Before You Start
- Read *The Effect*, Chapters 6–7 (Causal Diagrams). ~45 min.
- **Maths thread:** Work through Expected Values and Variance/Covariance in `docs/maths-foundations.md`. Key identity: the OLS slope is β = Cov(X,Y) / Var(X).

## R Packages Needed
```r
library(tidyverse)
library(WDI)
```

---

## Session 1: Estimate (~30 min)

### Step 1: Rebuild your dataset
Run the code from Project 2, Sessions 1–2, to get `findex_clean` in memory. You need the merged dataset with `account`, `gdp_pc`, `literacy`, `urban`, and `income_group`.

If you saved Project 2's code properly, you can paste and run it all at once.

### Step 2: Run a bivariate regression
```r
model1 <- lm(account ~ gdp_pc, data = findex_clean)
```
That's it. `lm()` = linear model. This estimates: account = β₀ + β₁·gdp_pc + ε

### Step 3: Examine the output
```r
summary(model1)
```
You'll see several things:
- **Coefficients table:** The `(Intercept)` is β₀ (predicted account ownership when GDP = 0). `gdp_pc` is β₁ (the slope).
- **Estimate column:** The point estimates of β₀ and β₁.
- **Std. Error:** The standard error of each estimate.
- **t value:** Estimate / Std. Error.
- **Pr(>|t|):** The p-value. Stars indicate significance levels.
- **R-squared:** How much of the variation in `account` is explained by `gdp_pc` alone.

### Step 4: Interpret the coefficient
Write down the coefficient on `gdp_pc`. Suppose it's 0.0015. That means:

> "A one-dollar increase in GDP per capita is associated with a 0.0015 percentage-point increase in financial account ownership."

That's a small number because GDP is measured in dollars and account ownership in percentages. This is why economists often use logs — we'll get to that in Project 5.

### Step 5: Verify by hand
The OLS slope is β₁ = Cov(X,Y) / Var(X). Check:
```r
cov(findex_clean$gdp_pc, findex_clean$account, use = "complete.obs") /
  var(findex_clean$gdp_pc, na.rm = TRUE)
```
This should match the coefficient from `summary(model1)` exactly. You've just proved to yourself that `lm()` computes exactly what the formula says.

**Save and commit.**

---

## Session 2: Visualise and Interpret (~30 min)

### Step 1: Scatter plot with regression line
```r
ggplot(findex_clean, aes(x = gdp_pc, y = account)) +
  geom_point(alpha = 0.5, colour = "grey40") +
  geom_smooth(method = "lm", se = TRUE, colour = "steelblue") +
  labs(
    title = "GDP per Capita and Financial Account Ownership",
    subtitle = "OLS fitted line with 95% confidence band",
    x = "GDP per capita (constant 2015 US$)",
    y = "Account ownership (% of adults)"
  ) +
  theme_minimal()
```
`geom_smooth(method = "lm")` overlays the regression line. `se = TRUE` shows the confidence band.

### Step 2: Why this is NOT a causal estimate
Think about this: countries with higher GDP also tend to have better education, stronger institutions, more urbanisation, and more developed banking infrastructure. Any of these could independently cause higher financial inclusion.

The coefficient on `gdp_pc` captures ALL of these channels mixed together. It is an association, not a causal effect.

On paper (or in your head), sketch a DAG:
```
                Education
               /         \
GDP per capita --→ Account Ownership
               \         /
             Institutions
```
GDP, education, and institutions all affect each other AND account ownership. Without controlling for these confounders, our coefficient is biased. This is omitted variable bias, which is Project 4's topic.

### Step 3: Write a paragraph
In your `analysis.R` file, add a comment block:
```r
# INTERPRETATION
# The coefficient on gdp_pc is [X], meaning a one-dollar increase in GDP
# per capita is associated with a [X] percentage-point increase in account
# ownership. However, this does NOT estimate a causal effect because:
#
# 1. Omitted variables: countries with higher GDP also have better education,
#    institutions, and infrastructure, all of which independently affect
#    financial inclusion.
#
# 2. Reverse causality: financial inclusion may itself promote economic growth,
#    meaning the direction of causation is ambiguous.
#
# The R-squared is [X], meaning GDP per capita alone explains [X]% of the
# cross-country variation in financial inclusion.
```

Fill in the actual numbers from your output.

**Save and commit: "Project 03: complete".**

---

## What "Done" Looks Like
- `analysis.R` with the regression, the manual Cov/Var verification, the scatter plot, and a written interpretation
- You can explain what the conditional expectation function is
- You can give at least two reasons why this regression is not causal

## Estimated Sessions: ~2
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `03-bivariate-ols/analysis.R` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.R` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 03: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.R`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
