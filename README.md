# Gut-muscle axis and new-onset prediabetes in the HELIUS cohort

Analysis code for HELIUS publication proposal #251111.

**Authors:** Anna Giannakogeorgou, Barbara J. H. Verhaar, Mary Nicolaou, Henrike Galenkamp, Bert-Jan van den Born, Max Nieuwdorp
**Institution:** Amsterdam UMC, Department of Vascular Medicine

## Research questions
1. Does baseline gut microbiota composition and functional potential (HELIUS-1) differ between normoglycaemic participants with vs. without new-onset prediabetes at follow-up (HELIUS-2)?
2. Are these associations mediated by anthropometric / muscle-related factors (FFMI, handgrip strength, BMI, WHR)?
3. Which baseline plasma metabolites explain the associations between gut microbiota, muscle and new-onset prediabetes?
4. Do microbiota–prediabetes associations differ across ethnic groups?
5. *Exploratory:* among incident cases, do microbiota profiles differ by weight change over follow-up?

**Outcome:** prediabetes per ADA criteria — fasting plasma glucose 5.6–6.9 mmol/L or HbA1c 5.7–6.4% (39–47 mmol/mol).

## Repository structure
```
data/raw_data/        HELIUS data as received (never committed)
data/processed_data/  Derived analysis datasets (never committed)
R/                    Reusable functions
scripts/              Numbered analysis scripts, run in order
results/              Tables and figures (not committed by default)
docs/                 Analysis plan, notes
```

## Scripts
| Script | Purpose |
|---|---|
| `01_cohort_selection.R` | Eligibility, exclusions, flowchart counts by ethnicity |

## Data
HELIUS data are available only under a signed HELIUS Data Transfer Agreement. **No participant-level data are stored in this repository.** Contact: HELIUScoordinator@amsterdamumc.nl
