# Project 6: Understanding Panel Structure

## Economic Question
None — this is about understanding what panel data looks like and what fixed effects will exploit.

## What You're Learning
The distinction between within-unit and between-unit variation. No regression in this project.

## Before You Start
- Read *The Effect*, Chapter 16 (Fixed Effects), first half only.
- **Maths thread:** Work through the Matrix Algebra section of `docs/maths-foundations.md`.

## R Packages Needed
```r
library(tidyverse)
library(pwt10)
```

---

## Session 1: Explore Panel Data (~30 min)

### Step 1: Load Penn World Tables
```r
library(tidyverse)
library(pwt10)
data("pwt10.01")

pwt <- pwt10.01 %>%
  filter(year >= 1990) %>%
  mutate(gdp_pc = rgdpna / pop) %>%
  select(country, isocode, year, gdp_pc, hc, pop) %>%
  drop_na(gdp_pc)

glimpse(pwt)
n_distinct(pwt$country)
```
How many countries? How many years per country?
```r
pwt %>% count(country) %>% summary()
```

### Step 2: Pick a manageable subset
```r
selected <- c("USA", "GBR", "DEU", "FRA", "JPN", "BRA", "IND", "CHN", "NGA", "ZAF")
pwt_sub <- pwt %>% filter(isocode %in% selected)
```

### Step 3: Compute between-country variation
This is the variation in *country averages* — how different countries are from each other on average:
```r
between <- pwt_sub %>%
  group_by(country) %>%
  summarise(mean_gdp = mean(gdp_pc))

ggplot(between, aes(x = reorder(country, mean_gdp), y = mean_gdp)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Between-Country Variation: Mean GDP per Capita",
       x = "", y = "Mean GDP per capita (1990–2019)") +
  theme_minimal()
```

### Step 4: Compute within-country variation
This is variation *over time within each country* — deviations from each country's own mean:
```r
pwt_sub <- pwt_sub %>%
  group_by(country) %>%
  mutate(
    mean_gdp = mean(gdp_pc),
    within_gdp = gdp_pc - mean_gdp
  ) %>%
  ungroup()

ggplot(pwt_sub, aes(x = year, y = within_gdp, colour = country)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "Within-Country Variation: Deviations from Country Mean",
       y = "GDP per capita minus country mean", x = "Year") +
  theme_minimal()
```
**This demeaned version is what fixed effects "see."** The FE estimator throws away all the between-country differences and uses only these within-country deviations.

---

## Session 2: The Spaghetti Plot (~20 min)

### Step 1: Raw data — all countries
```r
ggplot(pwt_sub, aes(x = year, y = gdp_pc, colour = country)) +
  geom_line(linewidth = 0.8) +
  labs(title = "GDP per Capita: Raw Data", y = "GDP per capita", x = "Year") +
  theme_minimal()
```
The USA and Japan are way above Nigeria and India. The between-country variation dominates.

### Step 2: Same data, demeaned
```r
ggplot(pwt_sub, aes(x = year, y = within_gdp, colour = country)) +
  geom_line(linewidth = 0.8) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "GDP per Capita: Demeaned (What FE Sees)",
       y = "Deviation from country mean", x = "Year") +
  theme_minimal()
```
Now all countries are centred on zero. You're looking at whether a country is above or below *its own average*, not whether it's richer than another country. **This is the identifying variation in a fixed effects regression.**

If there's very little within-country variation in a variable (e.g., geography, colonial history), FE cannot estimate its effect. This is both the strength and the limitation of the method.

**Save and commit: "Project 06: complete".**

---

## What "Done" Looks Like
- `analysis.R` with between and within variation computed and visualised
- You can explain what "within variation" means and why FE uses only this
- No regression was run — that's Project 7

## Estimated Sessions: ~2
---

## Workflow

Open `06-panel-structure/analysis.R` in Working Copy, webRios alongside. Paste file contents into webRios to reload state. Write new commands in the file, copy over to webRios to run. Commit and push at the end.

See [WORKFLOW.md](../WORKFLOW.md) for the full version.
