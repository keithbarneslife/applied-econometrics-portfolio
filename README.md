# Applied Econometrics Portfolio

## What This Is

A structured portfolio of 16 applied econometric projects in R, progressing from foundational data manipulation through to independent empirical research. Each project addresses a real economic question using real data, applying a specific econometric method grounded in the theory that justifies it.

This is not a collection of textbook exercises. It is a deliberate, sequenced programme designed to rebuild and deepen quantitative skills, producing a body of work that demonstrates both economic reasoning and technical implementation.

## Why It Exists

I am a public sector economist with an MSc in Applied Economics. My master's dissertation applied panel econometric methods to assess the impact of EU structural funds on regional GDP convergence. Since completing my MSc, I have worked in international economic policy: macroeconomic and financial stability analysis, programme design and evaluation, cross-country policy research, and representing my government in multilateral fora. That work has been analytically demanding, but has not required hands-on econometric implementation.

Several years on, I recognise that the gap between the causal inference theory I learned during my MSc and my ability to implement it in code has widened to the point where it constrains my professional development and my capacity to engage with the quantitative frontier of economics. This repository is the systematic response to that problem.

It aims to:

1. **Rebuild practical econometric skills** — reconnecting causal inference theory with executable code in R, so I can independently implement and interpret the standard identification strategies used in modern applied economics: OLS, panel fixed effects, difference-in-differences, instrumental variables, and regression discontinuity.

2. **Build a demonstrable portfolio** — providing concrete, public evidence of active and recent engagement with quantitative methods. Each project shows the economic reasoning alongside the technical implementation, not just code but the thinking behind it.

3. **Prepare for doctoral study** — I am preparing to begin a part-time PhD in Economics. The programme includes a taught component covering advanced econometrics. This portfolio ensures I arrive with the practical foundations to engage with that material from day one, and that the skills built here are durable across several years of part-time study alongside a demanding day job.

## Design Principles

The portfolio is built around principles that reflect how I learn best, given real constraints: a full-time role in government, limited and irregular study time, and a multi-year gap from formal econometrics.

**Each project adds exactly one new concept or technique.** No project requires learning two new things simultaneously. The difficulty gradient is deliberately gentle: if I can complete Project N, I have everything I need for Project N+1.

**Theory and code together, always.** Every R command encodes an economic assumption. When I type `feols(y ~ x | id + year, data = panel)`, I should know that the `|` absorbs fixed effects via the within-estimator, which eliminates time-invariant unobservables under strict exogeneity. The code is the theory made concrete.

**Real data, real questions.** Projects use World Development Indicators, Penn World Tables, Global Findex, Eurostat, and replication datasets from published papers. One deliberate exception: Project 9 uses simulation to make the DiD estimator fully transparent before applying it to real data.

**Adaptive, not rigid.** The 16 projects define *what* I learn. The implementation details — which dataset, how many sessions, which replication paper — adapt based on structured reflections after each project. A built-in feedback loop diagnoses whether difficulties stem from R syntax, data wrangling, mathematical gaps, or conceptual understanding, and calibrates future projects accordingly. The aims stay fixed; the path flexes.

**A parallel maths thread runs alongside the projects.** Econometric theory is written in the language of expected values, variance operators, matrix algebra, and probability limits. Rather than treating maths as a separate prerequisite, I rebuild these tools just before each project that needs them: expected values before OLS, matrix algebra before panel methods, asymptotic theory before instrumental variables.

## Projects

### Phase 1 — Foundations: R Fluency & OLS

| # | Project | Method | Data Source |
|---|---------|--------|-------------|
| 1 | LAC GDP Trends | Data wrangling (tidyverse) | World Development Indicators via `WDI` R package |
| 2 | Financial Inclusion EDA | Summary statistics, distributions, correlations | Global Findex Database (World Bank) |
| 3 | Bivariate OLS | Simple regression, scatter + fitted line | WDI + Global Findex merged |
| 4 | Multivariate OLS | Controls, robust SEs, omitted variable bias | WDI + Findex + Worldwide Governance Indicators |
| 5 | OLS Diagnostics | Residual plots, functional form, modelsummary | Same as Project 4 |

**Maths thread:** Expected values, variance/covariance as operators, summation notation, probability distributions (normal, t, F).

### Phase 2 — Causal Inference Toolkit

#### Panel Data & Fixed Effects

| # | Project | Method | Data Source |
|---|---------|--------|-------------|
| 6 | Panel Structure | Within vs between variation (no regression) | Penn World Tables 10.01 via `pwt10` R package |
| 7 | First Fixed Effects | Entity FE vs pooled OLS (fixest) | Penn World Tables 10.01 |
| 8 | EU Structural Funds Revisited | Two-way FE, clustered SEs | Eurostat NUTS2 regional GDP + EU Cohesion Data |

**Maths thread:** Vectors and matrices, matrix multiplication, transpose and inverse, OLS in matrix form: β̂ = (X'X)⁻¹X'y.

Project 8 revisits my MSc dissertation topic — the effectiveness of EU structural funds — using modern panel methods in R. This is where dormant knowledge from formal training reconnects with new tools, supported by the seven projects that built up to it.

#### Difference-in-Differences

| # | Project | Method | Data Source |
|---|---------|--------|-------------|
| 9 | DiD by Hand | Simulated DiD, manual computation | Simulated in R (no external data) |
| 10 | Card & Krueger Replication | DiD with real data, parallel trends | `wooldridge` R package (`njmin3` dataset) |
| 11 | Event Study | Dynamic treatment effects, leads/lags | `did` R package example data or Stevenson & Wolfers (2006) |

#### Instrumental Variables

| # | Project | Method | Data Source |
|---|---------|--------|-------------|
| 12 | IV Textbook | 2SLS, first-stage diagnostics, LATE | Acemoglu, Johnson & Robinson (2001) — MIT data archive |
| 13 | IV in Development | Applied IV, exclusion restriction critique | Miguel, Satyanath & Sergenti (2004) — UC Berkeley |

**Maths thread:** Consistency vs unbiasedness, probability limits, plim(β̂\_OLS) = β + Cov(X,ε)/Var(X), Central Limit Theorem.

#### Regression Discontinuity

| # | Project | Method | Data Source |
|---|---------|--------|-------------|
| 14 | Regression Discontinuity | rdrobust, bandwidth selection, RD plots | Lee (2008) — built into `rdrobust` R package |

### Phase 3 — Independent Research

| # | Project | Method | Data Source |
|---|---------|--------|-------------|
| 15 | Original Empirical Analysis | Independent research design | TBD — likely WDI, IMF, or OECD public data |
| 16 | Literature Replication | Engaging with research frontier | TBD — replication data from chosen paper |

Project 15 is the centrepiece of the portfolio: an original empirical analysis on a question drawn from my professional experience in international economic policy. It demonstrates the ability to do economics, not just replicate other people's economics. Project 16 replicates a paper closely related to my proposed doctoral research, grounding my PhD proposal in a demonstrated engagement with the existing literature.

## Progress Tracking & Adaptive Feedback

The plan includes a built-in learning feedback loop. After each project, a short structured reflection records: actual sessions taken versus planned, what was harder or easier than expected, the category of difficulty (R syntax, data wrangling, maths gap, or conceptual), and a confidence rating (1–5) on the method.

At every phase boundary (after Projects 5, 8, 11, and 14), a fuller calibration review adjusts the implementation of upcoming projects based on the accumulated pattern of reflections. The rule is explicit:

- **What never changes:** The method each project covers, the phase structure, the sequencing, the requirement to cover all four causal inference methods, and the overall aim of 16 completed portfolio projects.
- **What adapts:** Dataset complexity, replication paper difficulty, number of bridging sessions between projects, and the emphasis placed on the parallel maths thread.

This means the portfolio is not a rigid curriculum that might fail on contact with reality. It is a learning system that responds to evidence about how I actually learn, while maintaining the scope and ambition of the original design.

## Folder Structure

```
01-lac-gdp-trends/
02-financial-inclusion-eda/
03-bivariate-ols/
04-multivariate-ols/
05-ols-diagnostics/
06-panel-structure/
07-first-fixed-effects/
08-structural-funds-revisited/
09-did-by-hand/
10-card-krueger-replication/
11-event-study/
12-iv-textbook/
13-iv-development/
14-regression-discontinuity/
15-original-research/
16-literature-replication/
```

Each folder contains:
- An R script or R Markdown document with annotated code
- A brief writeup explaining the economic question, identification strategy, and results
- The dataset used (or instructions for downloading it)
- A reflection note recording what was learned and what was difficult

## Tools

- **R** (RStudio for Mac)
- **Core packages:** tidyverse (dplyr, tidyr, ggplot2, readr), fixest, modelsummary, sandwich, lmtest, rdrobust, haven
- **Data sources:** World Development Indicators, Global Findex, Worldwide Governance Indicators, Penn World Tables, Eurostat, and replication datasets from published economics papers

## Key Resources

The analytical approach in this portfolio draws on:

- Huntington-Klein, N. (2021). *The Effect: An Introduction to Research Design and Causality*. Chapman & Hall/CRC. Free at [theeffectbook.net](https://theeffectbook.net). The primary spine for causal inference theory and R implementation.
- Wickham, H. & Grolemund, G. (2023). *R for Data Science*. 2nd edition. Free at [r4ds.hadley.nz](https://r4ds.hadley.nz). Reference for data manipulation.
- Wooldridge, J.M. (2020). *Introductory Econometrics: A Modern Approach*. 7th edition. Cengage. Formal theory reference and maths appendices.
- Angrist, J.D. & Pischke, J.-S. (2009). *Mostly Harmless Econometrics*. Princeton University Press. Deeper causal inference theory.
- Gill, J. (2006). *Essential Mathematics for Political and Social Research*. Cambridge UP. Maths refresher for the parallel thread.

## Status

🟢 Active — portfolio under construction.

## Author

Public sector economist | MSc Applied Economics | Preparing for part-time PhD in Economics
