#' Summarize by Mood
#'
#' Shows how habits (sleep, steps, stress) vary across mood categories (Happy, Neutral, Sad).
#' @param df A data frame containing wellness data.
#' @keywords wellness, mood
#' @export
#' @examples
#' summarize_by_mood(clean_data)
summarize_by_mood <- function(df) {
  df %>%
    group_by(mood_output) %>%
    summarize(
      avg_sleep = mean(duration_of_sleep_hours),
      avg_steps = mean(steps),
      avg_stress= mean(level_of_stress_scale_1_10),
      .groups = 'drop'
    )
}
