# HELIUS prediabetes project - 16S data cleaning
# Anna Giannakogeorgou

# Libraries
library(tidyverse)
library(phyloseq)

# Data
helius_mb <- readRDS("data/raw_data/microbiome_data/HELIUS_251111.phyloseq.RDS")

## Cleaning
# Taxonomic filtering (remove archaea, chloroplasts, mitos)
helius_mb_tax <- subset_taxa(
  helius_mb,
  Kingdom == "Bacteria" &
    (is.na(Order) | Order != "Chloroplast") &
    (is.na(Family) | Family != "Mitochondria")
)

# Calculate ASV prevalence (taxa are rows)
asv_prev <- apply(as(otu_table(helius_mb_tax), "matrix"), 1, \(x) sum(x > 0))

# Convert counts to rel. abundance (%)
helius_mb_rel <- transform_sample_counts(helius_mb_tax, \(x) 100 * x / sum(x))
rel_mat <- as(otu_table(helius_mb_rel), "matrix") # extract rel. abundance matrix
