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

# Split the data by gender, assuming you have a gender column
male_clean_data <- clean_data |> filter(gender == "Male")
female_clean_data <- clean_data |> filter(gender == "Female")

# Split the data by CDC weight categories, assuming you have a bmi column
underweight_clean_data <- clean_data |> filter(bmi < 18.5)
healthy_weight_clean_data <- clean_data |> filter(bmi >= 18.5 & bmi < 25.0)
overweight_clean_data <- clean_data |> filter(bmi >= 25 & bmi < 30.0)
obese_clean_data <- clean_data |> filter(bmi > 30)

# write the datasets to new csv files!
write_csv(clean_data, "data_and_output/calculated_data.csv", na = "")
write_csv(male_clean_data, "data_and_output/male_calculated_data.csv", na = "")
write_csv(female_clean_data, "data_and_output/female_calculated_data.csv", na = "")
write_csv(underweight_clean_data, "data_and_output/underweight_calculated_data.csv", na = "")
write_csv(healthy_weight_clean_data, "data_and_output/healthy_weight_calculated_data.csv", na = "")
write_csv(overweight_clean_data, "data_and_output/overweight_calculated_data.csv", na = "")
write_csv(obese_clean_data, "data_and_output/obese_calculated_data.csv", na = "")

