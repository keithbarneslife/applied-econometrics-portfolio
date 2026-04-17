# Project 9: DiD by Hand

## Economic Question
None — this is pure method transparency. Build DiD from scratch.

## What You're Learning
The mechanics of difference-in-differences: four means, one double difference, one regression.

## Before You Start
Read *The Effect*, Chapter 18 (Difference-in-Differences).

## R Packages Needed
```r
library(tidyverse)
```

---

## Session 1: Simulate and Compute (~30 min)

### Step 1: Create simulated data
```r
library(tidyverse)
set.seed(42)

n <- 200  # 200 units

df <- tibble(
  id = rep(1:n, each = 2),
  treated = rep(c(0, 1), each = n),    # first half control, second half treated
  post = rep(c(0, 1), times = n),       # two periods for each unit
  y = 5 + 2 * treated + 3 * post + 1.5 * treated * post + rnorm(2 * n)
)
```
The true treatment effect is **1.5** (the coefficient on `treated * post`). Let's recover it.

### Step 2: Compute the four cell means
```r
cell_means <- df %>%
  group_by(treated, post) %>%
  summarise(mean_y = mean(y), .groups = "drop")

print(cell_means)
```
You should see four rows: (treated=0, post=0), (treated=0, post=1), (treated=1, post=0), (treated=1, post=1).

### Step 3: Compute DiD manually
```r
# Extract the four means
m00 <- cell_means %>% filter(treated == 0, post == 0) %>% pull(mean_y)
m01 <- cell_means %>% filter(treated == 0, post == 1) %>% pull(mean_y)
m10 <- cell_means %>% filter(treated == 1, post == 0) %>% pull(mean_y)
m11 <- cell_means %>% filter(treated == 1, post == 1) %>% pull(mean_y)

did_manual <- (m11 - m10) - (m01 - m00)
cat("Manual DiD estimate:", did_manual, "\n")
```
This should be approximately 1.5 (not exactly, because of the random noise).

### Step 4: Verify with regression
```r
did_reg <- lm(y ~ treated + post + treated:post, data = df)
summary(did_reg)
```
The coefficient on `treated:post` should **exactly equal** your manual DiD estimate. This proves that DiD is just a regression with group and time indicators plus their interaction.

### Step 5: Visualise
```r
ggplot(cell_means, aes(x = factor(post), y = mean_y,
                        colour = factor(treated), group = treated)) +
  geom_point(size = 4) +
  geom_line(linewidth = 1) +
  labs(
    title = "Difference-in-Differences: 2x2 Design",
    subtitle = paste("DiD estimate:", round(did_manual, 3)),
    x = "Period (0 = Before, 1 = After)",
    y = "Mean Outcome",
    colour = "Group"
  ) +
  scale_colour_manual(values = c("0" = "grey50", "1" = "steelblue"),
                      labels = c("Control", "Treated")) +
  theme_minimal()
```

---

## Session 2: Break the Assumptions (~20 min)

### Step 1: Violate parallel trends
```r
# Add a differential pre-trend: treated group was already growing faster
df_broken <- tibble(
  id = rep(1:n, each = 2),
  treated = rep(c(0, 1), each = n),
  post = rep(c(0, 1), times = n),
  y = 5 + 2 * treated + 3 * post + 1.5 * treated * post +
      2 * treated * post +  # <- THIS IS THE DIFFERENTIAL TREND (bias)
      rnorm(2 * n)
)

lm(y ~ treated + post + treated:post, data = df_broken)
```
The coefficient on the interaction is now biased — it picks up the real treatment effect PLUS the differential trend.

Write a note: *"DiD requires the parallel trends assumption. When it's violated, the estimator is biased. The bias equals the differential trend."*

**Save and commit: "Project 09: complete".**

---

## What "Done" Looks Like
- `simulation.R` with manual DiD, regression verification, the 2×2 plot, and a parallel trends violation exercise
- You can explain the parallel trends assumption and what happens when it fails

## Estimated Sessions: ~2
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `09-did-by-hand/simulation.R` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `simulation.R` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 09: [what you did this session]"`.

**Never copy from the webRios console back into `simulation.R`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
