install.packages("ggfortify")
library(tidyverse)
library(ggfortify)  # 用于 autoplot PCA

# input data
te_matrix <- tribble(
  ~Species,       ~LTR,       ~LINE,   ~SINE,
  "groenlandica", 1751953,     38197,   20196,
  "hap2",         4400972,     39362,   10125,
  "pyrenica",    31539495,     59236,    9550
)

# extract coordinate data from PCA objects
data_pca <- as.data.frame(te_pca$x)

# add sample list (row name is species)
data_pca$Sample <- rownames(data_pca)

head(data_pca)

library(ggplot2)

# Calculate the variance interpretation ratio
pca_var <- te_pca$sdev^2 / sum(te_pca$sdev^2)

library(ggrepel)

ggplot(data_pca, aes(x = PC1, y = PC2, label = Sample)) +
  geom_point(size = 4, color = "steelblue") +
  geom_text_repel(size = 5) + 
  labs(title = "PCA of TE Family Composition",
       x = paste0("PC1 (", round(pca_var[1]*100, 2), "%)"),
       y = paste0("PC2 (", round(pca_var[2]*100, 2), "%)")) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    panel.grid = element_line(color = "grey90"),
    axis.title = element_text(face = "bold")
  )


df_wide <- tibble::tribble(
  ~Species, ~LTR, ~LINE, ~SINE,
  "groenlandica", 1751953, 38197, 20196,
  "hap2", 4400972, 39362, 10125,
  "pyrenica", 31539495, 59236, 9550
)



#for drawing bar chart
library(tidyverse)

# convert wide format data to long format
df_long <- df_wide %>%
  pivot_longer(cols = -Species, names_to = "TE_Type", values_to = "Length")


ggplot(df_long, aes(x = Species, y = Length, fill = TE_Type)) +
  geom_bar(stat = "identity") +
  scale_y_log10() +   # using logarithmic coordinates
  geom_text(aes(label = scales::comma(Length)), 
            position = position_stack(vjust = 0.5), size = 3, color = "blue") +
  labs(title = "TE Composition across Three Genomes (log scale)",
       x = "Species", y = "Total TE Length (bp)", fill = "TE Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, face = "bold")) +
  scale_fill_brewer(palette = "Set3")


