# global.R
suppressPackageStartupMessages({
  library(shiny)
  library(tidyverse)
  library(plotly)
  library(wordcloud2)
  library(DT)
  library(lubridate)
  library(tidytext)
})

# Load example data from the data folder
source("data/example_data.R")