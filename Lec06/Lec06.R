# Load packages
library(dplyr)
library(ggplot2)


#------------------------------------------------------------------------------
# Solutions to Exercises from Lec05.R
#------------------------------------------------------------------------------
# Q1: Modify the Titanic code above to show a visualization that can answer the
# question of if the "Women and children first" policy of who got on the 
# lifeboats held true. Hint: the answer is yes.

# Use facets!
data(Titanic)
ggplot(data=Titanic, aes(x=Class, y=Freq, fill=Survived)) +
  geom_bar(stat="identity", position = "fill") +
  facet_grid(Age ~ Sex)





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
# Understanding geom_bar(stat="bin") vs geom_bar(stat="identity")
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