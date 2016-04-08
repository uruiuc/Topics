library(dplyr)
library(ggplot2)
library(rgeos)
library(rgdal)
library(maptools)

# Install this:
library(leaflet)



# Loading Shapefiles ------------------------------------------------------

# 1. Either by setting the path
shapefile_path <- "/Users/rudeboybert/Downloads/tl_2015_50_tract/"
map_obj <- readOGR(dsn = shapefile_path, layer = "tl_2015_50_tract")

# 2. Or by setting your current working directory:
map_obj <- readOGR(dsn = ".", layer = "tl_2015_50_tract")



# sp Package Object -------------------------------------------------------
# The shapefile is loaded in R as a sp Package SpatialPolygonsDataFrame
# i.e. it has polygon info, and then for each polygon the data. The way you 
# access the data is via the @ operator
class(map_obj)
map_obj@data

# We can plot it in base R as well as ggplot below
plot(map_obj, axes=TRUE)



# Convert Shapefile to ggplot Data Frame and Plot--------------------------
map_obj$id <- rownames(map_obj@data)
map_points <- fortify(map_obj, region="id")
map_df <- inner_join(map_points, map_obj@data, by="id")

ggplot(map_df, aes(x=long, y=lat, group=group)) +
  labs(x="longitude", y="latitude", title="Vermont Census Tracts") +
  coord_map() +
  geom_polygon(fill="white") +
  geom_path()



# Leaflet Basics ----------------------------------------------------------

# Set up the base, just like using the function ggplot(). We see nothing shows
# up:
m <- leaflet()
m 



# Layers i.e. Base Maps ---------------------------------------------------
# https://rstudio.github.io/leaflet/basemaps.html

# We need to add "layers" i.e. features. The most 
# fundamental one we need to add are "tiles", you can think of as a "base map". 
# Kind of like ggplot, but we use the piping %>% operator instead of +
m <- leaflet() %>% 
  addTiles()
m

# The default tiling is using OpenStreetMap. You can switch this out to others
# as described in https://rstudio.github.io/leaflet/basemaps.html
# For example http://stamen.com/ is map/data visulization startup in SF:
leaflet() %>% 
  addTiles() %>% 
  addProviderTiles("Stamen.Toner")



# Markers -----------------------------------------------------------------
# https://rstudio.github.io/leaflet/markers.html

# The next layer we consider are markers via addMarkers. They call out points on
# the map
# Click on the resulting marker. 
m <- leaflet() %>%
  addTiles() %>%
  addMarkers(lng=-73.177222, lat=44.008889, popup="Middlebury College")

# How did I get the coordinates? I went to Wikipedia and got 
# latitude and longitude (44°00′32″N 73°10′38″W) and used a lat/long degrees to
# decimal converter. For Ex: https://www.fcc.gov/media/radio/dms-decimal
# Note: because we are
# -West of the Meridian Line in London, the longitude is negative
# -Above the equator, the latititude is positive

# You can add any number of markers
m <- leaflet() %>%
  addTiles() %>%
  addMarkers(lng=-73.177222, lat=44.008889, popup="Middlebury College") %>% 
  addMarkers(lng=-73.566667, lat=45.5, popup="Montreal")
m

# Or we can add a large number of markers. Show first 20 rows from the `quakes` 
# dataset
data(quakes)
View(quakes)

leaflet(data = quakes[1:20,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag))



# Popups ------------------------------------------------------------------
# https://rstudio.github.io/leaflet/popups.html

# Popups are like markers, but you can messages. This does requires a little
# knowledge of HTML:
content <- 
  paste(
    "<b><a href='http://www.middlebury.edu'>Middlebury College</a></b>",
    "14 Old Chapel Rd",
    "Middlebury VT 05753",
    sep = "<br/>"
)
content

leaflet() %>% 
  addTiles() %>%
  addPopups(lng=-73.177222, lat=44.008889, content, 
            options = popupOptions(closeButton = FALSE))



# Adding Vector Data ------------------------------------------------------
# https://rstudio.github.io/leaflet/shapes.html

# Assuming your current working directory is set to where the VT shapefile is.
# Note the use of readOGR is a little different here than above:
VT <- readOGR("tl_2015_50_tract.shp", layer = "tl_2015_50_tract", verbose = FALSE)

# To add the VT shapefile, we need to specify it in the leaflet() call
leaflet(VT) %>%
  addTiles()

# Nothing! We need to specify a geom. 
leaflet(VT) %>%
  addTiles() %>% 
  addPolylines()

# Yuck, let's change the color of the lines to black
leaflet(VT) %>%
  addTiles() %>% 
  addPolylines(color="black", weight=1)

# Much like ggplot, we can map variables to aesthetics
leaflet(VT) %>%
  addTiles() %>%
  addPolygons(
    color = ~colorQuantile("YlOrRd", VT$AWATER)(AWATER)
  )

# Type ?addPolylines to see the full list of "geoms" and their arguments



# Shiny -------------------------------------------------------------------
# It also syncs seemlessly with Shiny: https://rstudio.github.io/leaflet/shiny.html




