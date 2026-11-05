# Limited food shapes urban phenotypes across life stages

**Authors**: 

## Summary

Urbanization results in the emergence of unique organismal phenotypes; however, ecological pressures driving these modifications remain unclear. To test whether food scarcity shapes avian traits across life stages, we supplemented northern house wrens (Troglodytes aedon) with live mealworms across an urbanization gradient. We examined maternal hormone transfer (corticosterone, testosterone, and thyroxine), plasma corticosterone in parents and nestlings, and morphology. Individuals in more urbanized habitats showed altered yolk, nestling, and adult hormone concentrations as well as reduced masses. However, food supplementation reduced elevated steroid concentrations in yolks, decreased plasma corticosterone in nestlings and adults, and improved masses across ontogeny, effectively eliminating phenotypic differences across sites. These findings demonstrate that reduced insect availability in anthropogenically disturbed habitats is a primary driver altering avian maternal hormone transfer, physiological phenotypes, and condition. By isolating food scarcity from the complex suite of urban challenges, this work establishes arthropod conservation as essential for urban wildlife management.



## Repository Structure:
All R code and data within the repository can be found in the corresponding folders.

- `Data`: Contains all data used in the manuscript.
  - `Adult_Cort.csv`: Individual-level data on adult house wren baseline corticosterone concentrations. Contains columns for individual sample ID, nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), biological sex, individual band ID, date, year, time of day, nest brood size, total time to complete blood sample (in seconds), mass, and corticosterone concentration in ng.
 
  - `Adult_Morphology.csv`: Individual-level data on adult house wren morphology. Contains columns for nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), biological sex, individual band ID, year, date, time of day, nest brood size, tarsus length, wing length, mass.
 
  - `Egg_Morphology.csv`: Individual-level data on house wren egg morphology. Contains columns for nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), egg-laying order, whether the egg was removed from the nest for hormone extraction or left to develop naturally, year, date, nest clutch size, date food tray was installed, `supp_days` (current number of days that specific egg received food supplementation), `num_supp_day` (total number of days the entire clutch of eggs received food supplementation up to the 1st egg laid), time of day, length of egg, width of egg, and mass.
 
  - `Frass_20-22.csv`: Repeated caterpillar frass measurements across sites and the entire breeding season. Contains columns for frass net ID,  site (U - urban, R - rural, N - natural), date, year, dry frass mass (in grams), dry frass mass (in mg), Julian date, ambient temperature, and biomass.
 
  - `Nestling_Cort.csv`: Individual-level data on nestling house wren baseline corticosterone concentrations at fledging. Contains columns for individual sample ID, nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), individual band ID, date, year, time of day, nest brood size, total time to complete blood sample (in seconds), hormone enzyme immunoassay plate ID, corticosterone concentration, and mass.
 
  - `Nestling_Morphology.csv`: Individual-level data on nestling house wren morphology at fledging. Contains columns for nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), individual band ID, year, date, time of day, nest brood size, mass, tarsus, and wing length.
 
  - `Nestling_Plasma_Validation.csv`: Concentrations and % Bound values of the corticosterone enzyme immunoassay kit Standard Curve and house wren nestling plasma corticosterone serial dilution for validation.
 
  - `Yolk_Validation.csv`: Concentrations and % Bound values of the corticosterone, testosterone, and thyroxine (T4) enzyme immunoassay kit Standard Curves and house wren serial-spiked yolks for validation. Contains columns for curve type, the number within the Standard or Spiked Yolk Curves, corticosterone concentration, corticosterone % Bound, testosterone concentration, testosterone % Bound, thyroxine (T4) concentration, and thyroxine (T4) % Bound.
 
  - `nest_info.csv`: Nest level information. Contains columns for nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), year, clutch size, hatch brood size, fledge brood size, date of first egg laid, date of first chick hatch, date of fledging, date the food supplementation tray was installed, total number of days the nest was given food supplementation up to the first egg laid, and notes.
  
  - `yolk_hormones.csv`: Individual-level data on house wren egg yolk hormone levels. Contains columns for sample ID, nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), egg-laying order, year, date, time of day, hormone enzyme immunoassay plate ID, thyroxine-specific plate ID, nest clutch size, egg mass, yolk mass, cort_ng/g_yolk (corticosterone concentration normalized per gram of yolk mass), cort_ng/mL (corticosterone reconstituted concentration), test_ng/g_yolk (testosterone concentration normalized per gram of yolk mass), test_ng/mL (testosterone reconstituted concentration), and t4_ng/g_yolk (thyroxine (T4) concentration normalized per gram of yolk mass), t4_ng/mL (thyroxine (T4) reconstituted concentration).
  
  - `yolk_hormone_calculations.xlsx`: Individual yolk level complete calculation workflow used to transform raw enzyme immunoassay (EIA) readouts (pg/mL) into both final mass-normalized yolk concentrations (ng/g wet yolk; Step 6) and reconstituted extract concentrations (ng/mL; Step 3) following protocol in Supplementary Materials. Contains columns for sample ID, nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), egg-laying order, year, date, time of day, hormone enzyme immunoassay plate ID, thyroxine-specific plate ID, nest clutch size, egg mass, yolk mass, total supernatant volume, extraction dilution factor, cort_pg/mL (raw hormone concentration directly from standard curves), cort_dilution_factor (dilution-adjusted concentration pg/mL), cort_ng/mL (converted concentration to ng/mL), cort_ng_tube (total hormone mass in reconsitution tube), cort_tot_ng (scaled hormone mass to total supernatant volume), cort_ng/g_yolk (yolk mass normalized concentration, test_pg/mL, test_dilution_factor, test_ng/mL, test_ng_tube, test_tot_ng, test_ng/g_yolk, t4_pg/mL, t4_dilution_factor, t4_ng/mL, t4_ng_tube, t4_tot_ng, and t4_ng/g_yolk.



- `Figures`: Contains all R code to replicate figures in the manuscript.
  
  - `Main_Manuscript_Figures.R`: Script to reproduce Figures 1 and 2 found in the main text using: `yolk_hormones.csv`, `Nestling_Cort.csv`, `Adult_Cort.csv`, `Frass_20-22.csv`, `Egg_Morphology.csv`, `Nestling_Morphology.csv`, and `Adult_Morphology.csv`.
    
  - `Supplementary_Figures.R`: Script to reproduce figures found in the Supplementary Materials using: `Yolk_Validations.csv`, `Nestling_Plasma_Validations.csv`, `yolk_hormones.csv`, and `Egg_Morphology.csv`.


- `R_Main`: Contains all R scripts of main analyses in the manuscript:
  
  - `Adult_Cort.R`: Uses `Adult_Cort.csv` to analyse adult corticosterone data.
    
  - `Adult_Morphology.R`: Uses `Adult_Morphology.csv` to analyze adult morphology metrics, including mass and body condition.
    
  - `Egg_Morphology.R`: Uses `Egg_Morphology.csv` to analyze egg morphology metrics, including mass and volume.
    
  - `Frass_Biomass.R`: Uses `Frass_20-22.csv` to analyze caterpillar frass biomass.
    
  - `Nestling_Cort.R`: Uses `Nestling_Cort.csv` to analyze nestling corticosterone data.
    
  - `Nestling_Morphology.R`: Uses `Nestling_Morphology.csv` to analyze nestling morphology metrics, including mass and body condition.
    
  - `Yolk_Hormones_and_Mass.R`: Uses `yolk_hormones.csv` to analyze yolk hormone levels normalized per gram of yolk mass (ng/g_yolk - corticosterone, testosterone, and thyroxine) as well as morphology (mass).
  



- `R_Supp`: Contains R scripts for supplementary analyses.
  
  - `Nesting_Success.R`: Uses `nest_info.csv` to analyze clutch size, hatching brood size, and fledging brood size.
 
  - `Cort_Time.R`: Uses `Adult_Cort.csv` and `Nestling_Cort.csv` to analyze the effect of time of day and handling time (bleed time) on adult and nestling corticosterone.
    
  - `Yolk_Hormones_Reconstituted_Dilution_Conc.R`: Uses `yolk_hormones.csv` to analyze yolk hormone reconstituted concentration (ng/mL - corticosterone, testosterone, and thyroxine).
