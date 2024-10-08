# Load necessary libraries
library(ggplot2)
library(dplyr)

# Correct the number of rows in the data frame (every category has exactly 3 sectors: Secondary, Tertiary, and Undetermined)
data <- data.frame(
  Category = c("Assessment", "Assessment", "Assessment",
               "Course design", "Course design", "Course design", 
               "Cross-curricular computing", "Cross-curricular computing", "Cross-curricular computing",
               "EDI", "EDI", "EDI",
               "Education Research", "Education Research", "Education Research",
               "Futures", "Futures", "Futures",
               "Group work", "Group work", "Group work",
               "Remote learning", "Remote learning", "Remote learning",
               "Reporting", "Reporting", "Reporting",
               "Resource recommendation", "Resource recommendation", "Resource recommendation",
               "Teaching Strategies", "Teaching Strategies", "Teaching Strategies",
               "Term definition", "Term definition", "Term definition",
               "Topic delivery", "Topic delivery", "Topic delivery"),
  Sector = c("Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined", 
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined",
             "Secondary", "Tertiary", "Undetermined" ),
  Mean_View_Count = c(552, 3929, NA, 
                      1346, 4185, 7770, 
                      187, 729, NA,
                      NA, 289, NA,
                      238, NA, NA,
                      5830, NA, NA,
                      425, NA, 130,
                      NA, NA, 81,
                      65, NA, NA,
                      218, NA, 239,
                      3048, 144, NA,
                      890, 68, 1558,
                      1977, 119, 135)
)

# Plot
ggplot(data, aes(x = Category, y = Mean_View_Count, fill = Sector)) +
  geom_col(position = position_dodge2(preserve = "single"), width = 0.7, na.rm=TRUE) +
  theme_minimal() +
  labs(title = "Mean Number of Views per Category by Sector",
       x = "Category",
       y = "Mean View Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("Secondary" = "#34a8eb", "Tertiary" = "#ab75e6", "Undetermined" = "grey"))
