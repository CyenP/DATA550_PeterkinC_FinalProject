here::i_am("code/00_acs_data_load.r")

library(tidycensus) 
library(tidyverse)

census_api_key("b51fa4e66553c7d99f6a0d7030f07a98921cb2a5")
state_pop <- get_acs(geography = "state",
                     variables = c("B01001_002", "B01001_026"),
                     year = 2023, 
                     geometry = T, 
                     survey = "acs1") |> 
  arrange(GEOID) |> 
  mutate(gender = case_when(
    variable == "B01001_002" ~ "Male", 
    variable == "B01001_026" ~ "Female")) |> 
  rename(POP_EST = estimate, state = NAME) |> 
  select(GEOID, state, gender, POP_EST, geometry)

saveRDS(
  state_pop,
  file = here::here("output","state_pop.rds")
)