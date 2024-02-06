# Load necessary libraries
library(ggplot2)
library(dplyr)

# Read the CSV file
data <- read.csv("usaCanada.csv", stringsAsFactors = FALSE)

# Clean and prepare the data
# Convert victimcount column to numeric (remove commas)
data$victimcount <- as.numeric(gsub(",", "", data$victimcount))

# Summarize total victims by country
country_summary <- data %>%
  group_by(country) %>%
  summarize(totalVictims = sum(victimcount))

# Define colors for the pie chart
colors <- c("United States" = "mediumpurple", "Canada" = "skyblue")

# Generate the pie chart
ggplot(country_summary, aes(x = "", y = totalVictims, fill = country)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = colors) +
  theme_void() +
  labs(fill = "Country", title = "Victim Count by Country in 2021-2022")

# Display the plot
ggsave("victim_count_by_country_pie_chart.png", width = 8, height = 8)

################################################################################

# Clean and prepare the data
# Convert victimcount column to numeric (remove commas)
data$victimcount <- as.numeric(gsub(",", "", data$victimcount))

# Using dplyr to group and summarize data by country and state
data_grouped <- data %>%
  group_by(country, state) %>%
  summarize(victimCount = sum(victimcount), .groups = 'drop')

# Define colors for the bar plot
colors <- c("United States" = "mediumpurple", "Canada" = "skyblue")

# Generate the bar plot
ggplot(data_grouped, aes(x = reorder(state, victimCount), y = victimCount, fill = country)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = colors) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Victim Count by State and Country", x = "State", y = "Victim Count")

# Display the plot
ggsave("victim_count_by_state_country_barplot.png", width = 20, height = 10)

################################################################################

# Clean and prepare the data
# Convert lossamount column to numeric (remove commas)
data$lossamount <- as.numeric(gsub(",", "", data$lossamount))

# Generate the histogram
ggplot(data, aes(x = lossamount, fill = country)) +
  geom_histogram(binwidth = 50000, color = "black", position = "identity", alpha = 0.6) +
  scale_fill_manual(values = c("United States" = "mediumpurple", "Canada" = "skyblue")) +
  labs(title = "Histogram of Loss Amount by Country", x = "Loss Amount", y = "Frequency") +
  theme_minimal()

# Display the plot
ggsave("loss_amount_histogram.png", width = 20, height = 10)

################################################################################

# Convert the lossamount to numeric in case it's read as a factor or character
# This assumes the lossamount column is free of commas or other non-numeric characters
# If there are commas, they need to be removed before conversion
data$lossamount <- as.numeric(as.character(data$lossamount))

# Create the boxplot
ggplot(data, aes(x = country, y = lossamount, fill = country)) +
  geom_boxplot(outlier.shape = NA) + # Hide outliers for cleaner appearance
  scale_fill_manual(values = c("United States" = "mediumpurple", "Canada" = "skyblue")) +
  labs(title = "Boxplot of Loss Amount by Country", x = "Country", y = "Loss Amount") +
  theme_minimal()

# Save the boxplot
ggsave("boxplot_loss_amount_by_country.png", width = 20, height = 10)

################################################################################
# FOR EDITED PRESENTATION
# Convert the lossamount to numeric in case it's read as a factor or character
# This assumes the lossamount column is free of commas or other non-numeric characters
# If there are commas, they need to be removed before conversion
data$lossamount <- as.numeric(as.character(data$lossamount))

# Create the boxplot
ggplot(data, aes(x = country, y = lossamount, fill = country)) +
  geom_boxplot(outlier.shape = NA) + # Hide outliers for cleaner appearance
  scale_fill_manual(values = c("United States" = "mediumpurple", "Canada" = "skyblue")) +
  scale_y_continuous(limits = c(NA, 1500)) + # Set y-axis limits, max_limit to be determined
  labs(title = "Boxplot of Loss Amount by Country", x = "Country", y = "Loss Amount") +
  theme_minimal()

# Save the boxplot
ggsave("boxplot_loss_amount_by_country.png", width = 20, height = 10)

################################################################################
# FOR EDITED PRESENTATION
# Clean and prepare the data
# Convert victimcount and population columns to numeric (remove commas)
data$victimcount <- as.numeric(gsub(",", "", data$victimcount))
data$population <- as.numeric(gsub(",", "", data$population))

# Calculate victim count per 10,000 in population
data$victims_per_10000 <- (data$victimcount / data$population) * 10000

# Using dplyr to group and summarize data by country and state
data_grouped <- data %>%
  group_by(country, state) %>%
  summarize(victimsPer10000 = sum(victims_per_10000), .groups = 'drop')

# Define colors for the bar plot
colors <- c("United States" = "mediumpurple", "Canada" = "skyblue")

# Generate the bar plot
ggplot(data_grouped, aes(x = reorder(state, victimsPer10000), y = victimsPer10000, fill = country)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = colors) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Victim Count per 10,000 in Population by State and Country", x = "State", y = "Victims per 10,000")

# Display the plot
ggsave("victims_per_10000_by_state_country_barplot.png", width = 20, height = 10)