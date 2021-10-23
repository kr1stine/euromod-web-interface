library(dplyr)

results <-
  rbind(
    read.csv("data-raw/2018_1_dump.csv", check.names = F),
    read.csv("data-raw/2019_1_dump.csv", check.names = F),
    read.csv("data-raw/2020_1_dump.csv", check.names = F)
  ) %>% select(-1) # remove index

results <- rename(results, "min wage" = "minwage")

# run on windows because the encoding breaks reading on other platforms
hh <-
  rbind(
    read.csv("data-raw/2018_hh_1_dump.csv", check.names = F),
    read.csv("data-raw/2019_hh_1_dump.csv", check.names = F),
    read.csv("data-raw/2020_hh_1_dump.csv", check.names = F)
  ) %>% select(-1) # remove index

# the raw row names are out of order
names(hh) <- c("household", "scenario", "absolute poverty", "relative poverty", "year", "min wage")

original <- read.csv("data-raw/original.csv", check.names = F)

income_poverty_taxes_benefits <- results
save(income_poverty_taxes_benefits, file = "data/income_poverty_taxes_benefits.rda")

household_poverty <-
  hh %>%
  mutate(scenario := sub(" \\d+", "", scenario)) # Remove numbers so translation works
save(household_poverty, file = "data/household_poverty.rda")

save(original, file = "data/original.rda")
