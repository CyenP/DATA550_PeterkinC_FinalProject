# Project Description
The Mapping Police Violence database contains information on civilians killed in incidents where law enforcement officers applied lethal force. In my report, I conducted a crude rate analysis of civilians exhibiting signs of mental illness, stratified by state and gender. 

# Code Description
`code/00_mpv_data_load.r`
- Reads in the Mapping Police Violence data from the `MappingPoliceViolence.csv` in the `raw_data` folder.
- saves the Mapping Police Violence data as `mpv_data.rds` in the `output` folder. 

`code/00_acs_data_load.r`
- Reads in state population estimates from the American Community Survey 1-year estimates using the `get_acs` package.
- Saves the state population estimates as `state_pop.rds` in the `output` folder. 

`code/01_data_processing.r`
- Reads in `mpv_data.rds` and `state_pop.rds` from the `output` folder. 
- Data Processing Tasks:
  (1) Group the police mapping data by state and gender.
  (2) Filtering the grouped police mapping data to only include observations of Male and Female.
  (3) Create a variable in the grouped police mapping data that contains counts of the responses of "Yes" within the mental illness instance variable.
  (4) Left join the grouped police mapping data and state population estimates by state names and gender.
  (5) Create a variable in the merged data that contains the calculated crude rates of civilians killed who exhibited signs of mental illness.
- Saves the processed/merged data as `mental_crude_state.rds` in the `output` folder. 

`code/02_table.r`
- Reads in `mpv_data.rds` and `mental_crude_state.rds` from the `output` folder. 
- Adds labels to variables within the `mental_crude_state` datasets. Additionally, creates a table displaying counts of reported signs of mental illness among civilians killed by gender and states.
- Saves the table as `table_one.rds` in the `output` folder.

`code/03_map.r`
- Reads in `mental_crude_state.rds` from the `output` folder. 
- Creates a map displaying the crude rates of mental illness signs by state, faceted by gender. 
- Saves the map as `map_one.rds` in the `output` folder.

`PeterkinC_FinalProject_Report.Rmd`
- Contains the contents of final report. Please see section below for more details.

`code/04_render_report.r`
- Renders the `PeterkinC_FinalProject_Report.html` from the `PeterkinC_FinalProject_Report.Rmd`.

# How to Build Final Report
To build the final report, type `make PeterkinC_FinalProject_Report.html` in terminal. 

# Contents of Final Report
The final report contains...
- a Introduction.
- Data loading and processing references.
- Table displaying counts of reported signs of mental illness among civilians killed by gender and states. 
- Map displaying the crude rates of mental illness signs by state, faceted by gender. 