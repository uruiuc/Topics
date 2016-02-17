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
# More dplyr practice: Financial Aid Data
#------------------------------------------------------------------------------
library(rvest)
webpage <- "http://apps.washingtonpost.com/g/page/local/college-grants-for-the-affluent/1526/"
wp_data <- webpage %>%
  read_html() %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table()
View(wp_data)

# Let's view the data in the console
wp_data

# This is unwieldy, so let's convert to tbl_df format so that the output isn't overwhelming
wp_data <- wp_data %>% tbl_df()
wp_data



#------------------------------------------------------------------------------
# Step 0: Data Cleaning
#------------------------------------------------------------------------------
# The column names are a little unwieldy. Let's rename them
# using: rename(data_frame, NEW_NAME = OLD_NAME)
#
# Some of the variable names have spaces, and dealing with spaces in 
# programming is a pain in the ass (PITA). Note how we treat the variable names
# that have spaces differently: we surround them with ` (top left of keyboard).
wp_data <- wp_data %>%
  rename(
    school = School,
    state = State,
    sector = Sector,
    comp_fee = `Tuition, fees, room and board 2013-14`,
    p_no_need_grant = `Percent of freshmen receiving no-need grants from school`,
    ave_no_need_grant = `Average no-need award to freshmen`,
    p_need_grant = `Percent receiving need-based grants from school`
  ) 
wp_data

# All money related values are not numerical variables but rather character 
# strings (note the chr under the variables comp_fee and ave_no_need_grant).
# We need to convert these character strings to numerical using a function.
# Don't worry about understanding this function for now, we'll talk about
# manipulating text data later.

currency_to_numeric <- function(x){
  # Convert currencies to numeric i.e. strip dollar signs and commas
  x <- gsub('\\$','', as.character(x))
  x <- gsub('\\,','', as.character(x))
  x <- as.numeric(x)
  return(x)
}
currency_to_numeric("$19,999")

# mutate the data set to change all curr
wp_data <- wp_data %>% 
  mutate(
    comp_fee = currency_to_numeric(comp_fee),
    ave_no_need_grant = currency_to_numeric(ave_no_need_grant)
  )
wp_data



# Using the ifelse() command, replace missing values with .5
# p_no_need_grant = ifelse(is.na(p_no_need_grant), .5, p_no_need_grant))



#------------------------------------------------------------------------------
# Step 1: Creating a new variable
#------------------------------------------------------------------------------






#------------------------------------------------------------------------------
# STEP 1: CREATING NEW VARIABLES
#------------------------------------------------------------------------------
# Create a region (south) variable:
table(wp_data$state)
state.list <- c('AL', 'AR', 'FL', 'GA', 'KY', 'LA', 'NC', 'SC', 'TN', 'TX')

wp_data <- wp_data %>%
  mutate(south = ifelse(state %in% state.list, 'south', 'non-south'))

# EXERCISE: create a region (NE) variable by changing the above code to create a
# binary variable that identifies the following states
state.list <- c('CT', 'DC', 'DE', 'MA', 'MD', 'ME', 'NH', 'NJ', 'NY', 'PA', 'RI', 'VT')



#------------------------------------------------------------------------------
# STEP 2: ARRANGE and SELECT DATA
#------------------------------------------------------------------------------
# Arranging/sorting the data by region (south)
# First let's sort the data by the south region variable
wp_data <- wp_data %>%
  arrange(south)

# The default for arrange is ascending, let's put that in descending order instead
wp_data <- wp_data %>%
  arrange(desc(south))

# It might be more useful to sort the data by multiple variables
wp_data <- wp_data %>%
  arrange(desc(south), ave_no_need_grant)

# We can also create a NEW data frame with just these variables while executing this code
south.data <-
  wp_data %>%
  arrange(desc(south), ave_no_need_grant) %>%
  select(south, ave_no_need_grant)

# Let's take a look.  What's missing?
View(south.data)

# Oops we forgot to include school name and sector
south.data <-
  wp_data %>%
  arrange(desc(south), ave_no_need_grant) %>%
  select(school, sector, south, ave_no_need_grant)

# EXERCISE: Create a similarly ordered data frame for the north_east



#------------------------------------------------------------------------------
# STEP 3: SUMMARIZE YOUR DATA
#------------------------------------------------------------------------------
# EXAMPLE: find the mean and standard deviation of each variable by region (south)
south.data %>%
  group_by(south) %>%
  summarise(mean_merit = mean(ave_no_need_grant))

# summarise_each() is like summarise, but on all (numerical) columns
south.data %>%
  group_by(south) %>%
  summarise_each(funs(mean(.), sd(.)))

# Or you can specify columns
wp_data %>%
  group_by(south) %>%
  summarise_each(
    funs(mean(.)),
    p_no_need_grant,  ave_no_need_grant,	p_need_grant)

wp_data %>%
  group_by(south) %>%
  summarise_each(
    funs(mean(.), sd(.)),
    p_no_need_grant,  ave_no_need_grant)

# EXERCISE: Do the same for NE schools




#------------------------------------------------------------------------------
# STEP 4: VISUALIZE YOUR DATA (HISTORGRAMS)
#------------------------------------------------------------------------------
ggplot(south.data, aes(x=ave_no_need_grant)) +
  geom_histogram()

ggplot(south.data, aes(x=ave_no_need_grant)) +
  geom_histogram() +
  theme_classic()

ggplot(south.data, aes(x=ave_no_need_grant)) +
  geom_histogram() +
  theme_classic() +
  facet_wrap( ~  south, ncol=2)

ggplot(south.data, aes(x=ave_no_need_grant, fill=as.factor(south))) +
  geom_histogram() +
  theme_classic() +
  facet_wrap( ~  south, ncol=2)

# The difference between facet_wrap() and facet_grid() is that you can
# cross-classify on two variables like below where the sector categorical
# variable are the columns and the south variable is are the rows
ggplot(south.data, aes(x=ave_no_need_grant, fill=as.factor(south))) +
  geom_histogram() +
  theme_classic() +
  facet_grid(south ~  sector)

ggplot(south.data, aes(x=ave_no_need_grant, fill=as.factor(south))) +
  geom_histogram(aes(y = ..density..)) +
  theme_classic() +
  facet_grid(south ~  sector)



#------------------------------------------------------------------------------
# EXERCISE:  Answer question from lecture
#------------------------------------------------------------------------------
# I want to know which states have the highest average no need grants (averaged
# over schools).
# 1. Create the smallest data frame (i.e. least number of rows, least number of
# columns) that answers this question.
# 2. Challenge: create a visualization of this data










#------------------------------------------------------------------------------
# Exercise02
#------------------------------------------------------------------------------