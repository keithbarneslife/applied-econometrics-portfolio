# Project 2: Financial Inclusion EDA

## Economic Question
How does access to financial services vary across developing countries, and what observable factors are associated with it?

## What You're Learning
Exploratory data analysis: summary statistics by group, distributions, correlations. The discipline of looking at data before modelling it.

## Before You Start
Read *The Effect*, Chapter 5 (full chapter). 30 minutes.

## R Packages Needed
```r
library(tidyverse)
library(WDI)
library(knitr)
```

---

## Session 1: Import and Clean (~30 min)

### Step 1: Download financial inclusion data
We'll use WDI to get the Global Findex headline indicator (% of adults with a financial account) alongside GDP and other variables, all in one call:
```r
library(tidyverse)
library(WDI)

findex_raw <- WDI(
  indicator = c(
    "FX.OWN.TOTL.ZS",    # Account ownership (% age 15+)
    "NY.GDP.PCAP.KD",     # GDP per capita (constant 2015 US$)
    "SE.ADT.LITR.ZS",     # Adult literacy rate (%)
    "SP.URB.TOTL.IN.ZS"   # Urban population (% of total)
  ),
  country = "all",
  start = 2017,
  end = 2022
)
```
The Findex data is only collected every ~3 years (2011, 2014, 2017, 2021), so many year-country combinations will be `NA`. That's normal.

### Step 2: Rename variables
```r
findex <- findex_raw %>%
  rename(
    account = FX.OWN.TOTL.ZS,
    gdp_pc = NY.GDP.PCAP.KD,
    literacy = SE.ADT.LITR.ZS,
    urban = SP.URB.TOTL.IN.ZS
  )
```

### Step 3: Check what we have
```r
glimpse(findex)
```

How much data is actually available for the account variable?
```r
findex %>%
  filter(!is.na(account)) %>%
  summarise(
    n_countries = n_distinct(country),
    n_obs = n(),
    years = paste(unique(year), collapse = ", ")
  )
```

### Step 4: Create a clean cross-section
Since Findex is collected infrequently, take the most recent non-missing observation per country:
```r
findex_latest <- findex %>%
  filter(!is.na(account)) %>%
  arrange(country, desc(year)) %>%
  group_by(country) %>%
  slice(1) %>%
  ungroup()

nrow(findex_latest)
```
This gives you one row per country with their most recent financial inclusion data.

### Step 5: Remove aggregates
The WDI data includes regional aggregates ("World", "Sub-Saharan Africa", etc.). Remove them:
```r
# WDI aggregates tend to have iso2c codes that are not standard 2-letter country codes
# A simple approach: keep only rows where iso2c is exactly 2 uppercase letters
findex_clean <- findex_latest %>%
  filter(str_detect(iso2c, "^[A-Z]{2}$"))

nrow(findex_clean)
```
You should have roughly 130–160 countries.

**Save your work.** Create `analysis.R` in `02-financial-inclusion-eda/`. Commit.

---

## Session 2: Summary Statistics (~30 min)

### Step 1: Reload
Run all Session 1 code to get `findex_clean` in memory.

### Step 2: Overall summary statistics
```r
findex_clean %>%
  summarise(
    n = n(),
    mean_account = mean(account, na.rm = TRUE),
    median_account = median(account, na.rm = TRUE),
    sd_account = sd(account, na.rm = TRUE),
    min_account = min(account, na.rm = TRUE),
    max_account = max(account, na.rm = TRUE)
  )
```

### Step 3: Create income groups
The WDI doesn't always include income group in the download. Let's create a rough one based on GDP:
```r
findex_clean <- findex_clean %>%
  mutate(
    income_group = case_when(
      gdp_pc < 1500  ~ "Low income",
      gdp_pc < 5000  ~ "Lower-middle",
      gdp_pc < 15000 ~ "Upper-middle",
      TRUE           ~ "High income"
    ),
    income_group = factor(income_group,
      levels = c("Low income", "Lower-middle", "Upper-middle", "High income"))
  )
```
`case_when()` works like a series of IF statements. The `TRUE ~` at the end is the "else" case.

### Step 4: Summary by income group
```r
income_summary <- findex_clean %>%
  group_by(income_group) %>%
  summarise(
    n = n(),
    mean_account = round(mean(account, na.rm = TRUE), 1),
    mean_gdp = round(mean(gdp_pc, na.rm = TRUE), 0),
    mean_literacy = round(mean(literacy, na.rm = TRUE), 1)
  )

print(income_summary)
```

### Step 5: Make it a formatted table
```r
knitr::kable(income_summary,
  col.names = c("Income Group", "N", "Account (%)", "GDP p.c. ($)", "Literacy (%)"),
  caption = "Financial Inclusion by Income Group"
)
```
If you're writing an R Markdown file, this will render as a clean table. In a plain R script, it prints a markdown-formatted table to the console.

**Save and commit.**

---

## Session 3: Visualise (~30 min)

### Step 1: Reload
Run Sessions 1–2 to get `findex_clean` in memory.

### Step 2: Distribution of account ownership
```r
ggplot(findex_clean, aes(x = account)) +
  geom_histogram(bins = 25, fill = "steelblue", colour = "white") +
  labs(
    title = "Distribution of Financial Account Ownership",
    x = "Account ownership (% of adults)",
    y = "Number of countries"
  ) +
  theme_minimal()
```
Notice the shape. Is it bimodal? (It often is — a cluster of low-income countries near 20–40% and high-income countries near 90–100%.)

### Step 3: Box plot by income group
```r
ggplot(findex_clean, aes(x = income_group, y = account, fill = income_group)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Account Ownership by Income Group",
    x = "",
    y = "Account ownership (%)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
```

### Step 4: Scatter plot — GDP vs account ownership
This is the relationship you'll model in Project 3:
```r
ggplot(findex_clean, aes(x = gdp_pc, y = account)) +
  geom_point(alpha = 0.6, colour = "steelblue") +
  labs(
    title = "GDP per Capita vs Financial Account Ownership",
    x = "GDP per capita (constant 2015 US$)",
    y = "Account ownership (%)"
  ) +
  theme_minimal()
```
The relationship is probably non-linear — it levels off at high GDP. This will matter when you choose functional form in Project 5.

Try it in logs:
```r
ggplot(findex_clean, aes(x = log(gdp_pc), y = account)) +
  geom_point(alpha = 0.6, colour = "steelblue") +
  labs(
    title = "Log GDP per Capita vs Financial Account Ownership",
    x = "Log GDP per capita",
    y = "Account ownership (%)"
  ) +
  theme_minimal()
```
Does the log version look more linear? (It usually does.)

### Step 5: Correlation matrix
```r
cor_vars <- findex_clean %>%
  select(account, gdp_pc, literacy, urban) %>%
  drop_na()

cor_matrix <- cor(cor_vars)
round(cor_matrix, 2)
```
This shows pairwise correlations. GDP, literacy, and urbanisation are all likely positively correlated with account ownership — and with each other. That's the omitted variable problem you'll confront in Project 4.

**Save the complete analysis.R and commit: "Project 02: complete".**

---

## What "Done" Looks Like
- `analysis.R` with summary statistics, at least 3 visualisations, and a correlation matrix
- You can describe the pattern in the data *before* running any regression
- You've practised `case_when()`, `knitr::kable()`, and the difference between histograms, box plots, and scatter plots

## Estimated Sessions: ~3
---

## Workflow Reminder

**See [WORKFLOW.md](../WORKFLOW.md) for the full two-pane workflow and sandbox convention.**

Quick version:
1. Open `02-financial-inclusion-eda/analysis.R` in Working Copy. This is your source of truth.
2. Open webRios alongside it.
3. Type new commands into `analysis.R` → copy → paste into webRios → run.
4. Commands that create objects go in the pipeline section. Inspection commands (`glimpse`, `head`, `summary`, etc.) go in the sandbox section, commented out.
5. At the end of the session, commit and push from Working Copy. Suggested message: `"Project 02: [what you did this session]"`.

**Never copy from the webRios console back into `analysis.R`.** Console output is disposable.

**At the end of the project:** create `reflection.md` using the template in `docs/tracking.md`.
