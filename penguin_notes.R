### REPRODUCIBLE DATA IN R - USING OPEN SOURCE PENGUINS DATASET
# AUTHOR: HOLLY BARTLETT

# load packages (NEVER use install.packages()!!)
library(tidyverse)
library(palmerpenguins)
library(janitor)
library(here)

# set working directory to where we are now (using here() instead of setwd() means it will run on any computer)
here()

# show first 6 rows of penguin data
head(penguins_raw)

# show column names (problems with white spaces, brackets/slash, random capitalisation, unnecessary comments)
colnames(penguins_raw)

# preserving our raw data - write data to csv (use "data" rather than \data as slashes are different directions on different computers?)
write.csv(penguins_raw, here("data", "penguins_raw.csv"))

# use select and hyphen (NEED hyphen otherwise will remove every column except this one) to remove "Comments" column
penguins_raw <- select(penguins_raw, -Comments)
colnames(penguins_raw)

# we can get rid of the 2 Delta columns at once 
penguins_raw <- select(penguins_raw, -starts_with("Delta"))
# BUT this is bad code: we have already done something to penguins_raw and now we are trying to do it again??

# load raw data again from csv using here
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))
colnames(penguins_raw)

# using piping ( %>% ) to remove comments and delta columns, and clean_names() from janitor package to make all columns computer readable and human readable - removing capitals, spaces, brackets etc.
penguins_clean <- penguins_raw %>% 
  select(-Comments) %>% 
  select(-starts_with("Delta")) %>% 
  clean_names()
colnames(penguins_clean)



## making a function to clean the data

# we can make a new function called cleaning_penguin_columns:
# a couple rows (delta and comments) look different because we have already cleaned our columns 
cleaning_penguin_columns <- function(raw_data){
  raw_data %>% 
    clean_names() %>% 
    remove_empty(c("rows", "cols")) %>% 
    select(-starts_with("delta")) %>% 
    select(-comments)
}
# this function is quite specific (dataset must have columns called "comments" and delta" to be removed)
# we can rewrite the code for this function so that the new user can specify the names of the columns they want to remove

# loading the raw data again:
penguins_raw <- read.csv(here("data", "penguins_raw.csv"))

# check the column names
colnames(penguins_raw)

# running the function
penguins_clean <- cleaning_penguin_columns(penguins_raw)
# it doesn't matter if the input when you call the function is different to the input in the definition (we used raw_data in the function but penguins_raw when using the function)

# checking the output
colnames(penguins_clean)

# write the clean data to a csv using here()
write.csv(penguins_clean, here("data", "penguins_clean.csv"))



## we want to save a safe copy of our cleaning code in a different script

# making a new subfolder - DON'T RERUN THIS CODE
dir.create(here("functions"))

# making a new script within this subfolder - DON'T RERUN THIS CODE
file.create(here("functions", "cleaning.R"))

# we have been given some functions to put into this file, and I have added some more



## subsetting the data - NEXT SESSION

# use select to get species and body mass
penguins_selected <- penguins_clean %>% 
  select(species, body_mass_g) 

# look at the head of the data
head(penguins_selected)
# we have an NA - we have already removed empty rows but this is just a missing value

# count the number of rows and the number of missing values
nrow(penguins_selected) # 344 rows
sum(is.na(penguins_selected)) # 2 missing values ??

# define a function to remove any empty columns or rows
remove_empty_columns_rows <- function(penguins_data) {
  penguins_data %>%
    remove_empty(c("rows", "cols"))
}

# removing missing values 
penguins_selected <- remove_empty_columns_rows(penguins_selected)

#???

# we are overwriting - use pipe to get species and body mass and remove missing values
penguins_selected <- penguins_clean %>% 
  select(species, body_mass_g) %>% 
  remove_empty_columns_rows() %>% 
  print("number of rows:")

# print number of rows and missing values




## filter by species 

# filter by species adelie
# look at the head of the data


# get body mass and species for adelie penguins only
# look at the head of the data





## using renv to install libraries in a reproducible way

## initialising renv (only necessary if there isn't already a renv folder in the working directory)
renv::init()
renv::diagnostics()

# install a new library
renv::install("table1")

# create a lockfile (snapshot) with the current state of dependencies in the project library
renv::snapshot()

# for the next user: uses the renv folder to install all the right libraries (from the snapshot that you created)
renv::restore() 

