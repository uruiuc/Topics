library(dplyr)
library(ggplot2)
library(rgeos)
library(rgdal)
library(leaflet)
library(maptools)

# We are going to plot the shapefiles from Lec17 onto an interactive map



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





