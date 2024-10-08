library(ggplot2)
library(scales)

# Data for Topic Delivery category
data_topic_delivery <- data.frame(
  question_title = c(
    "How do I teach Git to a teenager?",
    "Analogy for teaching recursion",
    "Explain computer viruses",
    "Interview lesson'Computational Thinking'",
    "Intro to programming class:Spreadsheets",
    "A beginner eg of xor, that is functional",
    "Pedagogical reason difference in 2 loops",
    "Pedagogical issues:Stack Implementation",
    "To plan or not to plan",
    "Uses of selection in programming",
    "How to teach sums and asymptotics",
    "Looking for puzzle/game programmes",
    "How to 'teach' CSS for students?",
    "Java,teach try-catch from the outset?",
    "Is Cyber-Security E-safety or not?",
    "Best Git strategy for workshop code",
    "Pedagogy research to teach spreadsheets?",
    "Array-like data type in Java for generics?",
    "Good example for a live optimisation exercise"
  ),
  view_count = c(12447, 7801, 851, 670, 519, 324, 289, 264, 243, 209, 195, 154, 129, 119, 117, 107, 86, 49, 34),
  sector = c("secondary", "Secondary", "Secondary", "Secondary", "Secondary",
             "Secondary", "Secondary", "Undetermined", "Secondary", "Secondary",
             "Tertiary", "Tertiary", "Tertiary", "Secondary", "Secondary",
             "Undetermined", "Secondary", "Tertiary", "Tertiary")
)

# Order the data by view count (ascending order)
data_topic_delivery <- data_topic_delivery[order(data_topic_delivery$view_count), ]

# Create the heatmap using geom_tile
ggplot(data_topic_delivery, aes(x = factor(question_title, levels = question_title), y = 1, fill = view_count)) +
  geom_tile(color = "white", linewidth = 0.1) +  # Tiles with borders
  scale_fill_gradient(low = "lightblue", high = "darkblue", 
                      name = "View Count", 
                      limits = c(0, 12500)) +  # Force scale between 0 and 12500
  theme_minimal() +
  labs(x = "Shortened Question Title", y = NULL, title = "Topic Delivery View Count Ordered Heatmap") +
  
  # Change text colour based on the sector
  geom_text(aes(label = question_title, color = sector), angle = 90, hjust = 1, vjust = 1, size = 3) +
  
  # Define sector colours
  scale_color_manual(values = c("Tertiary" = "purple", "Secondary" = "blue", "Undetermined" = "black", "secondary"="white")) +
  
  theme(axis.text.y = element_blank(),  # Hide y-axis
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),  # Remove default x-axis text (now we use geom_text)
        legend.position = "right")  # Position the legend on the right side
