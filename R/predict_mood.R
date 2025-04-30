#' Predict Mood
#'
#' Uses logistic regression to predict Sad vs Not Sad mood based on sleep, steps, and stress.
#' @param df A data frame containing wellness data.
#' @keywords wellness, prediction
#' @export
#' @examples
#' model <- predict_mood(clean_data)
#' summary(model)
predict_mood <- function(df) {
  df2 <- df %>%
    mutate(mood_binary = ifelse(mood_output == 'Sad', 1, 0))
  glm(mood_binary ~ duration_of_sleep_hours + steps + level_of_stress_scale_1_10,
      data   = df2,
      family = binomial)
}
