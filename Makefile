## Project-associated rules
## PeterkinC_FinalProject_Report.html:  This is the final report.
PeterkinC_FinalProject_Report.html: code/04_render_report.r PeterkinC_FinalProject_Report.Rmd everything
	Rscript code/04_render_report.r

## output/mpv_data.rds: This is the Mapping Police Violence data load code
output/mpv_data.rds: code/00_mpv_data_load.r raw_data/MappingPoliceViolence.csv
	Rscript code/00_mpv_data_load.r

## output/mpv_data.rds: This is the American Community Survey data load code
output/state_pop.rds: code/00_acs_data_load.r 
	Rscript code/00_acs_data_load.r
	
## output/mental_crude_state.rds: 
output/mental_crude_state.rds: code/01_data_processing.r output/mpv_data.rds output/state_pop.rds
	Rscript code/01_data_processing.r

## output/table_one.rds: This is the table one
output/table_one.rds: code/02_table.r output/mpv_data.rds output/mental_crude_state.rds
	Rscript code/02_table.r

## output/map_one.rds: This is the map one
output/map_one.rds: code/03_map.r output/mental_crude_state.rds
	Rscript code/03_map.r

.PHONY: everything
everything: output/mpv_data.rds output/state_pop.rds output/mental_crude_state.rds output/table_one.rds output/map_one.rds

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f *.html
	
.PHONY: install
install: 
	Rscript -e "renv::restore(prompt = FALSE)"
	
## Docker-associated rules
# pulling image off my repo
.PHONY: image
image:
	docker pull cyenp/last_project_image

## rule to build report automatically in the container
## Windows
report/PeterkinC_FinalProject_Report.html: image
	MSYS_NO_PATHCONV=1 docker run --rm -v "$$(pwd)/report":/home/rstudio/project/report cyenp/last_project_image

## Mac
report/PeterkinC_FinalProject_Report.html_2: image
	docker run --rm -v "$$(pwd)/report":/home/rstudio/project/report cyenp/last_project_image


.PHONY: clean2
clean2:
	rm -f report/*.html