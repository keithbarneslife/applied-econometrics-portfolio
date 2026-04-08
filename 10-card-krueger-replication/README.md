# Project 10: Card & Krueger Minimum Wage Replication

## Economic Question
Did New Jersey's 1992 minimum wage increase reduce employment in the fast-food sector?

## What You're Learning
Applying DiD to real data, visualising parallel pre-trends, and interpreting results as an economist. This is also a lesson in how empirical evidence can challenge simple theoretical predictions.

## Theory to Read
*The Effect*, Chapter 18 (continue). Also read (or skim) the original paper: Card, D. & Krueger, A. (1994). "Minimum Wages and Employment: A Case Study of the Fast-Food Industry in New Jersey and Pennsylvania." *American Economic Review*, 84(4), 772–793.

**Economic theory context:** The standard competitive labour market model predicts that a minimum wage above equilibrium reduces employment. Card & Krueger found the opposite. The monopsony model provides a theoretical framework where minimum wages *can* increase employment — when employers have wage-setting power. This is a beautiful example of theory and empirics in dialogue.

## Data Source
**`wooldridge` R package:**
```r
install.packages("wooldridge")
library(wooldridge)
data("njmin3")
```

Alternatively, data is available from David Card's UC Berkeley website.

## R Packages Needed
`tidyverse`, `fixest`, `modelsummary`, `wooldridge`

## Steps

### Session 1: Get data and explore
- Load `njmin3` dataset. Examine variables: state (NJ/PA), employment (FTE), wages, before/after
- Compute summary statistics by state × period
- Compute the four DiD cell means manually (as you did in Project 9)

### Session 2: Estimate
- Run the DiD regression: `feols(fte ~ nj + after + nj:after, data = njmin3)`
- Or equivalently: `feols(fte ~ i(nj, after), data = njmin3)`
- What is the estimated treatment effect? Is it statistically significant?
- Compare to Card & Krueger's published results

### Session 3: Pre-trends and robustness
- Visualise: plot average employment over time for NJ and PA. Do the pre-trends look parallel?
- Try alternative specifications: different control variables, different employment measures
- Produce a clean regression table with `modelsummary`

### Session 4: Write up
- Interpret the results economically. What does this tell us about the competitive vs monopsony model of labour markets?
- Discuss limitations: is this a clean natural experiment? What could threaten identification?

## What "Done" Looks Like
- R Markdown replicating Card & Krueger's main result with DiD, including pre-trend visualisation and economic interpretation
- You can explain the parallel trends assumption in this specific context

## Estimated Sessions: ~4


---

## Saving Your Work (iPad / webRios Workflow)

> See [WORKFLOW.md](../WORKFLOW.md) for full setup instructions.

1. Write and run your code in **webRios**
2. When done, copy your code
3. In **Working Copy**, navigate to `10-card-krueger-replication/`
4. Create `analysis.Rmd` (tap + → New File), paste your code, save
5. Commit with a message like "Project 10: [what you did this session]"
6. Push

**Files to create in this folder:**
- `analysis.Rmd` — your main analysis code
- `reflection.md` — fill in after completing the project (template in `docs/tracking.md`)
- Any exported plots (`.png`)
