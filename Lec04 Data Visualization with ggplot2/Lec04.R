# Load packages
library(dplyr)
library(ggplot2)
library(rvest)

#------------------------------------------------------------------------------
# Solutions to Exercises from Lec03.R
#------------------------------------------------------------------------------
# Before going over the solutions, do the following:
#
# -Re-run lines 20-51 from Lec03.R to load the wp_data
# -Load the states.csv file from Lec03

# -Which region (south, NE, west, or midwest) has the highest proportion of its
#  colleges being private



# -For each region, compute the values necessary to draw a whisker-less boxplot
#  of the annual tuition fees.




# We will consider the diamonds data set
data(diamonds)
head(diamonds)
?diamonds
n <- nrow(diamonds)
n

# Since the diamonds data set is too big, let's only consider a randomly chosen
# sample of 500 of these points:
set.seed(76)
samp <- sample(1:n, size = 500)
diamonds <- diamonds[samp,]


# We build up the plot incrementally from the base:
# -data: is the data considered
# -aes() is the function that maps variables to aesthetics
ggplot(data=diamonds, aes(x = carat, y = price))

# Nothing shows. We need a geometry: points.  We add it with a + sign
ggplot(data=diamonds, aes(x = carat, y = price)) +
  geom_point()

# Look at the help file for geom_point(), in particular the aesthetics it
# understands
?geom_point

# The default value (i.e. if you don't set it to anything) for the "color"
# aesthetic is black.  Let's map the "cut" variable to color
ggplot(data=diamonds, aes(x = carat, y = price, colour = cut)) +
  geom_point()


# scale: put the y-axis on a log-scale
ggplot(data=diamonds, aes(x = carat, y = price, colour = cut)) +
  geom_point() +
  scale_y_log10()


# facet: break down the plot by cut
ggplot(data=diamonds, aes(x = carat, y = price, colour = cut)) +
  geom_point() +
  scale_y_log10() +
  facet_wrap(~cut, nrow=2)


# extra: add title
ggplot(data=diamonds, aes(x = carat, y = price, colour = cut)) +
  geom_point() +
  scale_y_log10() +
  facet_wrap(~cut, nrow=2) +
  ggtitle("First example")


# Note all the above could've been added incrementally to a variable
p <- ggplot(data=diamonds, aes(x = carat, y = price, colour = cut))
p <- p + geom_point()
p <- p + scale_y_log10()
p <- p + facet_wrap(~cut, nrow=2)
p <- p + ggtitle("First example")
p


# Exercise:  Create a plot that shows once again the relationship between carat,
# but now let the size of the points reflect the table of the diamond and have
# separate plots by clarity


# Exercise:  A friend wants to know if cars in 1973-1974 that have bigger
# cylinders (the variable displacement in cu. in.) have better mileage (in mpg).
# Two important factors they want to consider are the # of cylinders and whether
# the car has an automatic or manual transmission.  Answer your friend's
# question using a visualization. As added bonus, use google to add detailed
# x-labels and y-labels
data(mtcars)
?mtcars




#------------------------------------------------------------------------------
# From Last Time:
#------------------------------------------------------------------------------
# Exercise:  For a random sample of 500 diamonds, create a plot that shows once
# again the relationship between carat, but now let the size of the points
# reflect the table of the diamond and have separate plots by clarity
data(diamonds)
n <- nrow(diamonds)
set.seed(76)
samp <- sample(1:n, size = 500)
diamonds <- diamonds[samp, ]

ggplot(data=diamonds, aes(x = carat, y = price, colour = cut, size = table)) +
  geom_point() +
  scale_y_log10() +
  facet_wrap(~clarity, nrow=2) +
  ggtitle("Second example")


# Exercise:  A friend wants to know if cars in 1973-1974 that have bigger
# cylinders (the variable displacement in cu. in.) have better mileage (in mpg).
# Two important factors they want to consider are the # of cylinders and whether
# the car has an automatic or manual transmission.  Answer your friend's
# question using a visualization. As added bonus, use google to add detailed
# x-labels and y-labels
data(mtcars)
?mtcars
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
  geom_point(size=4) +
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




