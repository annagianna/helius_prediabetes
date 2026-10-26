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

# Remove ASVs with zero counts across all samples
helius_mb_tax <- prune_taxa(taxa_sums(helius_mb_tax) > 0, helius_mb_tax)

# Convert counts to rel. abundance (%)
helius_mb_rel <- transform_sample_counts(helius_mb_tax, \(x) 100 * x / sum(x))

# Retain ASVs with >0.05% relative abundance in >10% of samples
helius_mb_rel_filtered <- filter_taxa(helius_mb_rel, \(x) sum(x > 0.05) > 0.10 * length(x), prune = TRUE)
helius_mb_counts_filtered <- prune_taxa(taxa_names(helius_mb_rel_filtered), helius_mb_tax) # Retain corresponding raw counts

## Save cleaned 16S objects
dir.create("data/processed_data/mb_data", recursive = TRUE, showWarnings = FALSE)
saveRDS(helius_mb_tax, "data/processed_data/mb_data/HELIUS_16S_tax_filtered.rds") # Taxonomically filtered counts (for alpha beta diversity)
saveRDS(helius_mb_counts_filtered, "data/processed_data/mb_data/HELIUS_16S_counts_prev10.rds") # Prevalence-filtered counts (10%)
saveRDS(helius_mb_rel_filtered, "data/processed_data/mb_data/HELIUS_16S_rel_prev10.rds") # Prevalence-filtered rel abundances (10%)

# Expected dimensions
ntaxa(helius_mb_tax)                  # 22053
ntaxa(helius_mb_rel_filtered)         # 314
ntaxa(helius_mb_counts_filtered)      # 314

# No zero-count taxa or samples
sum(taxa_sums(helius_mb_tax) == 0)     # 0
sum(sample_sums(helius_mb_tax) == 0)   # 0

# Relative abundances sum to 100%
summary(sample_sums(helius_mb_rel))

# Matching ASVs
identical(taxa_names(helius_mb_rel_filtered), taxa_names(helius_mb_counts_filtered))

# Saved files exist
file.exists(c(
  "data/processed_data/mb_data/HELIUS_16S_tax_filtered.rds",
  "data/processed_data/mb_data/HELIUS_16S_counts_prev10.rds",
  "data/processed_data/mb_data/HELIUS_16S_rel_prev10.rds"
))
