library(ggplot2)
library(scales)

data <- data.frame(
  question_title = c(
    "Revision Control",
    "Goto statement or flowcharts",
    "Pseudocode or Flowcharts?",
    "Redesigning a C++ Course",
    "Order to teach looping constructs",
    "Statistics in a CS degree",
    "Value in teaching pseudo code?",
    "Teach selection ('if') before variables?",
    "A-level struggles without GCSE",
    "UML in a degree?",
    "Have databases disappeared at GCSE?",
    "Improving a lessons whilst removing bias"
  ),
  view_count = c(11335, 7770, 5554, 3430, 2240, 1806, 849, 402, 176, 167, 121, 82),
  sector = c("Tertiary", "Undetermined", "Secondary", "Tertiary", "Secondary",
             "Tertiary", "Secondary", "Secondary", "Secondary", "Tertiary",
             "Secondary", "Secondary")
)

# Order the data by view count (ascending order)
data <- data[order(data$view_count), ]

# Create the heatmap using geom_tile
ggplot(data, aes(x = factor(question_title, levels = question_title), y = 1, fill = view_count)) +
  geom_tile(color = "white", linewidth = 0.1) +  # Tiles with borders
  scale_fill_gradient(low = "lightblue", high = "darkblue", 
                      name = "View Count", 
                      limits = c(0, 12500)) +  # Force scale between 0 and 12500
  theme_minimal() +
  labs(x = "Shortened Question Title", y = NULL, title = "Course Design View Count Ordered Heatmap") +
  
  # Change text colour based on the sector
  geom_text(aes(label = question_title, color = sector), angle = 90, hjust = 1, vjust = 1, size = 3) +
  
  # Define sector colours
  scale_color_manual(values = c("Tertiary" = "purple", "Secondary" = "blue", "Undetermined" = "black")) +
  
  theme(axis.text.y = element_blank(),  # Hide y-axis
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),  # Remove default x-axis text (now we use geom_text)
        legend.position = "right")  # Position the legend on the right side
