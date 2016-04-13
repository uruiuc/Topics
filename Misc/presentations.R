# Presentations
set.seed(76)
class <- c("Alison", "Aminata", "Andrew", "Carter", "Christian", "Delaney",
           "Enrique", "Jacob", "Joy", "Kyler", "Mo", "Paul", "Philip", "Shaojin")
order <- sample(class, 12)
last_row <- c(setdiff(class, order), "", "")

order <- order %>%
  matrix(ncol=4) %>%
  rbind(sample(last_row)) %>%
  as.data.frame()
names(order) <- paste("Day", 1:4)
order


