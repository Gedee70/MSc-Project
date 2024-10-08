library(ggplot2)

# Data for the categories and their view counts
data_categories <- data.frame(
  category = c(
    "Assessment", "Course design", "Cross-curricular computing",
    "EDI", "Education Research", "Futures", "Group work", 
    "Remote learning", "Reporting", "Resource recommendation", 
    "Teaching Strategies", "Term definition", "Topic delivery"
  ),
  view_count = c(
    12890, 33932, 916, 289, 238, 5830, 555, 
    81, 65, 1371, 12335, 4297, 24621
  )
)

# Order the data by view count (ascending order)
data_categories <- data_categories[order(data_categories$view_count), ]

# Create a pastel rainbow palette by blending lighter shades
pastel_rainbow <- colorRampPalette(c(
  "#FFB3BA",  # Pastel red
  "#FFDFBA",  # Pastel orange
  "#FFFFBA",  # Pastel yellow
  "#51ed78",  # Green
  "#BAE1FF",  # Pastel blue
  "#D1BAFF",  # Pastel purple
  "#FFBADF"   # Pastel pink
))(7)

# Create the heatmap using geom_tile
ggplot(data_categories, aes(x = factor(category, levels = category), y = 1, fill = view_count)) +
  geom_tile(color = "white", linewidth = 0.1) +  # Tiles with borders
  
  # Apply colour scale
  scale_fill_gradientn(colors = pastel_rainbow, 
                       name = "View Count", 
                       limits = c(0, 35000)) +  # Set limits for the scale
  
  # Customize the plot
  theme_minimal() +
  labs(x = "Category", y = NULL, title = "View Count Heatmap by Category (Ordered)") +
  
  # Adjust theme for better readability
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.text.y = element_blank(),  # Hide y-axis
        axis.ticks.y = element_blank(),  # Hide y-axis ticks
        legend.position = "right")  # Position legend on the right side
