library(dplyr)
library(ggplot2)

# 只保留 copy number ≤ 10 的数据
df_filtered <- df_long %>% filter(CopyNumber <= 10)

# 统计每个 CopyNumber-物种 的频数
df_summary <- df_filtered %>%
  group_by(Species, CopyNumber) %>%
  summarise(Count = n())

# 绘图（避免 y=0 问题）
ggplot(df_summary, aes(x = factor(CopyNumber), y = Count, fill = Species)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_y_log10() +
  labs(title = "Distribution of gene copy counts (copy number ≤ 10)",
       x = "Copy number", y = "Number of orthogroups (log scale)") +
  theme_minimal() +
  theme(text = element_text(family = "Arial", size = 14))
