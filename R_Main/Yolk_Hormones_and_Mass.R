
### Analysis of Yolk Hormones and Yolk Mass
# Yolk Corticosterone, Yolk Testosterone, and Yolk Thyroxine
# Yolk Wet Mass

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
dat$cort_yolk <- as.numeric(dat$cort_ng.g_yolk) # Mass-Normalized Yolk Corticosterone Concentration
dat$test_yolk <- as.numeric(dat$test_ng.g_yolk) # Mass-Normalized Yolk Testoerone Concentration
dat$t4_yolk <- as.numeric(dat$t4_ng.g_yolk) # Mass-Normalized Yolk Thyroxine Concentration


# Rename groups
levels(dat$site)
levels(dat$site) <- c("Natural", "Rural", "Urban")
levels(dat$trt)
levels(dat$trt) <- c("Control", "Food")




################################################################################
################################################################################
## Mass-Normalized Yolk Corticosterone Concentration
## ng / g yolk

# Visualize
# Mass-Normalized Yolk Corticosterone Concentration across sites and treatment groups
pal1 <- c("indianred4", "salmon")
ggplot(data = dat, aes(x = site, y = cort_yolk, group = trt, shape = trt)) +
  geom_jitter(aes(colour = trt, shape = trt), size = 4, alpha = 0.6, position = position_jitterdodge(dodge.width = 0.9)) +
  stat_summary(fun = mean, geom = "point", size = 6, position = position_dodge(width = 0.9),
               color = "black", alpha = 0.9) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.1, linewidth = 1,
               color = "black", alpha = 0.9, position = position_dodge(width = 0.9)) +
  scale_y_continuous(name = 'Mass-Normalized Yolk Corticosterone (ng/g)', breaks = c(1,2,3,4,5,6,7)) +
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

# Basic plot of Mass-Normalized Yolk Corticosterone Concentration across laying sequence
ggplot(dat, aes(x = layorder, y = cort_yolk, color = trt, group = trt)) +
  geom_point(aes(color=trt), position = position_jitterdodge(dodge.width = 0.5)) +
  geom_smooth(method = "lm", aes(colour = trt)) +
  facet_wrap(~site)+
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9)) +
  theme_classic()
 

#########
# Generalized Linear Mixed Effect Model of Mass-Normalized Yolk Corticosterone Concentration
cort_yolk_model <- glmer(cort_yolk ~ site * trt + scale(layorder) + scale(clutch_size) + scale(julian) + year + 
                      (1|nest), family = Gamma(link = "log"), data = dat)
summary(cort_yolk_model)
AIC(cort_yolk_model)

# Post Hoc Tests
post_hoc_yolk_cort <- emmeans(cort_yolk_model, list(pairwise ~ site * trt))
pairs(post_hoc_yolk_cort, simple = "each")
plot(post_hoc_yolk_cort)





################################################################################
################################################################################
## Mass-Normalized Yolk Testosterone Concentration
## ng / g yolk

# Visualize
# Mass-Normalized Yolk Testosterone Concentration across sites and treatment groups
pal2 <- wes_palettes$Cavalcanti1
ggplot(data = dat, aes(x = site, y = test_yolk, group = trt, shape = trt)) +
  geom_jitter(aes(colour = trt, shape = trt), size = 4, alpha = 0.6, position = position_jitterdodge(dodge.width = 0.9)) +
  stat_summary(fun = mean, geom = "point", size = 6, position = position_dodge(width = 0.9),
               color = "black", alpha = 0.9) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.1, linewidth = 1,
               color = "black", alpha = 0.9, position = position_dodge(width = 0.9)) +
  scale_y_continuous(name = 'Mass-Normalized Yolk Testosterone (ng/g)', breaks = c(2,4,6,8,10,12,14,16)) +
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

# Basic plot of Mass-Normalized Yolk Testosterone Concentration across laying sequence
ggplot(dat, aes(x = layorder, y = test_yolk, color = trt, group = trt)) +
  geom_point(aes(color=trt), position = position_jitterdodge(dodge.width = 0.5)) +
  geom_smooth(method = "lm", aes(colour = trt)) +
  facet_wrap(~site)+
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9)) +
  theme_classic()


########
# Generalized Linear Mixed Effect Model of Mass-Normalized Yolk Testosterone Concentration
test_yolk_model <- glmer(test_yolk ~ site * trt + scale(layorder) + scale(clutch_size) + scale(julian)+ year +
                      (1|nest), family = Gamma(link = "log"), data = dat)
summary(test_yolk_model)
AIC(test_yolk_model)

# Post Hoc Tests
post_hoc_yolk_test <- emmeans(test_yolk_model, list(pairwise ~ site * trt))
pairs(post_hoc_yolk_test, simple = "each")
plot(post_hoc_yolk_test)




################################################################################
################################################################################
## Mass-Normalized Yolk Thyroxine Concentration
## ng / g yolk

# Visualize
# Mass-Normalized Yolk Thyroxine Concentration across sites and treatment groups
pal3 <- c("steelblue", "lightsteelblue")
ggplot(data = dat, aes(x = site, y = t4_yolk, group = trt, shape = trt)) +
  geom_jitter(aes(colour = trt, shape = trt), size = 4, alpha = 0.7, position = position_jitterdodge(dodge.width = 0.9)) +
  stat_summary(fun = mean, geom = "point", size = 6, position = position_dodge(width = 0.9),
               color = "black", alpha = 0.9) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.1, linewidth = 1,
               color = "black", alpha = 0.9, position = position_dodge(width = 0.9)) +
  scale_y_continuous(name = 'Mass-Normalized Yolk Thyroxine (ng/g)', breaks = c(0,1,2,3,4,5,6,7,8,9)) +
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

# Basic plot of Mass-Normalized Yolk Thyroxine Concentration across laying sequence
ggplot(dat, aes(x = layorder, y = t4_yolk, color = trt, group = trt)) +
  geom_point(aes(color=trt), position = position_jitterdodge(dodge.width = 0.5)) +
  geom_smooth(method = "lm", aes(colour = trt)) +
  facet_wrap(~site)+
  scale_y_continuous(breaks = c(0,1,2,3,4,5,6,7,8,9)) +
  theme_classic()


#################################
# Generalized Linear Mixed Effect Model of Mass-Normalized Yolk Thyroxine Concentration
t4_yolk_model <- glmer(t4_yolk ~ site * trt + scale(layorder) + scale(clutch_size) + scale(julian) + year + 
                      (1|nest), family = Gamma(link = "log"), data = dat)
summary(t4_yolk_model)
AIC(t4_yolk_model)

# Post Hoc Tests
post_hoc_yolk_t4 <- emmeans(t4_yolk_model, list(pairwise ~ site + trt))
pairs(post_hoc_yolk_t4, simple = "each")
plot(post_hoc_yolk_t4)




################################################################################
################################################################################
## Yolk Mass

# Visualize
# Yolk mass across sites and treatment groups
pal4 <- c("#999999",  "#008176")
ggplot(data = dat, aes(x = site, y = yolk, group = trt, shape = trt)) +
  geom_jitter(aes(colour = trt, shape = trt), size = 4, alpha = 0.6, position = position_jitterdodge(dodge.width = 0.9)) +
  stat_summary(fun = mean, geom = "point", size = 6, position = position_dodge(width = 0.9),
               color = "black", alpha = 0.9) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.1, linewidth = 1,
               color = "black", alpha = 0.9, position = position_dodge(width = 0.9)) +
  scale_y_continuous(name = 'Yolk Mass (g)', breaks = c(0.25, 0.3, 0.35)) +
  scale_x_discrete(name = 'Site') +
  labs(color = "Treatment") +
  scale_color_manual(values = pal4) +
  theme_classic() +
  theme(
    axis.text = element_text(size = 15, face = "bold"),
    axis.title = element_text(size = 17, colour = "black", face = "bold"),
    legend.title = element_text(size = 18,
                                colour="black",face = "bold",vjust = 1),
    legend.text = element_text(size=13))

# Basic plot of yolk mass across laying sequence
ggplot(dat, aes(x = layorder, y = yolk, color = trt, group = trt)) +
  geom_point(aes(color=trt), position = position_jitterdodge(dodge.width = 0.1)) +
  geom_smooth(method = "lm", aes(colour = trt)) +
  facet_wrap(~site)+
  scale_x_continuous(breaks = c(1,2,3,4,5,6)) +
  scale_y_continuous(breaks = c(0.15,0.2,0.25,0.3,0.35,0.4)) +
  theme_classic()


#################################
# Linear Mixed Effect Model of Yolk Mass
mass_best_model <- lmer(yolk ~ site * trt + layorder + clutch_size + julian + year + 
                     (1|nest), data = dat)
summary(mass_best_model)
AIC(mass_best_model)

# Post Hoc Tests
post_hoc_yolk_mass <- emmeans(mass_best_model, list(pairwise ~ site * trt))
pairs(post_hoc_yolk_mass, simple = "each")
plot(post_hoc_yolk_mass)

#### Normality Test ####
shapiro.test(residuals(mass_best_model));length(residuals(mass_best_model))
qqnorm(resid(mass_best_model))
qqline(resid(mass_best_model))
plot(density(resid(mass_best_model)))
  # residuals are normal if p is > 0.05.
  # residuals are normally distributed. 

#### Homogeneity of variance ####
library(DHARMa)
simulation_output <- simulateResiduals(mass_best_model)
plot(simulation_output)
testDispersion(simulation_output)  # This will test for over/underdispersion
  # p-value > 0.05 means there is no dispersion problems

model_data <- na.omit(dat[, c("yolk_mass", "site", "trt", "layorder", "clutch_size", "julian", "year", "nest")])
leveneTest(resid(mass_best_model) ~ model_data$trt)
leveneTest(resid(mass_best_model) ~ model_data$site)
  # p-value is > 0.05, variance is equal among site and trt groups

