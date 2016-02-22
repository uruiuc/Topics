Joins
========================================================
author: Albert Y. Kim
date: Monday 2016/2/22





Combining Data Sets via Join Operations
========================================================
Imagine we have two data frames **`x** and **y`**:


```
  x1 x2
1  A  1
2  B  2
3  C  3
```

```
  x1    x3
1  A  TRUE
2  B FALSE
3  D  TRUE
```

We want to **join** them along the categorical variable `x1`and end up with a
new data frame that has all three variables:



Combining Data Sets via Join Operations
========================================================


```r
inner_join(x, y, by = "x1")
```

```
  x1 x2    x3
1  A  1  TRUE
2  B  2 FALSE
```

```r
full_join(x, y, by = "x1")
```

```
  x1 x2    x3
1  A  1  TRUE
2  B  2 FALSE
3  C  3    NA
4  D NA  TRUE
```



Combining Data Sets via Join Operations
========================================================

* `dplyr`'s operations to join data sets are inspired by SQL (Structured Query
Language), which is used to query large databases.
* If a value is missing during the join, `NA` (R code for missing value) is
inserted.

In our example, both data frames `x` and `y` the had the "join by" variable
named the same: `x1`. Hence:

```
inner_join(x, y, by = "x1")
```



The "join by" variable
========================================================

If the "join by" variable has different names in the data frames.  Ex:

* name `a` in data frame `x`
* name `b` in data frame `y`

then run:  `inner_join(x, y, by = c("a"="b"))`. 

Note it is

* ` by = c("a"="b")` and not
* `by = c("a"=="b")`

See `by` in the "Argument" section of the help file `?join`.



Types of Joins
========================================================

* See `?join` for a list of the different types of joins
* This
[illustration](https://twitter.com/yutannihilation/status/551572539697143808)
succinctly summarizes all of them.



Good Practice
========================================================

At the beginning of `Lec03.R`, I load all necessary packages at the beginning.

This is good practice people know which packages they need 
installed. For example, I didn't know I needed a particular package before I 
boarded a 4 hour flight because the package loading was buried in
the file.








