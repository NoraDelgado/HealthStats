#' Calculate Health Score
#'
#' Combines sleep, steps, and water intake into a daily health score (0 to 1).
#' @param df A data frame containing wellness data.
#' @keywords wellness, score
#' @export
#' @examples
#' health_score(clean_data)
health_score <- function(df) {
  df %>%
    mutate(
      health_score = 0.4 * (duration_of_sleep_hours / 8) +
        0.3 * (steps / 10000) +
        0.3 * (water_liters / 8)
    )
}
