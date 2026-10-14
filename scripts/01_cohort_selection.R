# 01_cohort_selection.R
# Build the analytic cohort and flowchart counts (overall and by ethnicity).
#
# Steps:
#   1. HELIUS-1 microbiome data AND HELIUS-2 follow-up
#   2. Exclude baseline diabetes (self-report, FPG >= 7.0, HbA1c >= 48, or glucose-lowering medication)
#   3. Exclude baseline prediabetes (FPG 5.6-6.9 mmol/L or HbA1c 39-47 mmol/mol)
#   4. Exclude missing outcome at HELIUS-2
#   5. Report overlap with shotgun metagenomics, metabolomics, diet, BIA, handgrip

library(tidyverse)
library(haven)

clin <- read_sav("data/raw_data/251111_HELIUS data Anna Giannakogeorgou.sav")
ps   <- readRDS("data/raw_data/HELIUS_251111/HELIUS_251111.phyloseq.RDS")
