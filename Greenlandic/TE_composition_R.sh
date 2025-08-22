df_wide <- tibble::tribble(
  ~Species, ~LTR, ~LINE, ~SINE,
  "groenlandica", 1751953, 38197, 20196,
  "hap2", 4400972, 39362, 10125,
  "pyrenaica", 31539495, 59236, 9550
)

library(tidyverse)

# change long to wide
df_long <- df_wide %>%
  pivot_longer(cols = -Species, names_to = "TE_Type", values_to = "Length")


ggplot(df_long, aes(x = Species, y = Length, fill = TE_Type)) +
  geom_bar(stat = "identity") +
  scale_y_log10() +   #use log
  geom_text(aes(label = scales::comma(Length)), 
            position = position_stack(vjust = 0.5), size = 3, color = "blue") +
  labs(title = "TE Composition across Three Genomes (log scale)",
       x = "Species", y = "Total TE Length (bp)", fill = "TE Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, face = "bold")) +
  scale_fill_brewer(palette = "Set3")
