# Make sure to install and load tidyverse!
# install.packages("tidyverse")
library(tidyverse)

# Read .csv file containing cleaned dataset!
clean_data <- read_csv("data_and_output/clean_data.csv")

clean_data <- clean_data |> janitor::clean_names()

glimpse(clean_data)