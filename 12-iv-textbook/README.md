# Project 12: IV — Textbook Example

## Economic Question
What is the causal effect of institutional quality on economic development? (Acemoglu, Johnson & Robinson, 2001)

## What You're Learning
Two-stage least squares (2SLS), first-stage diagnostics, instrument relevance, and the LATE interpretation.

## Theory to Read
*The Effect*, Chapter 19 (Instrumental Variables). Key concepts: the exclusion restriction, the relevance condition, the LATE interpretation (Imbens & Angrist, 1994).

**Maths thread:** Before starting, work through the Asymptotic Theory section of `docs/maths-foundations.md`. You need to understand consistency, probability limits, and plim(β̂_OLS) = β + Cov(X,ε)/Var(X) — this is *why* we need IV.

## Data Source
**Acemoglu, Johnson & Robinson (2001)** replication data:
- Daron Acemoglu's data archive: https://economics.mit.edu/people/faculty/daron-acemoglu/data-archive
- Download the AER 2001 dataset (often called `maketable5.dta` or similar)
- Use `haven::read_dta()` to import the Stata file

## R Packages Needed
`tidyverse`, `fixest`, `modelsummary`, `haven`

## Steps

### Session 1: Understand the paper
- Read (or skim) AJR (2001). The argument: settler mortality → institutional quality → GDP today. Settler mortality is the instrument for institutions.
- Load the data. Examine key variables: log GDP per capita, expropriation risk (institutions), log settler mortality (instrument)

### Session 2: First stage
- Run the first stage: `feols(institutions ~ log_settler_mortality, data = ajr)`
- Check the F-statistic. Is it above 10? (Relevance condition)
- Plot: scatter of settler mortality vs institutional quality

### Session 3: 2SLS
- Run 2SLS: `feols(log_gdp ~ 1 | institutions ~ log_settler_mortality, data = ajr)`
- Compare to OLS: `feols(log_gdp ~ institutions, data = ajr)`
- The IV estimate should be *larger* than OLS. Why? (Attenuation bias from measurement error in institutions, or OLS bias from reverse causality)

### Session 4: Interpret
- Discuss the exclusion restriction: does settler mortality affect GDP *only* through institutions? What are the threats? (Direct effect of disease environment, selective migration, etc.)
- Discuss LATE: IV estimates the effect for "compliers" only. Who are the compliers here?
- Produce a clean table comparing OLS and IV estimates

## What "Done" Looks Like
- R Markdown replicating AJR's main IV result, with first-stage diagnostics and a critical discussion of the exclusion restriction
- You can explain when IV is needed, what LATE means, and what makes an instrument valid or invalid

## Estimated Sessions: ~4
