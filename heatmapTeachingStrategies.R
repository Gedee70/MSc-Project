library(ggplot2)
library(scales)

# Data for Teaching Strategies Category
data_ts <- data.frame(
  question_title = c(
    "Students stuck in web-browser, what to do?",
    "Encouraging growth mindset in CS lesson",
    "Answering 'How is this useful to me?'",
    "Get the start more easily & quicker"
  ),
  view_count = c(11189, 553, 267, 153),
  sector = c("Secondary","Secondary", "Secondary", "Secondary")
)

# Order the data by view count (ascending order)
data_ts <- data_ts[order(data_ts$view_count), ]

# Create the heatmap using geom_tile
ggplot(data_ts, aes(x = factor(question_title, levels = question_title), y = 1, fill = view_count)) +
  geom_tile(color = "white", linewidth = 0.1) +  # Tiles with borders
  scale_fill_gradient(low = "lightblue", high = "darkblue", 
                      name = "View Count", 
                      limits = c(0, 12500)) +  # Force scale between 0 and 12500
  theme_minimal() +
  labs(x = "Question Title", y = NULL, title = "Teaching Strategies View Count Ordered Heatmap") +
  
  # Change text colour based on the sector
  geom_text(aes(label = question_title, color = sector), angle = 90, hjust = 1, vjust = 1, size = 3) +
  
  # Define sector colours
  scale_color_manual(values = c("Tertiary" = "black", "Secondary" = "blue")) +
  
  theme(axis.text.y = element_blank(),  # Hide y-axis
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),  # Remove default x-axis text 
        legend.position = "none")  # Position the legend on the right side
