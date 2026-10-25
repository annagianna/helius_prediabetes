# helius_prediabetes

**Gut-muscle axis and new-onset prediabetes in the HELIUS cohort**

Anna Giannakogeorgou

> First draft. Will be updated as the analysis scripts are added.

## Aim

Investigate whether baseline gut microbiota composition (HELIUS-1) is associated with new-onset prediabetes at follow-up (HELIUS-2) in normoglycaemic participants. We also test whether muscle-related factors (fat-free mass index, handgrip strength) mediate this association, which plasma metabolites are involved, and whether associations differ across ethnic groups.

## Definitions of glycaemic status

Based on the ADA Standards of Care in Diabetes — 2026 [1]. HELIUS has no OGTT data, so we use **fasting plasma glucose (FPG)** and **HbA1c** only, plus glucose-lowering medication use. This is done separately for H1 and H2:

| Status | Criteria |
|---|---|
| **T2D** | FPG ≥ 7.0 mmol/L, **or** HbA1c ≥ 48 mmol/mol (6.5%), **or** use of glucose-lowering medication (ATC A10) |
| **Prediabetes** | FPG 5.6–6.9 mmol/L, **or** HbA1c 39–47 mmol/mol (5.7–6.4%) |
| **NGT** | FPG < 5.6 mmol/L **and** HbA1c < 39 mmol/mol (both must be available) |

- Self-reported diabetes on its own is not used to classify participants.
- An abnormal value on any available test is enough to assign T2D or prediabetes. NGT requires both tests to be available and normal. Otherwise, the status is set to `NA`.

## Study population

Participants with both HELIUS-1 and HELIUS-2 data, then (see the flowchart in `0a`):

1. Baseline 16S microbiome data available *(not yet merged)*
2. Exclude antibiotic use in the past 3 months (H1)
3. Exclude T2D at H1
4. Keep NGT at H1 only
5. Glycaemic status classifiable at H2

**Primary outcome:** glycaemic status at H2 (NGT vs. new-onset prediabetes).

## Repository structure

```
scripts/
  0a_datacleaning_clinical.R   # clinical + diet variables, body composition (FFMI/FMI),
                               # weight change, glycaemic status, analysis cohort, metabolomics
  0b_datacleaning_mb.R         # 16S: keep Bacteria, drop chloroplast/mitochondria, drop zero-count ASVs,
                               # filter ASVs >0.05% rel. abundance in >10% of samples
data/                          # raw_data/ and processed_data/ (git-ignored)
results/                       # tables/ and graphs/ (git-ignored)
```

## Data

HELIUS data are **not** included in this repository and must never be committed (enforced via `.gitignore`).

Expected input files:
- `data/raw_data/clinical_data/251111_HELIUS data Anna Giannakogeorgou.sav`
- `data/raw_data/microbiome_data/HELIUS_251111.phyloseq.RDS`

## Environment

The R environment is managed with [pixi](https://pixi.sh) (`pixi.toml`, `pixi.lock`; R 4.5, tidyverse, haven, here, phyloseq, MetBrewer).

```bash
pixi install
pixi run Rscript scripts/0a_datacleaning_clinical.R
pixi run Rscript scripts/0b_datacleaning_mb.R
```

Run the scripts from the project root.

## References

1. American Diabetes Association Professional Practice Committee. 2. Diagnosis and Classification of Diabetes: Standards of Care in Diabetes—2026. *Diabetes Care* 2026;49(Suppl. 1):S27–S49. doi:[10.2337/dc26-S002](https://doi.org/10.2337/dc26-S002)
