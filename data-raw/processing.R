library(dplyr)

results <-
  rbind(
    read.csv("data-raw/2018_1_dump.csv", check.names = F),
    read.csv("data-raw/2019_1_dump.csv", check.names = F),
    read.csv("data-raw/2020_1_dump.csv", check.names = F)
  ) %>% select(-1)


# run on windows becasue the encoding breaks reading on other platforms
hh <-
  rbind(
    read.csv("data-raw/2018_hh_1_dump.csv", check.names = F),
    read.csv("data-raw/2019_hh_1_dump.csv", check.names = F),
    read.csv("data-raw/2020_hh_1_dump.csv", check.names = F)
  ) %>% select(-1)


save(results, file = "data-raw/results.rda")

save(results, file = "data-raw/hh.rda")