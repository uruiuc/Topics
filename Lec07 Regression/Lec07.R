library(tidyr)
library(dplyr)
library(ggplot2)
library(stringr)
library(babynames)

# This package allows us to read .dta STATA files into R via read.dta().
# Install it:
library(foreign)



#------------------------------------------------------------------------------
# Solutions to Exercises from Lec06.R
#------------------------------------------------------------------------------
# Run the following line to load necessary example data: cases, storms, pollution
pollution <- structure(
  list(city = c("New York", "New York", "London", "London", "Beijing", "Beijing"),
       size = c("large", "small", "large", "small", "large", "small"),
       amount = c(23, 14, 22, 16, 121, 56)),
  .Names = c("city", "size", "amount"),
  row.names = c(NA, -6L),
  class = "data.frame")

cases <- structure(
  list(country = c("FR", "DE", "US"),
       `2011` = c(7000, 5800, 15000),
       `2012` = c(6900, 6000, 14000),
       `2013` = c(7000, 6200, 13000)),
  .Names = c("country", "2011", "2012", "2013"),
  row.names = c(NA, -3L),
  class = "data.frame")

storms <- structure(
  list(storm = c("Alberto", "Alex", "Allison", "Ana", "Arlene", "Arthur"),
       wind = c(110L, 45L, 65L, 40L, 50L, 45L),
       pressure = c(1007L, 1009L, 1005L, 1013L, 1010L, 1010L),
       date = structure(c(11172, 10434, 9284, 10042, 10753, 9664), class = "Date")),
  .Names = c("storm", "wind", "pressure", "date"),
  class = c("tbl_df", "data.frame"),
  row.names = c(NA, -6L))



# Q1: Add varibles "county_name" and "state_name" to the census data
# frame, which are derived from the variable "QName".  Do this in a manner that
# keeps the variable "QName" in the data frame.
census <- read.csv("~/Documents/Teaching/MATH216/Topics/Lec06 Tidy Data with tidyr/popdensity1990_00_10.csv") %>% tbl_df()

# Note there needs to be a space
census <- 
  separate(census, QName, c("county_name", "state_name"), sep=", ", remove=FALSE)
select(census, county_name, state_name)



# Q2: Create a new variable FIPS_code that follows the federal standard:
# http://www.policymap.com/blog/wp-content/uploads/2012/08/FIPSCode_Part4.png
# As a sanity check, ensure that the county with FIPS code "08031" is Denver
# County, Colorado.  Hint: the str_pad() command in the stringr package might
# come in handy

# We can't treat STATE and COUNTY as numerical variables, b/c we need the single
# digit ID's, like Alabama having STATE code 1.  Rather we treat them as
# character strings "padded with 0's".  Then we use the unite() command.
census <-
  mutate(census,
         state_code = str_pad(STATE, 2, pad="0"),
         county_code = str_pad(COUNTY, 3, pad="0")
  )
census <- unite(census, "FIPS_code", state_code, county_code, sep = "")

# Denver county has STATE code 8 and COUNTY code 31, but we see we've correctly
# padded them with 0's.
filter(census, FIPS_code=="08031")



# Q3: Plot histograms of the population per county, where we have the
# histograms facetted by year (1990, 2000, 2010).

# For ggplot to work cleanly, we need to first convert the data into
# tidy format.  We create a new data frame consisting of county_name,
# state_name, FIPS_code, and total population and gather() it in long format
# "keyed" by year.
totalpop <- select(census, county_name, state_name, contains("totalpop"))

totalpop <- gather(totalpop, "year", totalpop, contains("totalpop")) %>%
  mutate(year=factor(year, labels=c("1990", "2000", "2010")))

# Now that we have a keying variable "year", we can easily facet this plot
ggplot(totalpop, aes(x=totalpop, y=)) +
  geom_histogram() +
  facet_wrap(~year) +
  scale_x_log10() +
  xlab("County population (log-scale)") +
  ggtitle("County populations for different years")



# Q4: Now consider the babynames data set which is in tidy format.  For example,
# consider the top male names from the 1880's:The most popular male and female
# names in the 1890's were John and Mary. Present the proportion for all males
# named John and all females named Mary (some males were recorded as females,
# for example) for each of the 10 years in the 1890's in wide format.  i.e. your
# table should have two rows, and 11 columns: name and the one for each year

# We remove the "n" and "sex" variable to keep the table looking clean.
filter(babynames,
       (name=="Mary" & sex=="F") | (name=="John" & sex=="M"),
       year >=1880 & year <= 1889
) %>%
  select(-n, -sex) %>%
  spread(year, prop)





#------------------------------------------------------------------------------
# Linear Regression
#------------------------------------------------------------------------------
# Reference:  Chapter 3 of "Data analysis using regression and 
# multilevel/hierarchical models" by Gelman and Hill Note all code/data from
# this book can be found at http://www.stat.columbia.edu/~gelman/arm

# Load child data from Gelman:  predicting cognitive test scores of 3-4 year old
# children given characteristics of their mothers, using data from the National
# Longitudinal Survey of Youth.
# Recall tbl_df() changes the data frame so that not all rows show when we print
# its contents
url <- "http://www.stat.columbia.edu/~gelman/arm/examples/child.iq/kidiq.dta"
kid.iq <- foreign::read.dta(url) %>% tbl_df()
kid.iq



#------------------------------------------------
# Model 0: Just the average
#------------------------------------------------
p <- ggplot(data=kid.iq, aes(x=kid_score)) + geom_histogram()
p

ybar <- mean(kid.iq$kid_score)
p + geom_vline(xintercept=ybar, col="red", size=1)



#------------------------------------------------
# Model 1: Include mom's high school information
#------------------------------------------------
means <- group_by(kid.iq, mom_hs) %>%
  summarise(mean=mean(kid_score))
means

# Note we make mom_hs a categorical variable by as.factor() or factor()'ing it
ggplot(kid.iq, aes(x=as.factor(mom_hs), y=kid_score)) + geom_boxplot()
ggplot(kid.iq, aes(x=kid_score, y=..density..)) + geom_histogram() +
  facet_wrap(~ mom_hs, ncol=1)

p <- ggplot(kid.iq, aes(x=as.factor(mom_hs), y=kid_score, color=as.factor(mom_hs))) + geom_point()
p
# Now add horizontal lines corresponding to the means.  Note the [[2]] says
# extract the second column
p + geom_hline(yintercept=means[[2]], color=c("#F8766D", "#00BFC4"), size=1)

# This is how we fit a linear (regression) model in R:
model1 <- lm(kid_score ~ mom_hs, data=kid.iq)
model1
# The last output isn't so helpful; here is the full regression table.  Compare
# the table to the means data frame above
summary(model1)

# Other useful functions
coefficients(model1)
confint(model1)
fitted(model1) # the fitted yhat values
resid(model1) # the residuals



#------------------------------------------------
# Model 2: Include mom's IQ
#------------------------------------------------
p <- ggplot(kid.iq, aes(x=mom_iq, y=kid_score)) + geom_point()
p

model2 <- lm(kid_score ~ mom_iq, data=kid.iq)
summary(model2)

# We plot the regression line by extracting the intercept and slope using square
# brackets:
b <- coefficients(model2)
b
p + geom_abline(intercept=b[1], slope=b[2], col="blue", size=1)

# We can do this quick via geom_smooth()
p + geom_smooth(method="lm", size=1, level=0.95)



#------------------------------------------------
# Model 3: Include BOTH mom's IQ and high
#------------------------------------------------
ggplot(kid.iq, aes(x=mom_iq, y=kid_score, color=mom_hs)) + geom_point()

# Note we have the multiple colors b/c R is treating mom_hs as a numerical
# variable, when really it is a categorical variable.  So we convert it to a
# categorical variable via factor() or as.factor()
p <- ggplot(kid.iq, aes(x=mom_iq, y=kid_score, color=factor(mom_hs))) +
  geom_point(size=3)
p


# Model 3.a) We fit the first model assuming an intercept shift, or just the
# additive effect of a mom having completed high school
model3a <- lm(kid_score ~ mom_iq + mom_hs, data=kid.iq)
summary(model3a)

# Plot these lines
b <- coefficients(model3a)
b
p + geom_abline(intercept=b[1], slope=b[2], col="#F8766D", size=1) +
  geom_abline(intercept=b[1]+b[3], slope=b[2], col="#00BFC4", size=1)


