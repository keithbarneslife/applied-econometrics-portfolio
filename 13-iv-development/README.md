# Project 13: IV in Development Economics

## Economic Question
Do economic shocks cause civil conflict? (Miguel, Satyanath & Sergenti, 2004)

## What You're Learning
Applying IV in a development context and *critically assessing* instrument validity. The meta-question is: how convincing is this instrument?

## Theory to Read
Skim the original paper: Miguel, E., Satyanath, S. & Sergenti, E. (2004). "Economic Shocks and Civil Conflict: An Instrumental Variables Approach." *Journal of Political Economy*, 112(4), 725–753.

Also read the critiques — this paper's instrument (rainfall) has been widely debated. Understanding *why* is the point of this project.

## Data Source
**Miguel, Satyanath & Sergenti (2004)** replication files:
- Edward Miguel's website: https://emiguel.econ.berkeley.edu/research/
- Look for "Economic Shocks and Civil Conflict" replication data

## R Packages Needed
`tidyverse`, `fixest`, `modelsummary`, `haven`

## Steps

### Session 1: Data and first stage
- Load the replication data
- Run the first stage: does rainfall predict GDP growth in African countries?
- Check instrument relevance (F-statistic)

### Session 2: 2SLS
- Run 2SLS: `feols(conflict ~ 1 | gdp_growth ~ rainfall, data = panel)`
- Compare to OLS. How do they differ?
- Add country and year fixed effects

### Session 3: Critical assessment
- This is the most important session. Ask yourself:
  - Does rainfall affect conflict *only* through GDP growth? Or could it affect conflict directly (e.g., through agricultural competition, migration, water scarcity)?
  - Is rainfall truly exogenous? (Climate change, long-run adaptation)
  - What is the LATE here? For which countries/years does rainfall actually shift GDP growth?
- Write a structured critique of the exclusion restriction

### Session 4: Write up
- Produce regression table and write-up
- The critical assessment is the centrepiece, not the regression output

## What "Done" Looks Like
- R Markdown with IV replication AND a substantive written critique of the instrument
- You can explain why "rainfall as instrument" is both appealing and problematic
- **This completes Phase 2c.** Consider whether you need a calibration review.

## Estimated Sessions: ~4
