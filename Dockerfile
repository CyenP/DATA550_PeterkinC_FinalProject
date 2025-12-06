FROM rocker/tidyverse

RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

RUN mkdir -p renv 
RUN mkdir -p code 
RUN mkdir -p output 
RUN mkdir -p raw_data 

COPY code/ code
COPY Makefile .
COPY PeterkinC_FinalProject_Report.Rmd .
COPY raw_data/ raw_data

COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN apt-get update && apt-get install -y \
  libudunits2-0 \
  libproj-dev \
  libgdal-dev \
 && rm -rf /var/lib/apt/lists/*

RUN Rscript -e "renv::restore(prompt = FALSE)"

RUN mkdir report 
CMD make && mv PeterkinC_FinalProject_Report.html report
