# Project 12: IV — Acemoglu, Johnson & Robinson (2001)

## Economic Question
What is the causal effect of institutional quality on economic development?

## What You're Learning
Two-stage least squares, first-stage diagnostics, the exclusion restriction, and the LATE interpretation.

## Before You Start
- Read *The Effect*, Chapter 19 (Instrumental Variables).
- **Maths thread:** Work through the Asymptotic Theory section of `docs/maths-foundations.md`. Key result: plim(β̂_OLS) = β + Cov(X,ε)/Var(X). If Cov(X,ε) ≠ 0, OLS is inconsistent. This is why we need IV.
- Skim AJR (2001), AER 91(5), at least the introduction and main results.

## R Packages Needed
```r
library(tidyverse)
library(fixest)
library(modelsummary)
library(haven)
```

---

## Session 1: Get Data and Understand the Paper (~30 min)

### Step 1: Download the data
Go to Daron Acemoglu's data archive: https://economics.mit.edu/people/faculty/daron-acemoglu/data-archive

Find the AER 2001 replication files. Download the Stata data file (usually `maketable5.dta` or similar).

Save it somewhere accessible. In webRios:
```r
library(tidyverse)
library(haven)

ajr <- read_dta("maketable5.dta")  # adjust filename as needed
glimpse(ajr)
```

If the file has different variable names, look for:
- `logpgp95` — log GDP per capita in 1995 (outcome)
- `avexpr` — average expropriation risk 1985–1995 (endogenous variable, measures institutions)
- `logem4` — log settler mortality (instrument)

### Step 2: Explore
```r
ajr %>% select(shortnam, logpgp95, avexpr, logem4) %>% drop_na() %>%
  summary()
```

```r
ggplot(ajr, aes(x = logem4, y = avexpr)) +
  geom_point() + geom_smooth(method = "lm") +
  labs(title = "First Stage: Settler Mortality → Institutions",
       x = "Log settler mortality", y = "Expropriation risk") +
  theme_minimal()
```
Higher settler mortality → worse institutions (higher expropriation risk). This is the first stage relationship.

---

## Session 2: First Stage (~20 min)

### Step 1: Run the first stage
```r
library(fixest)

first_stage <- feols(avexpr ~ logem4, data = ajr)
summary(first_stage)
```
Check the F-statistic. Is it above 10? (The Stock-Yogo rule of thumb for instrument relevance.) You can compute it:
```r
fitstat(first_stage, "ivf")
# Or manually:
summary(first_stage)$fstatistic
```

### Step 2: Understand the instrument logic
The argument is:
1. Places where European settlers faced high mortality → settlers didn't stay → set up extractive institutions
2. Extractive institutions persist → worse property rights today → lower GDP
3. Settler mortality is plausibly exogenous to current GDP (it's determined by 18th-century disease environment)

The exclusion restriction: settler mortality affects GDP *only through* institutions. We'll critique this in Session 4.

---

## Session 3: 2SLS and Comparison (~30 min)

### Step 1: Run OLS (biased)
```r
m_ols <- feols(logpgp95 ~ avexpr, data = ajr)
```

### Step 2: Run 2SLS
```r
m_iv <- feols(logpgp95 ~ 1 | avexpr ~ logem4, data = ajr)
summary(m_iv)
```
In fixest syntax: `logpgp95 ~ 1 | avexpr ~ logem4` means "regress logpgp95 on avexpr, instrumenting avexpr with logem4." The `1` means no exogenous controls (just the intercept).

### Step 3: Compare
```r
library(modelsummary)
modelsummary(
  list("OLS" = m_ols, "IV (2SLS)" = m_iv),
  stars = c("***" = 0.01, "**" = 0.05, "*" = 0.1),
  title = "Institutions and Development: OLS vs IV"
)
```
The IV estimate is typically *larger* than OLS. Why? Measurement error in institutions (avexpr is a noisy proxy) attenuates OLS toward zero. IV corrects for this.

---

## Session 4: Critical Assessment (~20 min)

### Step 1: Critique the exclusion restriction
Ask yourself: does settler mortality affect GDP *only* through institutions?

Possible violations:
- Direct disease environment effect: places with high historical mortality may still have worse health outcomes, affecting GDP directly
- Selective migration: settler mortality affected *who* settled, which affects human capital, trade networks, culture — all of which could affect GDP independently of institutions
- Colonial infrastructure: settlers who stayed built roads, ports, schools — this affects GDP through channels other than expropriation risk

```r
# CRITICAL ASSESSMENT
# The exclusion restriction requires that settler mortality → GDP
# runs ONLY through institutional quality. Threats include:
#
# 1. [your assessment of each threat above]
# 2.
# 3.
#
# LATE interpretation: IV estimates the effect for "compliers" —
# countries whose institutional quality actually responds to settler
# mortality. Countries with institutions determined by other factors
# (e.g., resource endowments, geopolitics) are not compliers.
```

**Save and commit: "Project 12: complete".**

---

## What "Done" Looks Like
- `analysis.R` with first stage, 2SLS, OLS comparison, and a written critique of the exclusion restriction
- You can explain when IV is needed, what LATE means, and assess instrument validity

## Estimated Sessions: ~4

---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `12-iv-textbook/`
4. Create `analysis.R` (tap + → New File), paste your code, save
5. Commit with a message like "Project 12: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.R` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
