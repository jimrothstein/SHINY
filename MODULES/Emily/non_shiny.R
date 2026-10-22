library(shiny)
library(nycflights13)
library(dplyr)
library(ggplot2)


# function to extract data, plot

ua_data <-
  nycflights13::flights %>%
  dplyr::filter(carrier == "UA") %>%
  mutate(ind_arr_delay = (arr_delay > 5)) %>%
  group_by(year, month, day) %>%
  summarize(
    n = n(),
    across(ends_with("delay"), mean, na.rm = TRUE)
  ) %>%
  ungroup()

head(ua_data)
viz_monthly <- function(df, y_var, threshhold = NULL) {
  ggplot(df) +
    aes(
      x = .data[["day"]],
      y = .data[[y_var]]
    ) +
    geom_line() +
    geom_hline(yintercept = threshhold, color = "red", linetype = 2) +
    scale_x_continuous(breaks = seq(1, 29, by = 7)) +
    theme_minimal()
}

ua_data %>%
  dplyr::filter(month == 3) %>%
  viz_monthly("arr_delay", threshhold = 10)
