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
library(HealthStats)

# Check if the help page appears
?clean_wellness_data

# Test package
clean_data <- clean_wellness_data("C:/Users/norae/Downloads/wellness_data.csv")
head(clean_data)

# Put project under Git
usethis::use_git_config(user.name = "Nora Delgado",
                        user.email = "noradelgadobusot@gmail.com")
use_git()

# Create GitHub repo
create_github_token()
edit_r_environ()
use_github(protocol = "https", private = FALSE)


