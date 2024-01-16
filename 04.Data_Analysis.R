head(data)
library(ggplot2)
install.packages("scales")
library(scales)
library(dbplyr)
library(tidyverse)
ggplot(data, aes(x = member_casual, fill = rideable_type)) +
  geom_bar(position = "stack") +
  labs(title = "Bike Types Used by Member Type",
       x = "Member Type",
       y = "Percentage") +
  scale_y_continuous(labels = scales::percent_format(scale=0.0001)) +  # Format y-axis as percentage
  theme_minimal()

# Calculate percentages for each combination
percentage_data <- data %>%
  group_by(rideable_type, member_casual) %>%
  summarize(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

# Create a pie chart for each rideable_type
ggplot(percentage_data, aes(x = "", y = percentage, fill = member_casual)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  facet_wrap(~rideable_type) +
  coord_polar(theta = "y") +
  labs(title = "Percentage of Member Type Usage for Each Bike Type",
       x = NULL, y = NULL) +
  scale_fill_manual(values = c("#3376BD", "#EDAE49"), name = "Member Type") +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  ) +
  geom_text (
    aes(x = 1.3, label = paste0(round(percentage),"%")),
    position = position_stack(vjust = 0.5),
    size = 3,
    color = "black")
overall_percentage_data <- data %>%
  group_by(member_casual) %>%
  summarize(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)
ggplot(overall_percentage_data, aes(x = "", y = percentage, fill = member_casual)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar(theta = "y") +
  labs(title = "Overall Percentage of Member Type Bike Usage",
       x = NULL, y = NULL) +
  scale_fill_manual(values = c("#3376BD", "#EDAE49"), name = "Member Type") +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  ) +
  geom_text(
    aes(x = 1.3, label = paste0(round(percentage), "%")),
    position = position_stack(vjust = 0.5),
    size = 4,
    color = "black"
  )
#------------------------------------------------------------------------------



