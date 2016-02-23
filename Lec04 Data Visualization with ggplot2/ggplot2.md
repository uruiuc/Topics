The Grammar of Graphics
========================================================
author: Albert Y. Kim
date: Wednesday 2016/2/24




What is a statistical graphic?
========================================================

Recall: A statistical graphic is a mapping of variables in a

* **`data`** set to 
* **`aes()`**thetic attributies of 
* **`geom_`**etric objects.

These are, in my view, the most important components to think about.


Basic Components
========================================================
* **`aes`** mappings of data to _aesthetics_ we can perceive on a graphic: x/y position, color, size, and shape. Each aesthetic can be mapped to a variable in our data set.  If not assigned, they are set to defaults.
* **`geom`** geometric objects: type of plot: points, lines, bars, etc.
* **`stat`** statistical transformations to summarise data: smoothing, binning values into a histogram, or just itself "identity"



More Components
========================================================
* **`facet`** how to break up data into subsets and display broken down plots
* **`scales`** both
    + convert **data units** to **physical units** the computer can display
    + draw a legend and/or axes, which provide an inverse mapping to make it possible to read the original data values from the graph.
* **`coord`** coordinate system for x/y values: typically cartesian.
* **`position`** adjustments
* **Extras** titles, axes labels, themes



Further Reading Ressources
========================================================

* Online help files: [http://docs.ggplot2.org/current/](http://docs.ggplot2.org/current/)
* ggplot2 book is on Moodle.  To learn more, I suggest reading
    + Chapter 1,
    + Chapter 3, but it will be hard to grasp the first time
    + Chapter 4
    + Revisit Chapter 3. Chapters 5-10 go into specific details.
* The code for all examples in the book: [http://ggplot2.org/book/](http://ggplot2.org/book/)



Last Time: Basic Components
========================================================

* **`aes`** mappings of data variables to aesthetics we can perceive on a graphic
* **`geom`** geometric objects
* **`stat`** statistical transformations to summarise data
* **`facet`** how to break up plots into subsets
* **`coord`** coordinate system for x/y values: typically cartesian (can be polar)
* **`scale`** both convert **data units** to **physical units** the computer can display AND draw a legend/axes.
* **Extras** titles, axes labels, themes



Further Reading Ressources
========================================================
* Help files.  Ex `?geom_line()`
* Online help files: [http://docs.ggplot2.org/current/](http://docs.ggplot2.org/current/)
* [Ultimate Tech Support](http://xkcd.com/627/)

* ggplot2 book is on Moodle.  To learn more, I suggest reading
    + Chapter 1,
    + Chapter 3, but it will be hard to grasp the first time
    + Chapter 4
    + Revisit Chapter 3. Chapters  5-10 go into specific details.
* The code for all examples in the book: [http://ggplot2.org/book/](http://ggplot2.org/book/)



Today:  More Components/Concepts
========================================================
* **layers**: mechanism by which additional data elements are added to a plot
* **`position`** adjustments: minor tweeks to the position of elements
* **groups**: splitting data into groups within the same plot (not via facets)



Building a Graphic Layer-by-Layer
========================================================
We build plots by adding **layers**. Each layer consists of:

1. data and aesthetic mappings (the base)
2. geometric object
3. statistical transformation (with default values)
4. position adjustment (with default values)

Without all four elements specified, nothing will plot!



Building a Graphic Layer-by-Layer
========================================================

Notes:

* Make the base as general as possible
* Every `geom` has a default `stat` & `position` value if they aren't specified
* Layer settings override plot defaults
* You can save plots as variables and add to variables, to reduce duplication



Examples for Today
========================================================
In `ggplot_2.R` we have examples of

* setting groups: `Examples of groups`.
* many different types of geoms: `Examples of geoms`.
* `geom_histogram()` and **position adjustments**: [Titanic Survival Data](https://www.youtube.com/watch?v=zisjRgcuL9k)



Today's Question: UC Berkeley Admissions
========================================================

In 1973, the UC Berkeley was sued for bias against women who had applied for admission to graduate schools.  n=4526 applicants:

```
Source: local data frame [4 x 3]
Groups: Admit [?]

     Admit Gender  Freq
    (fctr) (fctr) (dbl)
1 Admitted   Male  1198
2 Admitted Female   557
3 Rejected   Male  1493
4 Rejected Female  1278
```



Today's Question: UC Berkeley Admissions
========================================================

![plot of chunk unnamed-chunk-3](ggplot2-figure/unnamed-chunk-3-1.png)



Today's Question: UC Berkeley Admissions
========================================================






```
Error in check_breaks_labels(breaks, labels) : object 'percent' not found
```
