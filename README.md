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

## Handgrip strength

Handgrip strength is used both as absolute grip (kg; mean and max of the H1 measurements) and as **relative grip** (kg grip per kg body weight; `handgrip_mean_rel_h1`, `handgrip_max_rel_h1`).

- A meta-analysis of prospective cohorts found that relative grip predicted incident T2D better than absolute grip [2].
- Grip strength divided by body weight was associated with incident diabetes [3] and with prevalent T2D independent of BMI [4]. Lower grip strength divided by BMI was associated with prediabetes in men [5].

## Study population

Participants with both HELIUS-1 and HELIUS-2 data, then (see the flowchart in `0c`):

1. Baseline 16S microbiome data available
2. Exclude antibiotic use in the past 3 months (H1)
3. Exclude T2D at H1
4. Split by H1 status: NGT (development cohort) or prediabetes (remission/progression cohort)
5. Glycaemic status classifiable at H2

**Primary outcome:** glycaemic status at H2 (NGT vs. new-onset prediabetes).

## Repository structure

```
scripts/
  0a_datacleaning_clinical.R   # clinical + diet variables, body composition (FFMI/FMI), relative handgrip,
                               # weight change, glycaemic status, metabolomics
  0b_datacleaning_mb.R         # 16S: keep Bacteria, drop chloroplast/mitochondria, drop zero-count ASVs,
                               # filter ASVs >0.05% rel. abundance in >10% of samples
  0c_cohort_selection.R        # analysis cohorts (NGT and prediabetes at H1) + flowchart
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
pixi run Rscript scripts/0c_cohort_selection.R
```

Run the scripts from the project root.

## References

1. American Diabetes Association Professional Practice Committee. 2. Diagnosis and Classification of Diabetes: Standards of Care in Diabetes—2026. *Diabetes Care* 2026;49(Suppl. 1):S27–S49. doi:[10.2337/dc26-S002](https://doi.org/10.2337/dc26-S002)
2. Wu H, Gu Y, Wang X, et al. Association Between Handgrip Strength and Type 2 Diabetes: A Prospective Cohort Study and Systematic Review With Meta-analysis. *J Gerontol A Biol Sci Med Sci* 2023;78(8):1383–1391. doi:[10.1093/gerona/glac241](https://doi.org/10.1093/gerona/glac241)
3. Park D, Rho J, Kim E, et al. Comparison of Absolute and Relative Grip Strength to Predict Incidence of Diabetes Mellitus in Korea: A Prospective Cohort Study. *Metab Syndr Relat Disord* 2024;22(6):463–470. doi:[10.1089/met.2024.0006](https://doi.org/10.1089/met.2024.0006)
4. Kim GH, Song BK, Kim JW, et al. Associations between relative grip strength and type 2 diabetes mellitus: The Yangpyeong cohort of the Korean genome and epidemiology study. *PLoS One* 2021;16(8):e0256550. doi:[10.1371/journal.pone.0256550](https://doi.org/10.1371/journal.pone.0256550)
5. Jang BN, Nari F, Kim S, et al. Association between relative handgrip strength and prediabetes among South Korean adults. *PLoS One* 2020;15(10):e0240027. doi:[10.1371/journal.pone.0240027](https://doi.org/10.1371/journal.pone.0240027)
