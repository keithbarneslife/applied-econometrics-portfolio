# Project 10: Card & Krueger Minimum Wage Replication

## Economic Question
Did New Jersey's 1992 minimum wage increase reduce employment in the fast-food sector?

## What You're Learning
DiD with real data, parallel pre-trends, and interpreting results through economic theory (competitive vs monopsony labour markets).

## Before You Start
Read or skim Card & Krueger (1994), AER 84(4). Also re-read *The Effect*, Chapter 18.

## R Packages Needed
```r
library(tidyverse)
library(fixest)
library(modelsummary)
library(wooldridge)
```

---

## Session 1: Explore the Data (~20 min)

### Step 1: Load the data
```r
library(tidyverse)
library(wooldridge)
data("njmin3")

glimpse(njmin3)
```
Key variables: `fte` (full-time equivalent employment), `nj` (1 = New Jersey, 0 = Pennsylvania), `d` (1 = after the minimum wage increase), `wage_st` (starting wage).

### Step 2: Compute the four cell means
```r
njmin3 %>%
  group_by(nj, d) %>%
  summarise(mean_fte = mean(fte, na.rm = TRUE), n = n(), .groups = "drop")
```
This is your 2×2 table. Compute DiD manually:
```r
means <- njmin3 %>%
  group_by(nj, d) %>%
  summarise(m = mean(fte, na.rm = TRUE), .groups = "drop")

did <- (means$m[means$nj==1 & means$d==1] - means$m[means$nj==1 & means$d==0]) -
       (means$m[means$nj==0 & means$d==1] - means$m[means$nj==0 & means$d==0])
cat("Manual DiD:", did, "\n")
```

---

## Session 2: Estimate (~20 min)

### Step 1: DiD regression
```r
library(fixest)
m_did <- feols(fte ~ nj * d, data = njmin3)
summary(m_did)
```
The coefficient on `nj:d` is the DiD estimate — the effect of NJ's minimum wage increase on employment. Check it matches your manual calculation.

### Step 2: With controls
```r
m_did2 <- feols(fte ~ nj * d + kfc + roys + wendys, data = njmin3)
summary(m_did2)
```
Adding chain dummies as controls. Does the DiD estimate change much?

---

## Session 3: Interpret (~30 min)

### Step 1: Visualise
```r
ggplot(means, aes(x = factor(d), y = m, colour = factor(nj), group = nj)) +
  geom_point(size = 4) + geom_line(linewidth = 1) +
  scale_colour_manual(values = c("0" = "grey50", "1" = "steelblue"),
                      labels = c("Pennsylvania", "New Jersey")) +
  labs(title = "Card & Krueger: Fast-Food Employment Before/After",
       x = "Period (0 = Before, 1 = After)", y = "Mean FTE Employment",
       colour = "") +
  theme_minimal()
```

### Step 2: Regression table
```r
library(modelsummary)
modelsummary(list("Basic DiD" = m_did, "With Controls" = m_did2),
             stars = c("***" = 0.01, "**" = 0.05, "*" = 0.1))
```

### Step 3: Economic interpretation
```r
# The standard competitive model predicts: minimum wage ↑ → employment ↓
# Card & Krueger found: no decrease, possibly an increase.
#
# The monopsony model explains this: when a single employer (or few employers)
# dominate the local labour market, they set wages below the competitive level.
# A minimum wage forces wages up toward the competitive equilibrium, which can
# INCREASE employment (moving along the labour supply curve).
#
# This paper was revolutionary because it used a quasi-experimental design
# (NJ vs PA as a natural experiment) to challenge textbook predictions.
```

**Save and commit: "Project 10: complete".**

---

## What "Done" Looks Like
- `analysis.R` replicating Card & Krueger's main DiD result
- 2×2 plot and regression table
- Written economic interpretation connecting results to theory

## Estimated Sessions: ~4
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `10-card-krueger-replication/analysis.R` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.R` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 10: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.R`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
