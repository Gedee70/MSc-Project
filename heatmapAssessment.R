library(ggplot2)
library(scales)

# Data for Assessment Category
data_assessment <- data.frame(
  question_title = c(
    "What to tell students who plagiarised programming assignments?",
    "Should test cases be available to students for assessments?",
    "How do you assess students' understanding of abstraction?",
    "Encouraging reflection & improvement after summative assessment",
    "What's the best way to assess programming?",
    "How might I structure an assignment with two 'levels'?"
  ),
  view_count = c(7997, 3478, 810, 312, 293, 144),
  sector = c("Tertiary", "Tertiary", "Secondary", "Tertiary", "Secondary", "Tertiary")
)

# Order the data by view count (ascending order)
data_assessment <- data_assessment[order(data_assessment$view_count), ]

# Create the heatmap using geom_tile
ggplot(data_assessment, aes(x = factor(question_title, levels = question_title), y = 1, fill = view_count)) +
  geom_tile(color = "white", linewidth = 0.1) +  # Tiles with borders
  scale_fill_gradient(low = "lightblue", high = "darkblue", 
                      name = "View Count", 
                      limits = c(0, 12500)) +  # Force scale between 0 and 12500
  theme_minimal() +
  labs(x = "Question Title", y = NULL, title = "Assessment View Count Ordered Heatmap") +
  
  # Change text colour based on the sector
  geom_text(aes(label = question_title, color = sector), angle = 90, hjust = 1, vjust = 1, size = 3) +
  
  # Define sector colours
  scale_color_manual(values = c("Tertiary" = "black", "Secondary" = "blue")) +
  
  theme(axis.text.y = element_blank(),  # Hide y-axis
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),  # Remove default x-axis text 
        legend.position = "right")  # Position the legend on the right side
