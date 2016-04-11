library(dplyr)
library(ggplot2)
library(rgdal)
library(maptools)


# Install this package.  We need this to run Moran's I.
library(spdep)





# Do Hispanics Cluster? ---------------------------------------------------

# - Import the Multnomah county shapefile "tract2010". Unzip the zip file and set 
# the working directory to be where the shapefiles are:
# - Convert the coordinate system to latitude/longitude using the spTransform()
# function.
# - Select only census tracts in Multnomah County using the FIPS code for
# Mulnomah County
PDX_shapefile <- readOGR(dsn=".", layer="tract2010") %>%
  spTransform(CRS("+proj=longlat +ellps=WGS84")) %>%
  subset(COUNTY=="051")

# Get the data frame of information from the shapefile.  In this case rather 
# weirdly we have to use @ instead of $ to extract the data. Then compute the
# proportion of the population that is hispanic for each census tract.
PDX_data <- PDX_shapefile@data %>% 
  tbl_df() %>%
  mutate(prop.hisp=HISPANIC/POP10)

# We convert the shapefile to a ggplot'able data frame and then plot it
PDX_map <- fortify(PDX_shapefile, region="FIPS") %>% 
  tbl_df()

ggplot(PDX_map, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white") +
  geom_path(col="black", size=0.5) +
  coord_map() +
  theme_bw()

# Join the census tract data to the map data
PDX_map <- inner_join(PDX_map, PDX_data, by=c("id"="FIPS"))

# Plot the object. Remind yourself what all the layers in the plot correspond to
ggplot(PDX_map, aes(x=long, y=lat, group=group, fill=prop.hisp)) +
  geom_polygon() +
  geom_path(col="black", size=0.5) +
  coord_map() +
  scale_fill_continuous(low="white", high="black", name="Prop. Hispanic") +
  theme_bw()





# Spatial Connectivity map ------------------------------------------------

# Recreate the Spatial Connectivity map from the slides. Much of the code in
# this section is techincal, so don't worry about understanding how all the
# functions work competely.

# Get coordinates of each region.
PDX_coord <- coordinates(PDX_shapefile)
PDX_coord

# Get neighbor information
PDX_nb <- poly2nb(PDX_shapefile, queen = FALSE)
summary(PDX_nb)

# Get weights as defined in slides.  "B" indicates basic weights.
PDX_weights <- nb2listw(PDX_nb, style = "B", zero.policy = TRUE)

# Plot using base R, not ggplot.  Don't worry about understanding the code; try
# to understand what the plot is saying.
plot(PDX_shapefile, border = "grey60", main="Spatial Connectivity")
box()
plot(PDX_nb, PDX_coord, pch = 19, cex = 0.3, lwd=0.5, add = TRUE)






# Moran's I ---------------------------------------------------------------

# We're going to test Moran I's on statistical noise. runif(n, min=a, max=b)
# returns n Uniform(a,b) random variables. i.e. n values uniformly chosen on the
# interval [a,b]].

# Run the next bit of code a few times to convince yourselves of this fact.
n <- nrow(PDX_data)
noise <- runif(n, min=0, max=1)
ggplot(data=NULL, aes(x=noise)) +
  geom_histogram(boundary=0, binwidth=0.1)

# We then compute Moran's I using Y_i = noise.  Look at the statistic and 
# p-value for multiple runs of the following two lines. Again, run this a few 
# times to see how the p-value behaves.
noise <- runif(n, min=0, max=1)
moran.test(noise, PDX_weights)





# EXERCISE ----------------------------------------------------------------

# Use Moran's I to see if there is evidence that hispanics cluster.
# Investigate some other varibles as well

