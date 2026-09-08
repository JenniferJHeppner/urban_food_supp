# Limited food shapes urban phenotypes across life stages: Physiology and morphology of eggs, offspring, and adults

**Authors**: Jennifer J. Heppner, Elise Lingenfelter, Ivan C. Provinciato, Sahara C. Harrington, Jesse S. Krause, Jenny Q. Ouyang

## Abstract

Urbanization results in the emergence of unique organismal phenotypes; however, the specific ecological pressures driving these modifications remain relatively unknown. Urban environments often exhibit reduced insect abundance, limiting food resources and reducing fitness. To test the effects of food scarcity on traits across ontogenetic stages, we supplemented breeding house wrens (Troglodytes aedon) with live mealworms across an urbanization gradient characterized by varying prey abundance. We hypothesized that maternal hormone transfer may be one mechanism integrating environmental information, such as food availability, and altering offspring phenotypes. We quantified maternal hormone transfer of corticosterone, testosterone, and thyroxine by assessing egg yolk concentrations, determined plasma corticosterone concentrations in both nestlings and their parents, and measured morphology across ontogeny. Our findings revealed that while yolks from urban and rural sites compared to the natural site had higher corticosterone and testosterone and lower thyroxine concentrations, food supplementation reduced these steroid hormone levels, rendering them indistinguishable from natural phenotypes. Supplemental food also reversed the elevated corticosterone concentrations in urban and rural nestlings and their parents, and elevated urban masses across ontogenetic stages, improving the survival probabilities of nestlings. Ultimately, food supplementation eliminated phenotypic differences across sites, providing mechanistic support that limited food in urban environments is a strong ecological pressure that alters maternal hormone transfer, organismal physiological phenotypes, and reduces the fitness of urban birds. These results identify a specific aspect of the urban environment as a primary ecological challenge for insectivorous species, highlighting its importance for future conservation efforts.


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
 
  - `Yolk_Hormones.csv`: Individual-level data on house wren egg yolk hormone levels. Contains columns for sample ID, nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), egg-laying order, year, date, time of day, hormone enzyme immunoassay plate ID, thyroxine-specific plate ID, nest clutch size, egg mass, yolk mass, corticosterone concentration, testosterone concentration, and thyroxine (T4) concentration.
 
  - `Yolk_Validation.csv`: Concentrations and % Bound values of the corticosterone, testosterone, and thyroxine (T4) enzyme immunoassay kit Standard Curves and house wren serial-spiked yolks for validation. Contains columns for curve type, the number within the Standard or Spiked Yolk Curves, corticosterone concentration, corticosterone % Bound, testosterone concentration, testosterone % Bound, thyroxine (T4) concentration, and thyroxine (T4) % Bound.
 
  - `nest_info.csv`: Nest level information. Contains columns for nest ID, site (U - urban, R - rural, N - natural), food treatment (C - control, T - food treated), year, clutch size, hatch brood size, fledge brood size, date of first egg laid, date of first chick hatch, date of fledging, date the food supplementation tray was installed, total number of days the nest was given food supplementation up to the first egg laid, and notes. 


- `Figures`: Contains all R code to replicate figures in the manuscript.
  
  - `Main_Manuscript_Figures.R`: Script to reproduce Figures 1 and 2 found in the main text using: `yolk_hormones.csv`, `Nestling_Cort.csv`, `Adult_Cort.csv`, `Frass_20-22.csv`, `Egg_Morphology.csv`, `Nestling_Morphology.csv`, and `Adult_Morphology.csv`.
    
  - `Supplementary_Figures.R`: Script to reproduce figures found in the Supplementary Materials using: `Yolk_Validations.csv`, `Nestling_Plasma_Validations.csv`, `yolk_hormones.csv`, and `Egg_Morphology.csv`.


- `R_Main`: Contains all R scripts of main analyses in the manuscript:
  
  - `Adult_Cort.R`: Uses `Adult_Cort.csv` to analyse adult corticosterone data.
    
  - `Adult_Morphology.R`: Uses `Adult_Morphology.csv` to analyze adult morphology metrics, including mass and body condition.
    
  - `Egg_Morphology.R`: Uses `Egg_Morphology.csv` to analyze egg morphology metrics, including mass and volume.
    
  - `Nestling_Cort.R`: Uses `Nestling_Cort.csv` to analyze nestling corticosterone data.
    
  - `Nestling_Morphology.R`: Uses `Nestling_Morphology.csv` to analyze nestling morphology metrics, including mass and body condition.
    
  - `Yolk_Hormones_and_Mass.R`: Uses `yolk_hormones.csv` to analyze yolk hormone levels (corticosterone, testosterone, and thyroxine) as well as morphology (mass).
  



- `R_Supp`: Contains R scripts for supplementary analyses.
  
  - `Frass_Biomass.R`: Uses `Frass_20-22.csv` to analyze caterpillar frass biomass.
    
  - `Nesting_Success.R`: Uses `nest_info.csv` to analyze clutch size, hatching brood size, and fledging brood size.
