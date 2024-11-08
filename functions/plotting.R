### THIS SCRIPT IS STORING FUNCTIONS RELATED TO BOXPLOTS 
##
## Script name: plotting.R
## Author: Holly Bartlett
## Date Created: 2024-10-06
##
###



## CREATING BOXPLOTS

# function to create a boxplot - the first section is creating a generalised function, so we can input any variables we want to make a plot with
plot_boxplot <- function(data, 
                         x_column,
                         y_column,
                         x_label,
                         y_label,
                         colour_mapping) {
  
  # drop the rows with NA for y-column values
  data <- data %>% 
    drop_na({{y_column}})
  
  # make the plot
  flipper_boxplot2 <- ggplot(
    data = data, 
    aes(x = {{x_column}},
        y = {{y_column}},
        color = {{x_column}})) + 
    geom_boxplot(
      show.legend = FALSE,
      width = 0.3) +
    geom_jitter(show.legend = FALSE,
                size = 1,
                alpha = 0.3,  # adds some transparency
                position = position_jitter(
                  width = 0.2,
                  seed = 0)) + # random seed: for reproducibility, we want randomness in the figure to be the same every time
    scale_colour_manual(values = colour_mapping) +
    labs(x = x_label,
         y = y_label) +  # add axis labels
    theme_bw()
  return(flipper_boxplot2) # return the plot object
}

# colour palette
species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")

# example of how to use this function
plot_boxplot(penguins_clean, species, flipper_length_mm, "Penguin species", "Flipper length (mm)", species_colours)



## SAVING BOXPLOTS FOR FIGURES

# function to save boxplot as a png file
save_flipper_plot_png <- function(boxplot, filename, size, res, scaling) {
  agg_png(filename, 
          width = size,
          height = size,
          units = "cm",
          res = res,
          scaling = scaling)
  print(boxplot)
  dev.off()
}

# an example of how to use this function 
flipper_boxplot <- plot_boxplot(penguins_clean,
                                species, flipper_length_mm,
                                "Species", "Flipper length (mm)",
                                species_colours)
save_flipper_plot_png(flipper_boxplot,
                      here("figures", "flipper_boxplot_poster.png"),
                      size = 40, res = 300, scaling = 4)
save_flipper_plot_png(flipper_boxplot,
                      here("figures", "flipper_boxplot_powerpoint.png"),
                      size = 20, res = 300, scaling = 3)


# function to save boxplot as an svg file
save_flipper_plot_svg <- function(boxplot,
                                  filename, size, scaling){
  size_inches = size/2.54
  svglite(filename, 
          width = size_inches,
          height = size_inches,
          scaling = scaling)
  print(boxplot)
  dev.off()
}

# an example of how to use this function 
flipper_boxplot <- plot_boxplot(penguins_clean,
                                species, flipper_length_mm,
                                "Species", "Flipper length (mm)",
                                species_colours)
save_flipper_plot_svg(flipper_boxplot,
                      here("figures", "flipper_boxplot_poster.svg"),
                      size = 40, scaling = 4)
save_flipper_plot_svg(flipper_boxplot,
                      here("figures", "flipper_boxplot_powerpoint.svg"),
                      size = 20, scaling = 3)
## for some reason my svg code is not working





