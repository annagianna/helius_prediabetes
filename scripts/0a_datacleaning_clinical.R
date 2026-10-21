# HELIUS Prediabetes
# Anna Giannakogeorgou, a.gianna@amsterdamumc.nl
# Data cleaning - clinical data & metabolomics

# Libraries
library(tidyverse)
library(haven)

# Data
helius_df <- haven::read_sav("data/raw_data/clinical_data/251111_HELIUS data Anna Giannakogeorgou.sav")

# Data cleaning
## Clinical data ##
helius_clean_df <- helius_df |> 
  select(
    id = ID,
    date_h1 = H1_DatumLO, date_h2 = H2_DatumLO,
    fu_done_h2 = H2_LichamelijkOnderzoekJN, fu_time_months_h2 = H2_fu_time,
    sex = H1_geslacht,
    age_h1 = H1_lft, age_h2 = H2_lft,
    migr_gen_h1 = H1_MigrGeneratie, ethnicity_h1 = H1_etniciteit,
    smoking_h1 = H1_Roken, packyears_h1 = H1_PackYears, smoking_h2 = H2_Roken_H1combined,
    alcohol_yn_h1 = H1_AlcoholJN, alcohol_cat_h1 = H1_AlcoholConsumption,
    alcohol_yn_h2 = H2_AlcoholJN, alcohol_cat_h2 = H2_AlcoholConsumption,
    abx_h1 = H1_Feces_q2,
    dm_self_h1 = H1_Diabetes_Self, dm_self_h2 = H2_DM_Self_H1combined,
    dm_fpg_ada_h1 = H1_Diabetes_Gluc, dm_self_fpg_h1 = H1_Diabetes_SelfGluc, dm_fpg_meds_h1 = H1_Diabetes_GlucMed, dm_self_fpg_meds_h1 = H1_Diabetes_SelfGlucMed,
    dm_fpg_ada_h2 = H2_DM_Gluc, dm_self_fpg_h2 = H2_DM_SelfGluc_H1combined, dm_fpg_meds_h2 = H2_DM_GlucMed, dm_self_fpg_meds_h2 = H2_DM_SelfGlucMed_H1combined,
    weight_kg_h1 = H1_LO_GemGewicht, weight_kg_h2 = H2_LO_GemGewicht, height = H1_LO_GemLengte,
    bmi_h1 = H1_LO_BMI, bmi_h2 = H2_LO_BMI,
    wc_cm_h1 = H1_LO_GemMiddel, wc_cm_h2 = H2_LO_GemMiddel, hc_cm_h1 = H1_LO_GemHeup, hc_cm_h2 = H2_LO_GemHeup, 
    whr_h1 = H1_LO_WHR, whr_h2 = H2_LO_WHR,
    thigh_cm_h1 = H1_LO_GemDij, arm_cm_h1 = H1_LO_GemArm,
    calf_cm_h1 = H1_LO_GemKuit,
    fm_perc_h1 = H1_BIA_FatPercent, 
    handgrip_mean_h1 = H1_LO_KnijpKrachtGemiddeld, handgrip_max_h1 = H1_LO_KnijpKrachtMax,
    sys_bp_h1 = H1_LO_GemBPSysZit, dia_bp_h1 = H1_LO_GemBPDiaZit, sys_bp_h2 = H2_LO_GemBPSysZit, dia_bp_h2 = H2_LO_GemBPDiaZit,
    hr_h1 = H1_LO_GemBPHRZit, hr_h2 = H2_LO_GemBPHRZit, 

    ## Labs
    glu_mmoll_h1 = H1_Lab_UitslagGLUC, hba1c_mmolmol_h1 = H1_Lab_UitslagIH1C, hb_mmoll_h1 = H1_Lab_UitslagHEMO, trig_mmoll_h1 = H1_Lab_UitslagTRIG, tchol_mmoll_h1 = H1_Lab_UitslagCHOL,   
    hdl_mmoll_h1 = H1_Lab_UitslagHDLS, ldl_mmoll_h1 = H1_Lab_uitslagRLDL, kreatinine_umoll_h1 = H1_Lab_UitslagKREA_HP, cpk_ul_h1 = H1_Lab_UitslagCPK, microalbumin_mgl_h1 = H1_Lab_UitslagMIAL,  
    glu_mmoll_h2 = H2_Lab_UitslagGLUC, hba1c_mmolmol_h2 = H2_Lab_UitslagIH1C, hb_mmoll_h2 = H2_Lab_UitslagHEMO, trig_mmoll_h2 = H2_Lab_UitslagTRIG, tchol_mmoll_h2 = H2_Lab_UitslagCHOL,   
    microalbumin_mgl_h2 = H2_Lab_UitslagMIAL,  
    
    ## Medication
    # Glucose-lowering
    glucose_lowering_meds_h1 = H1_Diabetesmiddelen, glucose_lowering_meds_h2 = H2_Diabetesmiddelen,

    # Corticosteroids
    corticosteroids_h1 = H1_Corticosteroiden, corticosteroids_h2 = H2_Corticosteroiden,
    syst_steroids_h1 = H1_SystSteroiden, syst_steroids_h2 = H2_SystSteroiden,

    # Respiratory / allergy meds
    asthma_copd_h1 = H1_AstmCOPD, asthma_copd_h2 = H2_AstmCOPD,
    antihistamines_h1 = H1_Antihistaminica, antihistamines_h2 = H2_Antihistaminica,

    # Psychotropic meds
    antipsychotics_h1 = H1_Antipsychotica, antipsychotics_h2 = H2_Antipsychotica,
    antidepressants_h1 = H1_Antidepressiva, antidepressants_h2 = H2_Antidepressiva,
    tca_h1 = H1_TCA, tca_h2 = H2_TCA, stimulants_h1 = H1_Stimulantia, stimulants_h2 = H2_Stimulantia,
    
    ## Dietary data
    energy_kj_h1 = ENkj_Sum, energy_kcal_h1 = ENKcal_Sum, total_cho_g_h1 = Carbo_Sum, fiber_g_h1 = Fibre_Sum,
    total_protein_g_h1 = Prot_Sum, animal_protein_g_h1 = Prot_ani_Sum, veg_protein_g_h1 = Prot_veg_Sum,
    fatty_acids_g_h1 = FattyAcidsTot_Sum
  ) |> 
  mutate(
    # Body composition (H1 only)
    fm_kg_h1 = weight_kg_h1 * fm_perc_h1 / 100,
    ffm_kg_h1 = weight_kg_h1 - fm_kg_h1,
    ffm_perc_h1 = 100 - fm_perc_h1,
    ffmi_h1 = ffm_kg_h1 / (height / 100)^2,
    fmi_h1 = fm_kg_h1 / (height / 100)^2,

    # Glycaemic criteria per test (ADA SoC 2026) - H1
    dm_fpg_h1 = if_else(glu_mmoll_h1 >= 7.0, "yes", "no"),
    dm_hba1c_h1 = if_else(hba1c_mmolmol_h1 >= 48, "yes", "no"),
    predm_fpg_h1 = if_else(glu_mmoll_h1 >= 5.6 & glu_mmoll_h1 < 7.0, "yes", "no"),
    predm_hba1c_h1 = if_else(hba1c_mmolmol_h1 >= 39 & hba1c_mmolmol_h1 < 48, "yes", "no"),
    # H2
    dm_fpg_h2 = if_else(glu_mmoll_h2 >= 7.0, "yes", "no"),
    dm_hba1c_h2 = if_else(hba1c_mmolmol_h2 >= 48, "yes", "no"),
    predm_fpg_h2 = if_else(glu_mmoll_h2 >= 5.6 & glu_mmoll_h2 < 7.0, "yes", "no"),
    predm_hba1c_h2 = if_else(hba1c_mmolmol_h2 >= 39 & hba1c_mmolmol_h2 < 48, "yes", "no"),

    ## Glycaemic status
    # T2D: FPG >= 7.0 or glucose-lowering meds or HbA1c >= 48; self-report alone not used
    # an abnormal value on whichever test is available is enough to classify
    # NGT requires both FPG and HbA1c available and normal (NA otherwise)
    glyc_status_h1 = case_when(
      dm_fpg_meds_h1 == 1 | dm_fpg_h1 == "yes" | dm_hba1c_h1 == "yes" ~ "T2D",
      predm_fpg_h1 == "yes" | predm_hba1c_h1 == "yes" ~ "PreDM",
      predm_fpg_h1 == "no" & predm_hba1c_h1 == "no" ~ "NGT",
      TRUE ~ NA_character_
    ),
    glyc_status_h2 = case_when(
      dm_fpg_meds_h2 == 1 | dm_fpg_h2 == "yes" | dm_hba1c_h2 == "yes" ~ "T2D",
      predm_fpg_h2 == "yes" | predm_hba1c_h2 == "yes" ~ "PreDM",
      predm_fpg_h2 == "no" & predm_hba1c_h2 == "no" ~ "NGT",
      TRUE ~ NA_character_
    ),
    across(c(glyc_status_h1, glyc_status_h2), ~ factor(.x, levels = c("NGT", "PreDM", "T2D"), ordered = TRUE))
  ) |> 
  mutate(
    across(c(age_h1, age_h2, packyears_h1, fu_time_months_h2,
             weight_kg_h1:hr_h2, glu_mmoll_h1:microalbumin_mgl_h2,
             energy_kj_h1:fatty_acids_g_h1), as.numeric),
    across(where(haven::is.labelled), ~ haven::as_factor(.x, levels = "labels")),
    across(where(is.factor), ~ fct_relabel(.x, \(lvl) if_else(lvl %in% c("Yes", "No"), tolower(lvl), lvl)))
  )

## Analysis cohort & counts (for flowchart)
# Step 0: all participants with H1 & H2 data (already filtered in the data received)
n0 <- nrow(helius_clean_df)

# Step 1: with baseline microbiome data -> add once phyloseq is merged (0b)
# cohort1 <- helius_clean_df |> 
#   filter(id %in% sample_names(phyloseq_object))

# Step 2: exclude antibiotic use in past 3 months (missing kept)
cohort2 <- helius_clean_df |> 
  filter(is.na(abx_h1) | abx_h1 != "yes")
n2 <- nrow(cohort2)

# Step 3: exclude diabetes at H1 (FPG >= 7.0, glucose-lowering meds or HbA1c >= 48)
# NA status kept: no evidence of diabetes on any criterion -> dropped at step 4 instead
cohort3 <- cohort2 |> 
  filter(is.na(glyc_status_h1) | glyc_status_h1 != "T2D")
n3 <- nrow(cohort3)

# Step 4: NGT at H1 only (excludes prediabetes and incomplete FPG/HbA1c)
cohort4 <- cohort3 |> 
  filter(glyc_status_h1 == "NGT")
n4 <- nrow(cohort4)

# Step 5: exclude unclassifiable glycaemic status at H2
final_analysis_cohort <- cohort4 |> 
  filter(!is.na(glyc_status_h2))
n5 <- nrow(final_analysis_cohort)

flowchart <- tibble(
  step = c("H1 & H2 data", "No antibiotics", "No diabetes H1", "Normoglycaemia H1", "Glycaemic status available H2"),
  n_remaining = c(n0, n2, n3, n4, n5)
) |> 
  mutate(n_excluded = lag(n_remaining) - n_remaining)

## Checks
flowchart
cohort3 |> count(glyc_status_h1)                                         # step 4 exclusions: PreDM vs incomplete
final_analysis_cohort |> count(glyc_status_h2)                           # incidence (primary outcome)
cohort3 |> filter(glyc_status_h1 == "PreDM") |> count(glyc_status_h2)    # baseline prediabetes -> H2

## Metabolomics ##
helius_metab <- helius_df |> 
  select(id = ID, starts_with("H1_Met_plasma")) |> 
  filter(if_any(-id, ~ !is.na(.x)))

# Save
saveRDS(helius_clean_df, "data/processed_data/helius_clinical.RDS")
saveRDS(final_analysis_cohort, "data/processed_data/helius_cohort.RDS")
saveRDS(helius_metab, "data/processed_data/helius_metabolomics.RDS")