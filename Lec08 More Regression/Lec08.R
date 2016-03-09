library(dplyr)
library(ggplot2)
library(foreign)

# Reference:  Chapter 3 and 4 of "Data analysis using regression and
# multilevel/hierarchical models" by Gelman and Hill
url <- "http://www.stat.columbia.edu/~gelman/arm/examples/child.iq/kidiq.dta"
kid.iq <- read.dta(url) %>% tbl_df()
kid.iq



#------------------------------------------------------------------------------
# Side note if you are curious: How did I get ggplot's default colors
# in last plot of Lec07: #F8766D and #00BFC4?
#------------------------------------------------------------------------------
# Create color wheel that ggplot picks its colors from:
r  <- seq(0,1,length=201)
th <- seq(0,2*pi, length=201)
d  <- expand.grid(r=r,th=th)
gg <- with(d,data.frame(d,x=r*sin(th),y=r*cos(th), z=hcl(h=360*th/(2*pi),c=100*r, l=65)))
ggplot(gg) +
  geom_point(aes(x,y, color=z), size=3)+
  scale_color_identity() +
  labs(x="",y="") +
  coord_fixed()

# Using this function, you can pick off colors from the color wheel below.
gg_color_hue <- function(n) {
  hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}

# For example if you want the 4 default colors, set n=4. You can look up the
# colors here: http://www.colorhexa.com/
gg_color_hue(n=4)



#------------------------------------------------
# Model 3: Continued
#------------------------------------------------
# Model 3.b) we now assume an interaction model using the * command:
model3b <- lm(kid_score ~ mom_iq * mom_hs, data=kid.iq)
summary(model3b)
b <- coefficients(model3b)
b
confint(model3b)

# Plot these lines
plot3 <- ggplot(kid.iq, aes(x=mom_iq, y=kid_score, color=factor(mom_hs))) +
  geom_point(size=3)

plot3 + 
  geom_abline(intercept=b[1], slope=b[2], col="#F8766D", size=1) +
  geom_abline(intercept=b[1]+b[3], slope=b[2]+b[4], col="#00BFC4", size=1)

# We can once again to this quick using geom_smooth()
plot3 + 
  geom_smooth(method="lm")
plot3 + 
  geom_smooth(method="lm", se=FALSE)
plot3 + 
  geom_smooth(method="lm") + 
  xlim(0, 140)
plot3 + 
  geom_smooth(method="lm", fullrange=TRUE) + 
  xlim(0, 140)



#------------------------------------------------
# Model 4: Multilevel Factor
#------------------------------------------------
# On page 67 of Gelman, they explain the mom_work categorial variable:
# mom_work = 1: mother did not work in the first three years of child's life
# mom_work = 2: mother worked in second or third year of child's life
# mom_work = 3: mother worked part-time in first year of child's life
# mom_work = 4: mother worked full-time in first year of child's life
plot4 <- 
  ggplot(kid.iq, aes(x=mom_iq, y=kid_score, color=as.factor(mom_work))) + 
  geom_point(size=3)
plot4

model4 <- lm(kid_score ~ mom_work + mom_iq, data=kid.iq)
summary(model4)

# The above treats mom_work as a numerical variable and not a categorical one,
# so we add an as.factor() to mom_work to make it ordinal categorical:
model4 <- lm(kid_score ~ as.factor(mom_work) + mom_iq, data=kid.iq)
summary(model4)

b <- coefficients(model4)
b
confint(model4)

# Plot these lines
plot4 + 
  geom_abline(intercept=b[1], slope=b[5], col="#F8766D", size=1) +
  geom_abline(intercept=b[1]+b[2], slope=b[5], col="#7CAE00", size=1) +
  geom_abline(intercept=b[1]+b[3], slope=b[5], col="#00BFC4", size=1) +
  geom_abline(intercept=b[1]+b[4], slope=b[5], col="#C77CFF", size=1)



#------------------------------------------------
# Model 5: Standardizing predictors
#------------------------------------------------
# Recall model 2
model2 <- lm(kid_score ~ mom_iq, data=kid.iq)
summary(model2)

# The intercept is meaningless since no mothers have IQ = 0.
plot2 <- ggplot(kid.iq, aes(x=mom_iq, y=kid_score)) + 
  geom_point()

plot2 + 
  geom_smooth(method="lm", se=FALSE, fullrange=TRUE) + 
  xlim(c(0, 140))

# What we can do is "standardize" the predictor so its centered at 0 and has
# SD = 1.
kid.iq <- kid.iq %>% 
  mutate(z_mom_iq = (mom_iq - mean(mom_iq))/sd(mom_iq))

ggplot(kid.iq, aes(x=z_mom_iq, y=kid_score)) + 
  geom_point()

model5 <- lm(kid_score ~ z_mom_iq, data=kid.iq)
summary(model5)



#------------------------------------------------
# Example of regression on logged outcome variable
#------------------------------------------------
url <- "http://www.stat.columbia.edu/~gelman/arm/examples/earnings/heights.dta"

# Filter out observations with earnings=0 and missing data
heights <- read.dta(url) %>%
  tbl_df() %>%
  filter(earn !=0 & !is.na(height) & !is.na(earn))
heights

# The earnings are very right-skewed
ggplot(data=heights, aes(x=earn)) +
  geom_histogram()

# So we log base 10 the earnings
heights <- mutate(heights, log_earn=log10(earn))

# We can plot the log-values
ggplot(data=heights, aes(x=log_earn)) +
  geom_histogram() +
  xlab("Log10 Earnings")

# Or alternatively change the scale of the x-axes to be base10, so that we can
# read the original values.
ggplot(data=heights, aes(x=earn)) +
  geom_histogram() +
  scale_x_log10() +
  xlab("Earnings (log10-scale)")

# We fit a regression to this model
model6 <- lm(log_earn~height, data=heights)
summary(model6)
b <- coefficients(model6)
b
confint(model6)

# This is what the data/regression looks like on the log-scale.  Note we use
# the jitter() function to put a little noise in the x-component so we can
# better see the number of points
ggplot(data=heights, aes(x=height, y=log_earn)) +
  geom_jitter() +
  xlab("height") +
  ylab("log of earnings") +
  geom_smooth(method="lm")