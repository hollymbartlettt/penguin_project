### THIS SCRIPT IS STORING FUNCTIONS TO CLEAN THE PALMER PENGUINS DATASET 
##
## Script name: cleaning.R
## Author: Holly Bartlett
## Date Created: 2024-10-16
##
###



# A function to make sure the column names are cleaned up, 
# eg lower case and snake case
clean_column_names <- function(penguins_data) {
  penguins_data %>%
    clean_names()
}

# A function to remove columns based on a vector of column names
remove_columns <- function(penguins_data, column_names) {
  penguins_data %>%
    select(-starts_with(column_names))
}


# I have created a piped function cleans column names, removes empty rows, remove columns called comment and delta
cleaning_penguin_columns <- function(raw_data){
  raw_data %>% 
    clean_names() %>% 
    remove_empty(c("rows", "cols")) %>% 
    select(-starts_with("delta")) %>% 
    select(-comments)
}


# A function to make sure the species names are shortened
shorten_species <- function(penguins_data) {
  penguins_data %>%
    mutate(species = case_when(
      species == "Adelie Penguin (Pygoscelis adeliae)" ~ "Adelie",
      species == "Chinstrap penguin (Pygoscelis antarctica)" ~ "Chinstrap",
      species == "Gentoo penguin (Pygoscelis papua)" ~ "Gentoo"
    ))
}

# A function to remove any empty columns or rows
remove_empty_columns_rows <- function(penguins_data) {
  penguins_data %>%
    remove_empty(c("rows", "cols"))
}


# A function to remove rows which contain NA values
remove_NA <- function(penguins_data) {
  penguins_data %>%
    na.omit()
}


