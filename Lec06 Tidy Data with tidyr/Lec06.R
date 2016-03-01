# Load packages
library(dplyr)
library(ggplot2)

# Install the tidyr package to "tidy" data
library(tidyr)

# Install the babynames package: All babynames (with n >= 5) from the Social
# Security Administration from 1880 to 2013: https://github.com/hadley/babynames
library(babynames)





#------------------------------------------------------------------------------
# Solutions to Exercises from Lec05.R
#------------------------------------------------------------------------------
# Q1: Modify the Titanic code above to show a visualization that can answer the
# question of if the "Women and children first" policy of who got on the 
# lifeboats held true. Hint: the answer is yes.

# Use facets!
data(Titanic)
Titanic <- as.data.frame(Titanic)
ggplot(data=Titanic, aes(x=Class, y=Freq, fill=Survived)) +
  geom_bar(stat="identity", position = "fill") +
  facet_grid(Age ~ Sex)
# We observe that for any class and age, men died more than women (bigger pink
# bars). Also for any class and sex, children (top row) survived at a higher
# rate. Also, it's nice to see that the White Star Line Company didn't employ
# any children!


# Q2: Investigate how male vs female acceptance varied by department.
data(UCBAdmissions)
UCB <- as.data.frame(UCBAdmissions)
UCB
ggplot(UCB, aes(x=Gender, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  facet_wrap(~ Dept, nrow = 2) +
  ggtitle("Acceptance Rate Split by Gender & Department") +
  xlab("Gender") +
  ylab("Prop of Applicants")


# Q3. Investigate the "competitiveness" of different departments as measured by acceptance rate.
ggplot(UCB, aes(x=Dept, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  ggtitle("Acceptance Rate Split by Department") +
  xlab("Dept") +
  ylab("% of Applicants")

UCB_competitiveness <- UCB %>% 
  group_by(Admit, Dept) %>% 
  summarise(Freq=sum(Freq))

ggplot(UCB_competitiveness, aes(x=Dept, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  ggtitle("Acceptance Rate Split by Department") +
  xlab("Dept") +
  ylab("% of Applicants")

# Eye candy:  change up the color scheme by changing scale
# See http://colorbrewer2.org/ for different palette names
ggplot(UCB_competitiveness, aes(x=Dept, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  ggtitle("Acceptance Rate Split by Department") +
  xlab("Dept") +
  ylab("% of Applicants") + scale_fill_brewer(palette="Pastel1")





#------------------------------------------------------------------------------
# Finishing ggplot2: Examples of other geom's
#------------------------------------------------------------------------------
# We're going to work with the following data frame
df <- data.frame(
  x = c(3, 1, 5),
  y = c(2, 4, 6),
  label = c("a","b","c")
)
df

# We set up the "base of the plot" in as general a fashion as possible
p <- ggplot(data=df, aes(x, y, label = label)) + xlab(NULL) + ylab(NULL)

# geom_point: Points
p + geom_point(size=5, color="darkorange") + ggtitle("geom_point")

# Line, ordered by x value
p + geom_line(size=4) + ggtitle("geom_line")

# Area plot
p + geom_area() + ggtitle("geom_area")

# Line, in order of data
p + geom_path() + ggtitle("geom_path")

# Text
p + geom_text(size = 10, angle=90) + ggtitle("geom_text")

# Tiles centered at coordinates
p + geom_tile() + ggtitle("geom_tile")

# Polygon with vertices defined at coordinates
p + geom_polygon(color="blue", size=4, fill="orange") + ggtitle("geom_polygon")





#------------------------------------------------------------------------------
# tidy Data
#------------------------------------------------------------------------------
# We create 3 new data frames: pollution, cases, storms
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

pollution
cases
storms




#---------------------------------------------------------------
# Going from tidy (AKA narrow AKA tall) format to wide format and vice versa
# using gather() and separate()
#---------------------------------------------------------------
# Convert to tidy format. All three of the following do the same:  "year" is the
# new "key" variable and n is the "value" variable
cases
gather(data=cases, key="year", value=n, 2:4)
gather(cases, "year", n, `2011`, `2012`, `2013`)
gather(cases, "year", n, -country)


# Convert to wide format. The "key" variable is size and the "value" variable is
# amount
pollution
spread(pollution, size, amount)


# Note: gather() and spread() are opposites of each other
cases
gather(cases, "year", n, -country) %>% spread(year, n)



#---------------------------------------------------------------
# separate() and unite() columns
#---------------------------------------------------------------
# Separate the year, month, day from the date variable":
storms
storms2 <- separate(storms, date, c("year", "month", "day"), sep = "-")
storms2

# Undo the last change using unite()
unite(storms2, "date", year, month, day, sep = "-")





#-------------------------------------------------------------------------------
# EXERCISES
#-------------------------------------------------------------------------------
# From Eleanor: Census data with total population, land area, and population
# density in wide format
census <- read.csv("popdensity1990_00_10.csv", header=TRUE) %>% tbl_df()
View(census)


# EXERCISE: Add varibles "county_name" and "state_name" to the census data
# frame, which are derived from the variable "QName".  Do this in a manner that
# keeps the variable "QName" in the data frame.



# EXERCISE: Create a new variable FIPS_code that follows the federal standard:
# http://www.policymap.com/blog/wp-content/uploads/2012/08/FIPSCode_Part4.png
# As a sanity check, ensure that the county with FIPS code "08031" is Denver
# County, Colorado.  Hint: str_pad() command in the stringr



# EXERCISE: Plot histograms of the population per county, where we have the
# histograms facetted by year.



# EXERCISE: Now consider the babynames data set which is in tidy format.  For
# example, consider the top male names from the 1880's:
babynames
filter(babynames, year >=1880 & year <= 1889, sex=="M") %>%
  group_by(name) %>%
  summarize(n=sum(n)) %>%
  ungroup() %>%
  arrange(desc(n))


# The most popular male and female names in the 1890's were John and Mary.
# Present the proportion for all males named John and all females named Mary
# (some males were recorded as females, for example) for each of the 10 years in
# the  1890's in wide format.  i.e. your table should have two rows, and 11
# columns: name and the one for each year







