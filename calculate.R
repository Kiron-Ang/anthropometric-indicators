# Make sure to install and load tidyverse!
# install.packages("tidyverse")
library(tidyverse)

# Read .csv file containing cleaned dataset!
clean_data <- read_csv("data_and_output/clean_data.csv")

clean_data <- clean_data |> janitor::clean_names()

clean_data["average_height"] <- rowMeans(clean_data[c("height_cm_trial_1", "height_cm_trial_2")], na.rm = TRUE)

summary(clean_data)
str(clean_data)
head(clean_data)
problems(clean_data)