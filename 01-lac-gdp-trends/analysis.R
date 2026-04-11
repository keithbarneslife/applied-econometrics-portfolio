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
