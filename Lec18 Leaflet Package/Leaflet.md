Leaflet for Interactive Maps
========================================================
author: Albert Y. Kim
date: Friday 2016/4/8







Leaflet
========================================================

Today we will create **interactive** maps.





Open Street Maps
========================================================

[OpenStreetMap (OSM)](https://www.openstreetmap.org/#map=5/51.500/-0.100) is a
collaborative project to create a free editable map of the world. This is
crowd-sourced open source alternative to Google Maps. For example, the following
institutions use it instead of Google Maps:

* Craigslist
* Apple
* Foursquare





Leaflet
========================================================

[Leaflet](http://leafletjs.com/) is the leading open-source JavaScript library
for mobile-friendly interactive maps.

Quote on their page: Leaflet doesn't try to do everything for everyone. Instead
it focuses on making the basic things work perfectly.

Example: Classics Major Haley Tilt at Reed's project on [Livy's
Rome](http://livy.sds.reed.edu/map).





Leaflet for R
========================================================

There is an R package to interface with Leaflet which simply hooks Leaflet into
R: [https://rstudio.github.io/leaflet/](https://rstudio.github.io/leaflet/)





Basic Usage
========================================================

You create a Leaflet map with these basic steps:

1. Create a map widget by calling `leaflet()`.
1. Add layers (i.e., features) to the map by using layer functions to modify the
map widget.
1. Repeat step 2 as desired.
1. Print the map widget to display it.








