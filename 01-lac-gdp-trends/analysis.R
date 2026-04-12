> library(tidyverse)
library(WDI)
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.6
✔ forcats   1.0.1     ✔ stringr   1.6.0
✔ ggplot2   4.0.1     ✔ tibble    3.3.0
✔ lubridate 1.9.4     ✔ tidyr     1.3.2
✔ purrr     1.2.0     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors                         ^
> gdp_raw <- WDI(
  indicator = "NY.GDP.PCAP.KD",
  country = "all",
  start = 2000,
  end = 2024)
> glimpse(gdp_raw)
Rows: 6,650
Columns: 5
$ country        <chr> "Africa Eastern a…
$ iso2c          <chr> "ZH", "ZH", "ZH",…
$ iso3c          <chr> "AFE", "AFE", "AF…
$ year           <int> 2024, 2023, 2022,…
$ NY.GDP.PCAP.KD <dbl> 1435.356, 1431.72…
> head(gdp_raw, 10)
                       country iso2c
1  Africa Eastern and Southern    ZH
2  Africa Eastern and Southern    ZH
3  Africa Eastern and Southern    ZH
4  Africa Eastern and Southern    ZH
5  Africa Eastern and Southern    ZH
6  Africa Eastern and Southern    ZH
7  Africa Eastern and Southern    ZH
8  Africa Eastern and Southern    ZH
9  Africa Eastern and Southern    ZH
10 Africa Eastern and Southern    ZH
   iso3c year NY.GDP.PCAP.KD
1    AFE 2024       1435.356
2    AFE 2023       1431.722
3    AFE 2022       1440.430
4    AFE 2021       1425.209
5    AFE 2020       1399.398
6    AFE 2019       1479.372
7    AFE 2018       1489.942
8    AFE 2017       1490.911
9    AFE 2016       1490.908
10   AFE 2015       1498.875
> nrow(gdp_raw)
[1] 6650
> gdp <- gdp_raw %>%
  rename(gdp_pc = NY.GDP.PCAP.KD)
> sum(is.na(gdp$gdp_pc))
[1] 299
> lac_codes <- c("ARG", "BOL", "BRA", "CHL", "COL", "CRI", "ECU",
               "GTM", "HND", "MEX", "NIC", "PAN", "PER", "PRY",
               "SLV", "URY", "VEN")
> head(gdp$iso2c)
head(gdp$iso3c)
[1] "AFE" "AFE" "AFE" "AFE" "AFE" "AFE"
> lac_codes <- c("AR", "BO", "BR", "CL", "CO", "CR", "EC",
               "GT", "HN", "MX", "NI", "PA", "PE", "PY",
               "SV", "UY", "VE")
> lac <- gdp %>%
  filter(iso2c %in% lac_codes, year >= 2010)
> unique(lac$country)
nrow(lac)
[1] 255
> lac <- lac %>%
  arrange(country, year) %>%
  group_by(country) %>%
  mutate(gdp_growth = (gdp_pc - lag(gdp_pc)) / lag(gdp_pc) * 100) %>%
  ungroup()
> lac %>%
  filter(country == "Brazil") %>%
  select(country, year, gdp_pc, gdp_growth)
# A tibble: 15 × 4
   country  year gdp_pc gdp_growth
   <chr>   <int>  <dbl>      <dbl>
 1 Brazil   2010  8793.     NA    
 2 Brazil   2011  9068.      3.13 
 3 Brazil   2012  9167.      1.10 
 4 Brazil   2013  9367.      2.17 
 5 Brazil   2014  9338.     -0.303
 6 Brazil   2015  8936.     -4.31 
 7 Brazil   2016  8578.     -4.01 
 8 Brazil   2017  8628.      0.588
 9 Brazil   2018  8722.      1.09 
10 Brazil   2019  8771.      0.563
11 Brazil   2020  8435.     -3.84 
12 Brazil   2021  8799.      4.32 
13 Brazil   2022  9032.      2.65 
14 Brazil   2023  9288.      2.83 
15 Brazil   2024  9567.      3.00 
> lac %>%
  filter(country == "Argentina") %>%
  select(country, year, gdp_pc, gdp_growth)
# A tibble: 15 × 4
   country    year gdp_pc gdp_growth
   <chr>     <int>  <dbl>      <dbl>
 1 Argentina  2010 13387.      NA   
 2 Argentina  2011 14041.       4.88
 3 Argentina  2012 13754.      -2.04
 4 Argentina  2013 13946.       1.39
 5 Argentina  2014 13456.      -3.51
 6 Argentina  2015 13680.       1.66
 7 Argentina  2016 13266.      -3.02
 8 Argentina  2017 13520.       1.92
 9 Argentina  2018 13058.      -3.42
10 Argentina  2019 12706.      -2.70
11 Argentina  2020 11393.     -10.3 
12 Argentina  2021 12549.      10.1 
13 Argentina  2022 13277.       5.80
14 Argentina  2023 12993.      -2.14
15 Argentina  2024 12774.      -1.68
> lac %>%
  filter(country == "Belize") %>%
  select(country, year, gdp_pc, gdp_growth)
# A tibble: 0 × 4
# ℹ 4 variables: country <chr>,
#   year <int>, gdp_pc <dbl>,
#   gdp_growth <dbl>
> lac_summary <- lac %>%
  group_by(country) %>%
  summarise(
    mean_gdp = mean(gdp_pc, na.rm = TRUE),
    mean_growth = mean(gdp_growth, na.rm = TRUE),
    sd_growth = sd(gdp_growth, na.rm = TRUE)
  )
> print(lac_summary)
# A tibble: 17 × 4
   country  mean_gdp mean_growth sd_growth
   <chr>       <dbl>       <dbl>     <dbl>
 1 Argenti…   13187.      -0.218      5.01
 2 Bolivia     2939.       1.60       5.12
 3 Brazil      8966.       0.642      2.83
 4 Chile      13396.       1.69       3.92
 5 Colombia    6200.       2.06       4.14
 6 Costa R…   12304.       2.70       2.67
 7 Ecuador     5822.       1.39       4.93
 8 El Salv…    3946.       2.23       3.88
 9 Guatema…    4001.       1.83       2.00
10 Honduras    2328.       1.52       4.25
11 Mexico      9911.       0.726      3.24
12 Nicarag…    2044.       2.20       3.81
13 Panama     14248.       3.70       7.60
14 Paraguay    5973.       1.81       2.63
15 Peru        6208.       2.01       5.18
16 Uruguay    17118.       1.87       3.28
17 Venezue…    2923.      -6.51      12.2 
