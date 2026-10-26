# HELIUS prediabetes project - Cohort selection flowchart
# Anna Giannakogeorgou

# Libraries
library(tidyverse)
library(phyloseq)

# Data
helius_clean_df <- readRDS("data/processed_data/helius_clinical.RDS")
helius_mb_tax <- readRDS("data/processed_data/mb_data/HELIUS_16S_tax_filtered.rds")

## Analysis cohorts & counts (for flowchart)
# Step 0: all participants with H1 & H2 data (already filtered in the data received)
n0 <- nrow(helius_clean_df)

# Step 1: with baseline 16S data
cohort1 <- helius_clean_df |>
  filter(id %in% sample_names(helius_mb_tax))
n1 <- nrow(cohort1)

# Step 2: exclude antibiotic use in past 3 months (missing kept)
cohort2 <- cohort1 |>
  filter(is.na(abx_h1) | abx_h1 != "yes")
n2 <- nrow(cohort2)

# Step 3: exclude diabetes at H1 (FPG >= 7.0, glucose-lowering meds or HbA1c >= 48)
# NA status kept: no evidence of diabetes on any criterion -> dropped at step 4 instead
cohort3 <- cohort2 |>
  filter(is.na(glyc_status_h1) | glyc_status_h1 != "T2D")
n3 <- nrow(cohort3)

## Branch a: development cohort (NGT at H1 -> new-onset prediabetes at H2)
# Step 4a: NGT at H1 only (excludes prediabetes and incomplete FPG/HbA1c)
cohort4a <- cohort3 |>
  filter(glyc_status_h1 == "NGT")
n4a <- nrow(cohort4a)

# Step 5a: exclude unclassifiable glycaemic status at H2
cohort_development <- cohort4a |>
  filter(!is.na(glyc_status_h2))
n5a <- nrow(cohort_development)

## Branch b: remission/progression cohort (PreDM at H1)
# Step 4b: prediabetes at H1 only
cohort4b <- cohort3 |>
  filter(glyc_status_h1 == "PreDM")
n4b <- nrow(cohort4b)

# Step 5b: exclude unclassifiable glycaemic status at H2
cohort_predm <- cohort4b |>
  filter(!is.na(glyc_status_h2))
n5b <- nrow(cohort_predm)

flowchart <- tibble(
  branch = c(rep("shared", 4), rep("development", 2), rep("predm", 2)),
  step = c("H1 & H2 data", "Baseline 16S data", "No antibiotics", "No diabetes H1",
           "Normoglycaemia H1", "Glycaemic status available H2",
           "Prediabetes H1", "Glycaemic status available H2"),
  n_remaining = c(n0, n1, n2, n3, n4a, n5a, n4b, n5b),
  n_excluded = c(NA, n0 - n1, n1 - n2, n2 - n3, n3 - n4a, n4a - n5a, n3 - n4b, n4b - n5b)
)

## Checks
flowchart
cohort3 |> count(glyc_status_h1)                  # branch split: NGT / PreDM / NA (incomplete FPG/HbA1c)
cohort_development |> count(glyc_status_h2)       # incidence (primary outcome)
cohort_predm |> count(glyc_status_h2)             # baseline prediabetes -> H2

# Save
saveRDS(cohort_development, "data/processed_data/helius_cohort_development.RDS")
saveRDS(cohort_predm, "data/processed_data/helius_cohort_predm.RDS")
saveRDS(flowchart, "data/processed_data/helius_flowchart.RDS")
