
### Analysis of Adult and Nestling Cort Time of Day & Time to Collect

# Load Packages ----
library(ggplot2)
library(lubridate)
library(lme4)

# Load "Adult_Cort.csv" 
# Hereon, data file is named "adult"
adult <- read.csv("Data/Adult_Cort.csv")

# Clean data
adult$cort <- as.numeric(adult$cort_ng) # corticosterone level measured in plasma
adult$year <- as.factor(adult$year) # year data was collected
adult$sex <- as.factor(adult$sex) # sex of adult: "F" female, "M" male
adult$date <- as.Date(adult$date, "%m/%d/%y") # modify the format of the date of the year
adult$julian <- yday(adult$date) # create a new column for julian date
adult$time_decimal <- hour(hm(adult$time)) + minute(hm(adult$time)) / 60 # creat decimal time of day blood was taken
adult$bleed_time<- as.numeric(adult$bleed_time) # the time in seconds it took to bleed a birds start to finish



# --- ADULT TIME OF DAY MODEL ---
mod_adult_time <- glm(cort ~ time_decimal + julian + sex + year, 
                      family = Gamma(link = "log"), 
                      data = adult)
summary(mod_adult_time)


# Visualize Cort vs. Time of Day
ggplot(adult, aes(x = time_decimal, y = cort)) +
  geom_point(alpha = 0.5, color = "darkblue", size = 2) +
  # Fitted GLM curve matching your model family
  geom_smooth(method = "glm", 
              method.args = list(family = Gamma(link = "log")), 
              color = "black", fill = "grey70", se = TRUE) +
  labs(
    title = "Adult Plasma Corticosterone Across Time of Day",
    x = "Time of Day (Decimal Hours)",
    y = "Corticosterone (ng/mL)"
  ) +
  theme_classic(base_size = 14) +
  scale_x_continuous(breaks = seq(6, 18, by = 2))



# --- ADULT BLEED TIME MODEL ---
mod_adult_bleed <- glm(cort ~ bleed_time + julian + sex + year, 
                       family = Gamma(link = "log"), 
                       data = adult)
summary(mod_adult_bleed)


# Visualize Cort vs. Bleed Time
ggplot(adult, aes(x = bleed_time, y = cort)) +
  geom_point(alpha = 0.5, color = "darkred", size = 2) +
  geom_smooth(method = "glm", 
              method.args = list(family = Gamma(link = "log")), 
              color = "black", fill = "grey70", se = TRUE) +
  labs(
    title = "Adult Cort vs Time to Complete Bleed",
    x = "Bleed Time (Seconds)",
    y = "Corticosterone (ng/mL)"
  ) +
  theme_classic(base_size = 14)





# --------------------------------
# Load "Nestling_Cort.csv" 
# Hereon, data file is named "chick"
chick <- read.csv("Data/Nestling_Cort.csv")

# Clean data
chick$cort <- as.numeric(chick$cort) # corticosterone level measured in plasma
chick$nest <- as.factor(chick$nest) # unique nest ID
chick$year <- as.factor(chick$year) # year data was collected
chick$date <- as.Date(chick$date, "%m/%d/%y") # modify the format of the date of the year
chick$julian <- yday(chick$date) # create a new column for julian date
chick$time_decimal <- hour(hm(chick$time)) + minute(hm(chick$time)) / 60 # creat decimal time of day blood was taken
chick$bleed_time<- as.numeric(chick$bleed_time) # the time in seconds it took to bleed a birds start to finish


# --- NESTLING TIME OF DAY MODEL ---
mod_nest_time <- glmer(cort ~ time_decimal + julian + year + (1|nest), 
                       family = Gamma(link = "log"), 
                       data = chick)
summary(mod_nest_time)


# Visualize Cort vs. Time of Day
ggplot(chick, aes(x = time_decimal, y = cort)) +
  geom_point(alpha = 0.5, color = "magenta3", size = 2) +
  # Fitted GLM curve matching your model family
  geom_smooth(method = "glm", 
              method.args = list(family = Gamma(link = "log")), 
              color = "black", fill = "grey70", se = TRUE) +
  labs(
    title = "Nestling Plasma Corticosterone Across Time of Day",
    x = "Time of Day (Decimal Hours)",
    y = "Corticosterone (ng/mL)"
  ) +
  theme_classic(base_size = 14) +
  scale_x_continuous(breaks = seq(6, 18, by = 2))



# --- NESTLING BLEED TIME MODEL ---
mod_nest_bleed <- glmer(cort ~ scale(bleed_time) + scale(julian) + year + (1 | nest), 
                        family = Gamma(link = "log"), 
                        data = chick)
summary(mod_nest_bleed)


# Visualize Cort vs. Bleed Time
ggplot(chick, aes(x = bleed_time, y = cort)) +
  geom_point(alpha = 0.5, color = "darkred", size = 2) +
  geom_smooth(method = "glm", 
              method.args = list(family = Gamma(link = "log")), 
              color = "black", fill = "grey70", se = TRUE) +
  labs(
    title = "Nestling Cort vs Time to Complete Bleed",
    x = "Bleed Time (Seconds)",
    y = "Corticosterone (ng/mL)"
  ) +
  theme_classic(base_size = 14)
