install.packages("tidyverse")
library(tidyverse)

# reda three species data
groen <- read_tsv("TE_lengths_groenlandica.tsv", col_names = c("TE_Type", "Length")) %>%
  mutate(Species = "groenlandica")
hap2 <- read_tsv("TE_lengths_hap2.tsv", col_names = c("TE_Type", "Length")) %>%
  mutate(Species = "hap2")
pyre <- read_tsv("TE_lengths_pyrenica.tsv", col_names = c("TE_Type", "Length")) %>%
  mutate(Species = "pyrenica")

# mix data
df <- bind_rows(groen, hap2, pyre)

# convert the data to wide format and then back to long format, to ensure that the missing value is 0
df_wide <- pivot_wider(df, names_from = TE_Type, values_from = Length, values_fill = 0)
df_long <- pivot_longer(df_wide, cols = -Species, names_to = "TE_Type", values_to = "Length")

# for printing stacked bar chart
ggplot(df_long, aes(x = Species, y = Length / 1e6, fill = TE_Type)) +
  geom_bar(stat = "identity") +
  labs(title = "TE Composition across Three Genomes",
       x = "Species", y = "Total TE Length (Mb)", fill = "TE Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, face = "bold"))

ggplot(df_long, aes(x = Species, y = Length / 1e6, fill = TE_Type)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = round(Length / 1e6, 1)),  
            position = position_stack(vjust = 0.5), size = , color = "white") +
  labs(title = "TE Composition across Three Genomes",
       x = "Species", y = "Total TE Length (Mb)", fill = "TE Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, face = "bold"))

# R for pca plot
install.packages("ggfortify")
library(tidyverse)
library(ggfortify)  # 用于 autoplot PCA

te_matrix <- tribble(
  ~Species,       ~LTR,       ~LINE,   ~SINE,
  "groenlandica", 1751953,     38197,   20196,
  "hap2",         4400972,     39362,   10125,
  "pyrenica",    31539495,     59236,    9550
)

data_pca <- as.data.frame(te_pca$x)

data_pca$Sample <- rownames(data_pca)

head(data_pca)

library(ggplot2)

# calculate the variance interpretation ratio
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
