here::i_am("code/04_render_report.r")

library(rmarkdown)

# rendering a report 
render(
  "PeterkinC_FinalProject_Report.Rmd",
  output_file = "PeterkinC_FinalProject_Report.html"
)
