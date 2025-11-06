here::i_am("code/01_data_processing.r")

mpv_data <- readRDS(file = here::here("output/mpv_data.rds"))
state_pop <- readRDS(file = here::here("output/state_pop.rds"))

library(tidyverse)
library(tigris)
library(sf)

mental_crude_state <- mpv_data |> 
  group_by(state, gender) |> 
  filter(gender %in% c("Male", "Female")) |> 
  summarise(
    signs_of_mental_illness_instances = sum(signs_of_mental_illness == "Yes", na.rm = TRUE), .groups = "drop") |> 
  left_join(
    state_pop |> select(GEOID, state, gender, POP_EST, geometry),
    by = c("state", "gender")) |> 
  mutate(crude_rate = (signs_of_mental_illness_instances/POP_EST)* 100000, tooltip = paste(state, round(crude_rate, 2), sep = ": ")) |> 
  select(GEOID, state, gender, signs_of_mental_illness_instances, POP_EST, crude_rate, geometry, tooltip) |> 
  st_sf() |> 
  shift_geometry()

saveRDS(
  mental_crude_state,
  file = here::here("output","mental_crude_state.rds")
)