### Supplemental Analysis of Yolk Hormones 
### Reconsituted Concentrations
# Yolk Corticosterone, Yolk Testosterone, and Yolk Thyroxine

# Load Packages ----
library(ggplot2)
library(lme4)
library(lmerTest)
library(car)
library(lubridate)
library(car)
library(emmeans)
library(wesanderson)

# Load "Yolk_Hormones.csv" 
# Hereon, data file is named "dat"
dat <- read.csv("Data/Yolk_Hormones.csv")

# Clean data
dat$nest <- as.factor(dat$nest) # unique nest ID
dat$site <- as.factor(dat$site) # codes for the 3 sites: "N" natural, "R" rural, "U" urban
dat$trt <- as.factor(dat$trt) # code for treatment groups: "C" control, "T" food supplemented
dat$layorder <- as.numeric(dat$layorder) # order number an egg was laid in, 1-6
dat$year <- as.factor(dat$year) # year egg was laid and collected
dat$date <- as.Date(dat$date, "%m/%d/%y") # modify the format of the date of the year
dat$julian <- yday(dat$date) # create a new column for julian date
dat$plate <- as.factor(dat$plate) # the EIA plate the sample was on for corticosterone and Testosterone
dat$plate_T4 <- as.factor(dat$plate_T4) # the EIA plate the sample was on for Thyroxine
dat$yolk <- as.numeric(dat$yolk) # wet yolk mass measured
dat$clutch_size <- as.integer(dat$clutch_size) # number of eggs in the entire clutch
dat$cort_dilution <- as.numeric(dat$cort_ng.mL) # Dilution-Corrected Corticosterone Concentration
dat$test_dilution <- as.numeric(dat$test_ng.mL) # Dilution-Corrected Testosterone Concentration
dat$t4_dilution <- as.numeric(dat$t4_ng.mL) # Dilution-Corrected Thyroxine Concentration


# Rename groups
levels(dat$site)
levels(dat$site) <- c("Natural", "Rural", "Urban")
levels(dat$trt)
levels(dat$trt) <- c("Control", "Food")




################################################################################
## Dilution-Corrected Corticosterone Concentration
## ng / mL

pal1 <- c("indianred4", "salmon")

# Visualize
# Dilution-Corrected Corticosterone Concentration across sites and treatment groups
ggplot(data = dat, aes(x = site, y = cort_dilution, group = trt, shape = trt)) +
  geom_jitter(aes(colour = trt, shape = trt), size = 4, alpha = 0.6, position = position_jitterdodge(dodge.width = 0.9)) +
  stat_summary(fun = mean, geom = "point", size = 6, position = position_dodge(width = 0.9),
               color = "black", alpha = 0.9) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.1, linewidth = 1,
               color = "black", alpha = 0.9, position = position_dodge(width = 0.9)) +
  scale_y_continuous(name = 'Dilution-Corrected Corticosterone (ng/mL)', breaks = c(0.5,1,1.5)) +
  scale_x_discrete(name = 'Site') +
  labs(color = "Treatment") +
  scale_color_manual(values = pal1) +
  theme_classic() +
  theme(
    axis.text = element_text(size = 15, face = "bold"),
    axis.title = element_text(size = 17, colour = "black", face = "bold"),
    legend.title = element_text(size = 18,
                                colour="black",face = "bold",vjust = 1),
    legend.text = element_text(size=13))

# Basic plot of Dilution-Corrected Corticosterone Concentration across laying sequence
ggplot(dat, aes(x = layorder, y = cort_dilution, color = trt, group = trt)) +
  geom_point(aes(color=trt), position = position_jitterdodge(dodge.width = 0.5)) +
  geom_smooth(method = "lm", aes(colour = trt)) +
  facet_wrap(~site)+
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9)) +
  theme_classic()


#################################
# Generalized Linear Mixed Effect Model of Dilution-Corrected Corticosterone Concentration
cort_dilution_model <- glmer(cort_dilution ~ site * trt + scale(layorder) + scale(clutch_size) + scale(julian) + year + 
                               (1|nest), family = Gamma(link = "log"), data = dat)
summary(cort_dilution_model)
AIC(cort_dilution_model)

# Post Hoc Tests
post_hoc_dilution_cort <- emmeans(cort_dilution_model, list(pairwise ~ site * trt))
pairs(post_hoc_dilution_cort, simple = "each")
plot(post_hoc_dilution_cort)



################################################################################
## Dilution-Corrected Testosterone Concentration
## ng / mL

pal2 <- wes_palettes$Cavalcanti1

# Visualize
# Dilution-Corrected Testosterone Concentration across sites and treatment groups
ggplot(data = dat, aes(x = site, y = test_dilution, group = trt, shape = trt)) +
  geom_jitter(aes(colour = trt, shape = trt), size = 4, alpha = 0.6, position = position_jitterdodge(dodge.width = 0.9)) +
  stat_summary(fun = mean, geom = "point", size = 6, position = position_dodge(width = 0.9),
               color = "black", alpha = 0.9) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.1, linewidth = 1,
               color = "black", alpha = 0.9, position = position_dodge(width = 0.9)) +
  scale_y_continuous(name = 'Dilution-Corrected Testosterone (ng/mL)', breaks = c(2,4,6,8,10,12,14,16)) +
  scale_x_discrete(name = 'Site') +
  labs(color = "Treatment") +
  scale_color_manual(values = pal2[2:3]) +
  theme_classic() +
  theme(
    axis.text = element_text(size = 15, face = "bold"),
    axis.title = element_text(size = 17, colour = "black", face = "bold"),
    legend.title = element_text(size = 18,
                                colour="black",face = "bold",vjust = 1),
    legend.text = element_text(size=13),
    legend.position = "none")

# Basic plot of Dilution-Corrected Testosterone Concentration across laying sequence
ggplot(dat, aes(x = layorder, y = test_dilution, color = trt, group = trt)) +
  geom_point(aes(color=trt), position = position_jitterdodge(dodge.width = 0.5)) +
  geom_smooth(method = "lm", aes(colour = trt)) +
  facet_wrap(~site)+
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9)) +
  theme_classic()


#################################
# Generalized Linear Mixed Effect Model of Dilution-Corrected Testosterone Concentration
test_dilution_model <- glmer(test_dilution ~ site * trt + scale(layorder) + scale(clutch_size) + scale(julian) + year + 
                               (1|nest), family = Gamma(link = "log"), data = dat)
summary(test_dilution_model)
AIC(test_dilution_model)

# Post Hoc Tests
post_hoc_dilution_test <- emmeans(test_dilution_model, list(pairwise ~ site * trt))
pairs(post_hoc_dilution_test, simple = "each")
plot(post_hoc_dilution_test)






################################################################################
## Dilution-Corrected Thyroxine Concentration
## ng / mL

pal3 <- c("steelblue", "lightsteelblue")

# Visualize
# Dilution-Corrected Thyroxine Concentration across sites and treatment groups
ggplot(data = dat, aes(x = site, y = t4_dilution, group = trt, shape = trt)) +
  geom_jitter(aes(colour = trt, shape = trt), size = 4, alpha = 0.7, position = position_jitterdodge(dodge.width = 0.9)) +
  stat_summary(fun = mean, geom = "point", size = 6, position = position_dodge(width = 0.9),
               color = "black", alpha = 0.9) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.1, linewidth = 1,
               color = "black", alpha = 0.9, position = position_dodge(width = 0.9)) +
  scale_y_continuous(name = 'Dilution-Corrected Thyroxine (ng/mL)', breaks = c(0,1,2,3,4,5,6,7,8,9)) +
  scale_x_discrete(name = 'Site') +
  labs(color = "Treatment") +
  scale_color_manual(values = pal3) +
  theme_classic() +
  theme(
    axis.text = element_text(size = 15, face = "bold"),
    axis.title = element_text(size = 17, colour = "black", face = "bold"),
    legend.title = element_text(size = 18,
                                colour="black",face = "bold",vjust = 1),
    legend.text = element_text(size=13),
    legend.position = "none")

# Basic plot of Dilution-Corrected Thyroxine Concentration across laying sequence
ggplot(dat, aes(x = layorder, y = t4_dilution, color = trt, group = trt)) +
  geom_point(aes(color=trt), position = position_jitterdodge(dodge.width = 0.5)) +
  geom_smooth(method = "lm", aes(colour = trt)) +
  facet_wrap(~site)+
  scale_y_continuous(breaks = c(0,1,2,3,4,5,6,7)) +
  theme_classic()


#################################
# Generalized Linear Mixed Effect Model of Dilution-Corrected Thyroxine Concentration
t4_dilution_model <- glmer(t4_dilution ~ site * trt + scale(layorder) + scale(clutch_size) + scale(julian) + year + 
                             (1|nest), family = Gamma(link = "log"), data = dat)
summary(t4_dilution_model)
AIC(t4_dilution_model)

# Post Hoc Tests
post_hoc_dilution_t4 <- emmeans(t4_dilution_model, list(pairwise ~ site + trt))
pairs(post_hoc_dilution_t4, simple = "each")
plot(post_hoc_dilution_t4)

