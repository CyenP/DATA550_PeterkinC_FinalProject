here::i_am("code/02_table.r")

mpv_data <- readRDS(file = here::here("output/mpv_data.rds"))
mental_crude_state <- readRDS(file = here::here("output/mental_crude_state.rds"))

library(tidyverse)
library(labelled)
library(gtsummary)

var_label(mental_crude_state) <- list(
  GEOID = "Geographic Identifier",
  state = "State Name",
  gender = "Gender",
  signs_of_mental_illness_instances = "The # of Civilians Killed That Exhibited Signs of Mental Illness",
  POP_EST = "Population Estimates",
  crude_rate = "Crude Rate of Civilians Killed That Exhibited Signs of Mental Illness Per 100000"
)

table_one <- mpv_data |>
  filter(gender %in% c("Male", "Female")) |> 
  tbl_strata(
    strata = state,
    ~ .x |> 
      tbl_summary(by = gender, include = signs_of_mental_illness) |> 
      add_p()
  )

saveRDS(table_one, 
        file = here::here("output/table_one.rds"))