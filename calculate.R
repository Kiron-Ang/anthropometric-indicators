# Make sure to install and load tidyverse!
# install.packages("tidyverse")
library(tidyverse)

# Read .csv file containing cleaned dataset!
clean_data <- read_csv("data_and_output/clean_data.csv")

clean_data <- clean_data |> janitor::clean_names()

# This will create a new column. It'll get the average of available values, but
# will skip NA values. So if only one measurement is available, the new column
# will just have that one value!
clean_data["average_height"] <- rowMeans(clean_data[c("height_cm_trial_1", "height_cm_trial_2")], na.rm = TRUE)
clean_data["average_weight"] <- rowMeans(clean_data[c("weight_kg_trial_1", "weight_kg_trial_2")], na.rm = TRUE)
clean_data["average_hip"] <- rowMeans(clean_data[c("hip_cm_trial_1", "hip_cm_trial_2")], na.rm = TRUE)
clean_data["average_waist"] <- rowMeans(clean_data[c("waist_cm_trial_1", "waist_cm_trial_2")], na.rm = TRUE)

# Use mutate to calculate anthropometric indicators!
clean_data <- clean_data |> mutate(
    bmi = average_weight / ((average_height / 100) ^ 2),
    whr = average_waist / average_hip,
    whtr = average_waist / average_height,
    wwi = average_waist / sqrt(average_weight)
)

# get some diagnostic information on the dataset before we write it
summary(clean_data)
str(clean_data)
head(clean_data)
problems(clean_data)

# write the dataset to a new csv file!
write_csv(clean_data, "calculated_data.csv", na = "")
