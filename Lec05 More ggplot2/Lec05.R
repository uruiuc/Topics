# Load packages
library(dplyr)
library(ggplot2)
library(nlme)



#------------------------------------------------------------------------------
# Solutions to Exercises from Lec04.R
#------------------------------------------------------------------------------
# Q1.  Create a plot that shows once again the relationship between carat,
# but now let the size of the points reflect the table of the diamond and have
# separate plots by clarity
data(diamonds)
n <- nrow(diamonds)

# Last time we sampled at random 500 rows of diamonds. i.e. instead of plotting
# them plot only a subset.

# set.seed() sets the seed value for R's random number generator so that we get 
# replicable randomness.  Compare the following two outputs
set.seed(76)
sample(10)

set.seed(76)
sample(10)

# Last time I sampled 500 rows as follows:
samp <- sample(1:n, size = 500)
diamonds <- diamonds[samp, ]

# A much more elegant way to sample 500 rows is using dplyr's sample_n() function:
data(diamonds)
diamonds <- sample_n(diamonds, size = 500)

# We add the aesthetic size to be mapped from the variable table AND we facet
# plot them by clarity. This way we can compare the relationship between carat
# and price, for different tables, AND split by different clarity.
# facets are a VERY powerful tool.
ggplot(data=diamonds, aes(x = carat, y = price, colour = cut, size = table)) +
  geom_point() +
  facet_wrap(~clarity, nrow=2) +
  ggtitle("Second example")



# Q2. A friend wants to know if cars in 1973-1974 that have bigger cylinders
# (the variable displacement in cu. in.) have better mileage (in mpg). Two
# important factors they want to consider are the # of cylinders and whether the
# car has an automatic or manual transmission.  Answer your friend's question
# using a visualization. As added bonus, use google to add detailed x-labels and
# y-labels
data(mtcars)
table(mtcars$cyl)

# Here the variable cyl is treated as a continuous varible, so we get a
# continous color gradient
ggplot(data=mtcars, aes(x=disp, y=mpg, color=cyl)) +
  geom_point() +
  facet_wrap(~am)

# Here we convert the variable cyl to a categorical variable, with three
# levels/labels: 4, 6, and 8.  Furthermore, we set the size of the points to be
# 4.
ggplot(data=mtcars, aes(x=disp, y=mpg, color=as.factor(cyl))) +
  geom_point() +
  facet_wrap(~am)





#------------------------------------------------------------------------------
# Examples of groups
#------------------------------------------------------------------------------
# The following are the same. i.e. the default group aesthetic is "1":  all same
# group
ggplot(Oxboys, aes(age, height)) + geom_line()
ggplot(Oxboys, aes(age, height, group=1)) + geom_line()

# Set base plot
p <- ggplot(Oxboys, aes(age, height, group = Subject)) + geom_line()
p

# Add regression lines (but not SE bars)
p + geom_smooth(aes(group = Subject), method="lm", se = FALSE)
p + geom_smooth(aes(group = 1), method="lm", se = FALSE)





#------------------------------------------------------------------------------
# Examples of geoms
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

# Points
p + geom_point(size=5, color="darkorange") + ggtitle("geom_point")

# Bars.  Here we need to set the "statistical transformation" to "identity", b/c
# the default for geom_bar is "bin"
p + geom_bar(stat="identity") + ggtitle("geom_bar(stat=\"identity\")")

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
p + geom_polygon(color="red", size=4, fill="green") + ggtitle("geom_polygon")

# For the diamond dataset, let's look at a histogram of carat.
ggplot(data=diamonds, aes(x=carat)) + geom_histogram()

# If we don't specify the binwidth, then it gets set to the default 0.1
ggplot(data=diamonds, aes(x=carat)) + geom_histogram(binwidth = 0.1)

# The default aesthetic mapping carat to the y-axis is based on count.  Note,
# since "count" is not a variable name in our dataset, we need to put ".."
# around it.
ggplot(data=diamonds, aes(x=carat)) +
  geom_histogram(aes(y = ..count..), binwidth = 0.2)

# Instead of count, we can have density, i.e. the height x width of each box
# is the proportion
ggplot(data=diamonds, aes(x=carat)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.2)





#------------------------------------------------------------------------------
# Titanic Survival Data
#------------------------------------------------------------------------------
# The original data is not in "tidy" format, so we tidy it.  Here tidying was
# super easy.  Typically it won't be. Note, for each row, the observations
# correspond to Class x Sex x Age X Survived categories (i.e. 32 rows), and not
# individual people on the boat (in this case we would've had 2201 rows)
data(Titanic)
Titanic
Titanic <- as.data.frame(Titanic)
Titanic

# Define base, title, and faceting
titanic.plot <-
  ggplot(data=Titanic, aes(x=Class, y=Freq, fill = Survived)) +
  ggtitle("Titanic Survival Counts by Class x Gender x Age") +
  facet_wrap(~ Age + Sex, nrow = 1)

# No layers just yet. We need to add a geom
titanic.plot

# Bar plots with different "position" adjustments. The default is "stack"
titanic.plot + geom_bar(stat = "identity")
titanic.plot + geom_bar(stat = "identity", position="stack")
titanic.plot + geom_bar(stat = "identity", position="dodge")
titanic.plot + geom_bar(stat = "identity", position="fill")

# Flip the coordinate system
titanic.plot + geom_bar(stat = "identity", position="fill") + coord_flip()

# Question:  What can you say about the captain's "policy"?










#------------------------------------------------------------------------------
# UC Berkeley
#------------------------------------------------------------------------------
data(UCBAdmissions)
UCBAdmissions

# The original data is not in "tidy" format, so we tidy it.  Here tidying was
# super easy.  Typically it won't be.
UCB <- as.data.frame(UCBAdmissions)
UCB


# Investigate!

#------------------------------------------------------------------------------
# UC Berkeley
#------------------------------------------------------------------------------
data(UCBAdmissions)
UCBAdmissions

# The original data is not in "tidy" format, so we tidy it.  Here tidying was
# super easy.  Typically it won't be.
UCB <- as.data.frame(UCBAdmissions)
UCB


library(scales)
ggplot(UCB, aes(x=Gender, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  facet_wrap(~ Dept, nrow = 2) +
  scale_y_continuous(labels = percent) +
  ggtitle("Acceptance Rate Split by Gender & Department") +
  xlab("Gender") +
  ylab("% of Applicants")


ggplot(UCB, aes(x=Dept, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  ggtitle("Acceptance Rate Split by Department") +
  xlab("Dept") +
  ylab("% of Applicants")


#------------------------------------------------------------------------------
# Question about stat("identity")
#------------------------------------------------------------------------------
ex <- data.frame(count=c(rep("A", 5), rep("B", 3)))
ex
ggplot(ex, aes(x=count)) + geom_bar()
ggplot(ex, aes(x=count)) + geom_bar(stat="bin")
ex2 <- data.frame(name=c("A", "B"), count=c(5, 3))
ex2
ggplot(ex2, aes(x=name, y=count)) + geom_bar()
ggplot(ex2, aes(x=name, y=count)) + geom_bar(stat="identity")



#------------------------------------------------------------------------------
# Wrapping Up UC Berkeley Admissions
#------------------------------------------------------------------------------
# Load and "tidy" data
data(UCBAdmissions)
UCB <- as.data.frame(UCBAdmissions)

# The scales package allows us to put %'ages on axes
library(scales)
ggplot(UCB, aes(x=Gender, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  facet_wrap(~ Dept, nrow = 2) +
  scale_y_continuous(labels = percent) +
  ggtitle("Acceptance Rate Split by Gender & Department") +
  xlab("Gender") +
  ylab("% of Applicants")

ggplot(UCB, aes(x=Dept, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  ggtitle("Acceptance Rate Split by Department") +
  xlab("Dept") +
  ylab("% of Applicants")

# Eye candy:  change up the color scheme by changing scale
# See http://colorbrewer2.org/ for different palette names
ggplot(UCB, aes(x=Dept, y=Freq, fill = Admit)) +
  geom_bar(stat = "identity", position="fill") +
  ggtitle("Acceptance Rate Split by Department") +
  xlab("Dept") +
  ylab("% of Applicants") + scale_fill_brewer(palette="Pastel1")



#------------------------------------------------------------------------------
# Exercises:
#------------------------------------------------------------------------------

# 1. Construct a statistical graphic showing how male vs female acceptance
# varied by department.  Bonus:  Using google, make one of the axes reflect
# percentage of applicants.
# 2. Construct a statistical graphic showing the "competitiveness" of the
# department as measured by acceptance rate.