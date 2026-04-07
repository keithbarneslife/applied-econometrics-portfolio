# Project 2: Financial Inclusion EDA

## Economic Question
How does access to financial services vary across developing countries, and what observable factors are associated with it?

## What You're Learning
Exploratory data analysis: summary statistics by group, distributions, correlations, and the discipline of looking at your data carefully before modelling it. This habit distinguishes careful empirical work from careless regression.

## Theory to Read
*The Effect*, Chapter 5 (the full chapter on describing and exploring data).

## Data Source
**Global Findex Database** (World Bank)

Download from: https://www.worldbank.org/en/publication/globalfindex/Data

Download the country-level dataset (not micro-data) as CSV or Excel. Key variables: account ownership (% of population aged 15+), by country and income group.

You may also want WDI variables for GDP per capita to merge in later (you already have this from Project 1).

## R Packages Needed
`tidyverse`, plus optionally `readxl` if downloading as Excel

## Steps

### Session 1: Import and clean
- Import the Findex dataset
- Inspect structure: how many countries, what variables, what years?
- Handle missing values: how many countries have complete data?

### Session 2: Summary statistics
- Compute summary statistics (mean, median, sd, min, max) for account ownership by region and income group
- Use `group_by()` + `summarise()` — you practised this in Project 1
- Create a summary table. Try `knitr::kable()` for a clean markdown table in R Markdown

### Session 3: Visualise
- Histogram or density plot of account ownership across countries
- Box plot by income group or region
- Scatter plot: account ownership vs GDP per capita (merge in WDI data from Project 1 using `left_join()`)
- Compute and display a correlation matrix for key numeric variables

## What "Done" Looks Like
- An R Markdown file with clean summary statistics, at least 3 visualisations, and a correlation matrix
- You can articulate what patterns you see in the data *before* running any regression
- You have practised `left_join()` to merge two datasets

## Estimated Sessions: ~3
