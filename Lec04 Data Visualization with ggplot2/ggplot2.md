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

All pages/chapters refer to the "A Layered Grammar of Graphics" paper.



Other Components of a Statistical Graphic
========================================================

More components (page 8). From hardest conceptually to easiest:

* **`scales`** what axes and legends
* **`stat`** statistical transformations of the data (p.11)
* **`position`** minor tweeks to the position of elements
* **`facet`** how to break up data into subsets and display broken down plots
* **`coord`** coordinate system: cartesian, polar, etc.
* **Extras** titles, axes labels, themes



Hard Aspect of ggplot
========================================================

Understanding the defaults (hence Chapter 4 in the paper).  In particular

* Each `geom_` has a defined set of aesthetics.  Ex: Look at `geom_bar` on cheatsheet.
* Each `geom_` has a default `stat`. Ex: `geom_bar`'s default `stat` is `count`. If you want to use a different `stat`, like
`identity`, you have to set `stat=identity`.



Further Reading Ressources
========================================================

* Help files.  Ex `?geom_line`
* Reread the paper after a few lectures.
* Online [help files](http://docs.ggplot2.org/current/)
* `ggplot2` book is under Non-Public section of class GitHub page, code from book 
[here](http://ggplot2.org/book/). If you want to read it
(optional), I suggest reading
    + Chapter 1,
    + Chapter 3, but it will be hard to grasp the first time
    + Chapter 4
    + Revisit Chapter 3.
    + Chapters 5-10 go into specific details.
