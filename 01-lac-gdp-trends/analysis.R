# =============================================================================
# Project 1: LAC GDP Trends
#
# Pipeline: run top to bottom to reproduce the full analysis.
# This file is the permanent record. Inspection commands live in the sandbox
# at the bottom (commented out).
# =============================================================================

# -----------------------------------------------------------------------------
# 1. Load packages
# -----------------------------------------------------------------------------
library(tidyverse)
library(WDI)


# -----------------------------------------------------------------------------
# 2. Download GDP per capita data (World Development Indicators)
# -----------------------------------------------------------------------------
gdp_raw <- WDI(
  indicator = "NY.GDP.PCAP.KD",
  country   = "all",
  start     = 2000,
  end       = 2024
)


# -----------------------------------------------------------------------------
# 3. Rename the GDP variable
# -----------------------------------------------------------------------------
gdp <- gdp_raw %>%
  rename(gdp_pc = NY.GDP.PCAP.KD)


# -----------------------------------------------------------------------------
# 4. Define LAC country codes (WDI uses 2-letter ISO codes)
# -----------------------------------------------------------------------------
lac_codes <- c("AR", "BO", "BR", "CL", "CO", "CR", "EC",
               "GT", "HN", "MX", "NI", "PA", "PE", "PY",
               "SV", "UY", "VE")


# -----------------------------------------------------------------------------
# 5. Filter to LAC countries, 2010 onwards
# -----------------------------------------------------------------------------
lac <- gdp %>%
  filter(iso2c %in% lac_codes, year >= 2010)


# -----------------------------------------------------------------------------
# 6. Compute GDP growth rates within each country
# -----------------------------------------------------------------------------
lac <- lac %>%
  arrange(country, year) %>%
  group_by(country) %>%
  mutate(gdp_growth = (gdp_pc - lag(gdp_pc)) / lag(gdp_pc) * 100) %>%
  ungroup()


# -----------------------------------------------------------------------------
# 7. Summary statistics by country
# -----------------------------------------------------------------------------
lac_summary <- lac %>%
  group_by(country) %>%
  summarise(
    mean_gdp    = mean(gdp_pc, na.rm = TRUE),
    mean_growth = mean(gdp_growth, na.rm = TRUE),
    sd_growth   = sd(gdp_growth, na.rm = TRUE)
  )


# =============================================================================
# Sandbox: one-off inspection commands.
# Not part of the pipeline. Uncomment and paste into webRios to run again.
# =============================================================================
# glimpse(gdp_raw)
# head(gdp_raw, 10)
# nrow(gdp_raw)
# sum(is.na(gdp$gdp_pc))
# head(gdp$iso2c)
# head(gdp$iso3c)
# unique(lac$country)
# nrow(lac)
# lac %>% filter(country == "Brazil") %>% select(country, year, gdp_pc, gdp_growth)
# lac %>% filter(country == "Argentina") %>% select(country, year, gdp_pc, gdp_growth)
# print(lac_summary)
