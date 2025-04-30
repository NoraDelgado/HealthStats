#' Summarize Health Factors
#'
#' Provides a quick numeric snapshot of average sleep, steps, heart rate, and water intake per day.
#' @param df A data frame containing wellness data.
#' @keywords wellness, summary
#' @export
#' @examples
#' summarize_health_factors(clean_data)
summarize_health_factors <- function(df) {
  df %>%
    summarize(
      avg_sleep       = mean(duration_of_sleep_hours),
      avg_steps       = mean(steps),
      avg_heart_rate  = mean(heart_rate_bpm),
      avg_water_intake= mean(water_liters)
    )
}
