
#' Clean Wellness Data
#'
#' This function cleans raw wellness data by dropping rows with essential NAs,
#' standardizing column names to snake_case, and coercing character columns to factors.
#' @param input_path Path to the input CSV file.
#' @param output_path Path to save the cleaned CSV file. Defaults to "wellness_data_cleaned.csv".
#' @keywords wellness, data cleaning
#' @export
#' @examples
#' clean_data <- clean_wellness_data("wellness_data.csv")
#' head(clean_data)
clean_wellness_data <- function(input_path,
                                output_path = "wellness_data_cleaned.csv") {

  # Load packages
  library(tidyverse)
  library(janitor)

  # Read data
  df <- read_csv(input_path, show_col_types = FALSE) %>%
    clean_names()  # snake_case, strip weird chars

  # Split "systolic/diastolic" into two numeric cols
  df <- df %>%
    separate(
      col   = systolic_and_diastolic_blood_pressure,
      into  = c("systolic_bp", "diastolic_bp"),
      sep   = "/",
      convert = TRUE,
      remove  = TRUE
    )

  # Extract water (liters) & steps from text column
  df <- df %>%
    mutate(
      water_liters = str_extract(
        additional_health_indicators_e_g_water_levels_steps,
        "[0-9.]+(?=\\s*liters?)"
      ) %>% as.numeric(),

      steps = str_extract(
        additional_health_indicators_e_g_water_levels_steps,
        "[0-9,]+(?=\\s*steps?)"
      ) %>% str_remove_all(",") %>% as.integer()
    ) %>%
    select(-additional_health_indicators_e_g_water_levels_steps)

  # Standardize text columns to lowercase / trimmed
  cat_cols <- c(
    "bmi_category",
    "quality_or_frequency_of_social_interactions",
    "activities_for_mental_health_such_as_therapy_sessions_or_meditation",
    "environmental_aspects_such_as_weather_and_air_quality",
    "lifestyle_decisions_such_as_drinking_and_smoking",
    "mood_output"
  )

  df <- df %>%
    mutate(across(all_of(cat_cols), ~ str_trim(str_to_lower(.x))))

  # Ensure numeric columns are numeric
  num_cols <- c(
    "duration_of_sleep_hours",
    "level_of_physical_activity_minutes_per_day",
    "level_of_stress_scale_1_10",
    "heart_rate_bpm",
    "level_of_workload_scale_1_10",
    "systolic_bp",
    "diastolic_bp",
    "water_liters",
    "steps"
  )

  df <- df %>%
    mutate(across(all_of(num_cols), as.numeric))

  # Remove duplicates & rows missing critical vitals
  df <- df %>%
    distinct() %>%
    drop_na(duration_of_sleep_hours, heart_rate_bpm,
            systolic_bp, diastolic_bp)

  # Write cleaned dataset
  write_csv(df, output_path)

  message("Cleaned dataset written to: ", normalizePath(output_path))
  return(df)
}
