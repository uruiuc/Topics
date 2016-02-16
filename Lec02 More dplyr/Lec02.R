# Load dplyr and ggplot2 packages
library(dplyr)
library(ggplot2)



#------------------------------------------------------------------------------
# Solutions to Exercises from Lec01.R
#------------------------------------------------------------------------------
# We load the Motor Trend cars data set.
data(mtcars)
mtcars

# Make the rownames an explicit variable (column) in the data set. The missing
# variable is a flaw in the dataset as originally loaded.
mtcars <- mtcars %>% 
  add_rownames() %>% 
  rename("make_model"=rowname)


# Using the help file and the commands above, do the following:
# -Identify the cars with 4 forward gears in decreasing order of horse power.
# Don't show all variables, but car make and model name and the horse power.

mtcars %>% 
  filter(gear==4) %>% 
  arrange(desc(hp)) %>% 
  select(make_model, hp)

# Notes:
# -The 1st two lines above are equilavent to 
filter(mtcars, gear==4)
# b/c %>% by default pipes to the first argument of the function
# -We then arrange in decreasing order of hp
# -We then select the appropriate columns
# -Also, observe that we are not saving the output of these commands to anything
#  If we want to save this output, we need to save it to a new variable as follows:
car_list <- mtcars %>% 
  filter(gear==4) %>% 
  arrange(desc(hp)) %>% 
  select(make_model, hp)
car_list

# -Compute the average miles per gallon (mpg) for automatic vs manual transmission
# We need to inject a grouping structure to the mtcars data frame via group_by(am)
# which R will treat as a categorical variable with 2 levels.
mtcars %>% 
  group_by(am) %>% 
  summarize(avg_mpg = mean(mpg))


















#------------------------------------------------------------------------------
# Exercise02
#------------------------------------------------------------------------------