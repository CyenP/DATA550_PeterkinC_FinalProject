here::i_am("code/00_mpv_data_load.r")

absolute_file_location <- here::here("raw_data","MappingPoliceViolence.csv")
mpv_data <- read.csv(absolute_file_location, header = T)

saveRDS(
  mpv_data,
  file = here::here("output","mpv_data.rds")
)