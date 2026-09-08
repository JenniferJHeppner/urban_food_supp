# Limited food shapes urban phenotypes across life stages: Physiology and morphology of eggs, offspring, and adults

**Authors**: Jennifer J. Heppner, Elise Lingenfelter, Ivan C. Provinciato, Sahara C. Harrington, Jesse S. Krause, Jenny Q. Ouyang

## Abstract

Urbanization results in the emergence of unique organismal phenotypes; however, the specific ecological pressures driving these modifications remain relatively unknown. Urban environments often exhibit reduced insect abundance, limiting food resources and reducing fitness. To test the effects of food scarcity on traits across ontogenetic stages, we supplemented breeding house wrens (Troglodytes aedon) with live mealworms across an urbanization gradient characterized by varying prey abundance. We hypothesized that maternal hormone transfer may be one mechanism integrating environmental information, such as food availability, and altering offspring phenotypes. We quantified maternal hormone transfer of corticosterone, testosterone, and thyroxine by assessing egg yolk concentrations, determined plasma corticosterone concentrations in both nestlings and their parents, and measured morphology across ontogeny. Our findings revealed that while yolks from urban and rural sites compared to the natural site had higher corticosterone and testosterone and lower thyroxine concentrations, food supplementation reduced these steroid hormone levels, rendering them indistinguishable from natural phenotypes. Supplemental food also reversed the elevated corticosterone concentrations in urban and rural nestlings and their parents, and elevated urban masses across ontogenetic stages, improving the survival probabilities of nestlings. Ultimately, food supplementation eliminated phenotypic differences across sites, providing mechanistic support that limited food in urban environments is a strong ecological pressure that alters maternal hormone transfer, organismal physiological phenotypes, and reduces the fitness of urban birds. These results identify a specific aspect of the urban environment as a primary ecological challenge for insectivorous species, highlighting its importance for future conservation efforts.


## Repository Structure:
All R code and data within the repository can be found in the corresponding folders.

- `Data`: Contains all data used in the manuscript.
  - `Adult_Cort.csv`:


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
