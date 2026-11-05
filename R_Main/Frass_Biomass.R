### Analysis of Caterpillar Frass Biomass

# Load Packages ----
library(lubridate)
library(ggplot2)
library(emmeans)
library(lme4)
library(dplyr)
library(nlme)


# Load "Frass_20-22.csv" 
# Hereon, data file is named "dat"
dat <- read.csv("Data/Frass_20-22.csv")

# Clean data
dat$frassID <- as.factor(dat$frassID) # individual ID of the frass net (named after the nest box it was closest to)
dat$site <- as.factor(dat$site)  # codes for the 3 sites: "N" natural, "R" rural, "U" urban
dat$date <- as.Date(dat$date, "%m/%d/%y")  # modify the format of the date of the year
dat$julian <- yday(dat$date)  # create a new column for julian date
dat$year <- as.factor(dat$year)  # year data was collected
dat$mass_g <- as.numeric(dat$mass_g) # dried mass of frass
dat$biomass <- as.numeric(dat$biomass) # estimated caterpillar biomass with correctino of temperature

# Subset Data
dat <- subset(dat, Julian < 208)

# Rename groups
levels(dat$site)
levels(dat$site) <- c("Natural", "Rural", "Urban")


# Standardize Julian date to assist lme optimization
dat$Julian_sc <- scale(dat$Julian)

# Natural log-transform positive biomass (g/m²)
dat$log_biomass <- log(dat$biomass)


# Quick Visualize
ggplot(data = dat, aes(x = Julian, y = biomass, colour = site, fill = site)) +
  stat_summary(size = 1, linewidth = 1) +
  stat_summary(fun = mean, geom = "line", size = 1.5) +
  #geom_jitter() +
  scale_color_manual(values=c("#008176", "darkorange", "#999999")) +
  scale_y_continuous(name = 'Caterpillar Biomass (g/m\u00b2)') +
  scale_x_continuous(name = 'Julian Date') +
  theme_classic() +
  theme(legend.position = 'right',
        plot.title = element_text(size = 25, hjust = 0.5, colour="black",face = "bold"),
        axis.text = element_text(size = 20, face = "bold"),
        axis.title = element_text(size = 20, colour = "black", face = "bold"),
        legend.title = element_text(size = 16,
                                    colour="black",face = "bold",vjust = 1),
        legend.text = element_text(size=13)) +
  labs(color = "Site") 




#################################
# Linear Mixed-Effects Model of Caterpillar Biomass
# Models log-biomass with site-level heteroscedasticity (varIdent)
lme_linear <- lme(fixed = log_biomass ~ site * Julian_sc + year, random = ~ 1 | frassID, 
  weights = varIdent(form = ~ 1 | site), data = dat, method = "REML")

summary(lme_linear)


# Pearson/normalized residual plot to confirm homoscedasticity
plot(lme_linear, resid(., type = "pearson") ~ fitted(.),
     main = "Standardized Residuals vs Fitted Values",
     xlab = "Fitted Values (log scale)", 
     ylab = "Normalized Residuals")

# Residual Normality Check (Q-Q Plot)
qqnorm(lme_linear, ~ resid(., type = "normalized"), 
       abline = c(0, 1), 
       main = "Normal Q-Q Plot of Normalized Residuals")



#######
# Post Hoc test to compare weekly site differences
# Extract unique original Julian days from your dataset in ascending order
original_julian_days <- sort(unique(dat$Julian))

# Calculate standardized z-scores corresponding to your original Julian dates
mean_j <- mean(dat$Julian)
sd_j   <- sd(dat$Julian)
target_julian_sc <- (original_julian_days - mean_j) / sd_j

# Estimate Marginal Means at each original weekly date
weekly_means <- emmeans(
  lme_linear, 
  ~ site | Julian_sc, 
  at = list(Julian_sc = target_julian_sc),)

# Pairwise contrasts with Tukey adjustment
weekly_contrasts <- pairs(weekly_means, adjust = "tukey")

# Output as a data frame with back-transformed ratios
weekly_results <- as.data.frame(summary(weekly_contrasts)) %>%
   mutate(Julian_Day = round((Julian_sc * sd_j) + mean_j)) %>%  # Map standardized Julian z-scores back to exact original Julian Days
    mutate(ratio = round(exp(estimate), 3),  SE = round(SE, 3),
    p.value = ifelse(p.value < 0.001, "< 0.001", as.character(round(p.value, 4)))) %>% # Format p-values and round numerical estimates
  select(Julian_Day, contrast, ratio, estimate, SE, df, t.ratio, p.value)

print(weekly_results)



#################
# Final Figure Visualization 
# Includes horizontal bars at top indicating significant differences between urban and rural biomass compared to natural at 
#   weekly time points based on post hoc test.
# Includes horizontal bars at bottom indicating time ranges when "Egg Laying" and "Chick Rearing" occurred.
ggplot(data = dat, aes(x = Julian, y = biomass, colour = site, fill = site)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "black", linewidth = 0.5) +
  stat_summary(size = 1, linewidth = 1) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.5) +
  
  # --- STATISTICAL SIGNIFICANCE BARS (TOP) ---
  # Natural vs. Rural significant difference window (Days 123 to 179)
  annotate("segment", x = 123, xend = 172, y = 24.3, yend = 24.3, 
           colour = "darkorange", linewidth = 1) +
  annotate("text", x = 150, y = 25, label = "* Rural vs. Natural (p < 0.05)", 
           colour = "black", fontface = "bold", size = 4) +
  
  # Natural vs. Urban significant difference window (Days 123 to 214)
  annotate("segment", x = 123, xend = 207, y = 25.9, yend = 25.9, 
           colour = "#999999", linewidth = 1) +
  annotate("text", x = 168.5, y = 26.6, label = "* Urban vs. Natural (p < 0.05)", 
           colour = "black", fontface = "bold", size = 4) +
  
  # --- PHENOLOGY SEGMENTS (BOTTOM) ---
  # Egg Laying Segment
  annotate("segment", x = 125, xend = 171, y = -1.8, yend = -1.8, 
           colour = "#008176", linewidth = 1) + 
  annotate("segment", x = 127, xend = 178, y = -2.15, yend = -2.15, 
           colour = "darkorange", linewidth = 1) + 
  annotate("segment", x = 131, xend = 179, y = -2.5, yend = -2.5, 
           colour = "#999999", linewidth = 1) + 
  annotate("text", x = 148, y = -1, label = "Egg Laying", 
           colour = "black", fontface = "bold", size = 4.5) +
  
  # Chick Rearing Segment
  annotate("segment", x = 145, xend = 193, y = -4.3, yend = -4.3, 
           colour = "#008176", linewidth = 1) +
  annotate("segment", x = 151, xend = 202, y = -4.65, yend = -4.65, 
           colour = "darkorange", linewidth = 1) +
  annotate("segment", x = 153, xend = 205, y = -5, yend = -5, 
           colour = "#999999", linewidth = 1) +
  annotate("text", x = 173, y = -3.5, label = "Chick Rearing", 
           colour = "black", fontface = "bold", size = 4.5) +
  
  # --- STYLING & AXES ---
  scale_color_manual(values = c("#008176", "darkorange", "#999999")) +
  scale_y_continuous(name = 'Caterpillar Biomass (g/m\u00b2)', 
                     breaks = seq(0, 25, by = 5)) + 
  scale_x_continuous(name = 'Julian Date') +
  coord_cartesian(ylim = c(-4, 25.6)) + 
  theme_classic() +
  theme(plot.title = element_text(size = 25, hjust = 0.5, colour = "black", face = "bold"),
        axis.text = element_text(size = 20, face = "bold"),
        axis.title = element_text(size = 20, colour = "black", face = "bold"),
        legend.position = "none")
