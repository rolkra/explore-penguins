## objects created in global.R
## can be used in server.R

# packages ----------------------------------------------------------------

# packages that are used
library(shiny)
library(DT)
library(tidyverse)
library(explore)
library(palmerpenguins)


# data --------------------------------------------------------------------

data <- palmerpenguins::penguins

# add description for help-tab
data_title <- "Meet the palmer penguins"
  
data_description <- paste(
  "This datasets contain data for 344 penguins.",
  "There are 3 different species of penguins in this dataset,",
  "collected from 3 islands in the Palmer Archipelago, Antarctica.",
  "See https://allisonhorst.github.io/palmerpenguins/"
)

data_variables <- tribble(
  ~variable, ~description,
  "species", "Species of the penguin",
  "island", "island",
  "bill_length_mm", "length of the bill in mm (de: Schnabel Länge)",
  "bill_depth_mm", "depth of the bill in mm (de: Schnabel Tiefe)",
  "flipper_length_mm", "length of the flipper in mm (de: Flossen Länge)",
  "body_mass_g", "body mass in g (de: Gewicht)",
  "sex", "sex (female, male)",
  "year", "year"
)

# prepare for exploration -------------------------------------------------

data <- data
data_title <- data_title
data_description <- data_description
data_variables <- data_variables

target_quo = NA
target_text = NA

# define variables for CRAN-package check
type <- NULL
variable <- NULL

tbl_guesstarget <- describe(data) %>%
  filter(type %in% c("lgl","int","dbl","num","fct","chr")) %>%
  select(variable)
guesstarget <- as.character(tbl_guesstarget[[1]])

# check all variables if usable
for (i in names(data))  {
  if (explore::get_type(data[[i]]) == "other")  {
    data[[i]] <- "<hide>"
  }
}
