library(dplyr)
library(ggplot2)

#only save copy number ≤ 10 data
df_filtered <- df_long %>% filter(CopyNumber <= 10)

# summary every CopyNumber_sequency
df_summary <- df_filtered %>%
  group_by(Species, CopyNumber) %>%
  summarise(Count = n())

ggplot(df_summary, aes(x = factor(CopyNumber), y = Count, fill = Species)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_y_log10() +
  labs(title = "Distribution of gene copy counts (copy number ≤ 10)",
       x = "Copy number", y = "Number of orthogroups (log scale)") +
  theme_minimal() +
  theme(text = element_text(family = "Arial", size = 14))
