# Presentations
library(dplyr)
library(knitr)


# Set random number generator seed value
set.seed(7)

# Ensure balanced sampling so that at least 3 each day.
class <- c("Alison", "Aminata", "Andrew", "Carter", "Christian", "Delaney",
           "Enrique", "Jacob", "Joy", "Kyler", "Mo", "Paul", "Philip", "Shaojin")
order <- sample(class, 12)
last_row <- c(setdiff(class, order), "", "")
order <- order %>%
  matrix(ncol=4) %>%
  rbind(sample(last_row)) %>%
  as.data.frame()

# Present results
names(order) <- c("Monday 5/9", "Wednesday 5/11", "Friday 5/13", "Monday 5/16")
order
