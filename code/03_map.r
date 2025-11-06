here::i_am("code/03_map.r")

mental_crude_state <- readRDS(file = here::here("output/mental_crude_state.rds"))

library(tidyverse)
library(ggiraph)

map_one <- ggplot(mental_crude_state, aes(fill = crude_rate)) +
  geom_sf_interactive(aes(tooltip = tooltip, data_id = state), size = 0.1) +
  facet_wrap(~ gender) +
  theme_minimal() +
  scale_fill_viridis_c(
    option = "plasma", 
    breaks = c(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5), 
    labels = c("0", "0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5+")) +
  labs(
    fill = "Rate per 100,000",
    title = "Crude Rate of Mental Illness Signs by State and Gender"
  )

saveRDS(
  map_one, 
  file =  here::here("output/map_one.rds")
)