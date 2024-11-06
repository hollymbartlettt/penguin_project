# GENERALISED FUNCTION - no set column names makes it applicable to any boxplot?
plot_boxplot <- function(data, 
                         x_column,
                         y_column,
                         x_label,
                         y_label,
                         colour_mapping) {
  
  # drop the na's
  data <- data %>% 
    drop_na({{y_column}})
  
  # make the plot
  flipper_boxplot2 <- ggplot(
    data = data, 
    aes(x = {{x_column}},
        y = {{y_column}},
        color = {{x_column}})) + 
    geom_boxplot(
      width = 0.3,
      show.legend = FALSE) +
    geom_jitter(aes(color = species),
                size = 1,
                alpha = 0.3,  # adds some transparency
                show.legend = FALSE,  # add the raw data on top (jitter gives each point random variation around the central point)
                position = position_jitter(
                  width = 0.2,
                  seed = 0)) + # random seed: for reproducibility, we want randomness in the figure to be the same every time
    scale_colour_manual(values = colour_mapping) +
    labs(x = x_label,
         y = y_label) +  # add axis labels
    theme_bw()
  flipper_boxplot2
}


species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")

plot_boxplot(penguins_clean, "species", "flipper_length_mm", "Penguin species", "Flipper length (mm)", "species_colours")




