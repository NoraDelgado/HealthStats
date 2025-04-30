# Load libraries
library(devtools)
library(usethis)
library(roxygen2)

# Create files
usethis::use_r("clean_wellness_data")
usethis::use_r("summarize_health_factors")
usethis::use_r("summarize_by_mood")
usethis::use_r("predict_mood")
usethis::use_r("health_score")

#Generate docs
document()


#Set working directory
setwd("C:/Users/norae/Downloads")

# Install package
install("HealthStats")

# Test package
