Joins
========================================================
author: Albert Y. Kim
date: Monday 2016/2/22





Combining Data Sets via Join Operations
========================================================
Imagine we have two data frames **`x**   and  **y`**:


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

We want to **join** them along the `x1` variable and end up with a new data frame that has all three variables.



Combining Data Sets via Join Operations
========================================================

* `dplyr`'s operations to join data sets are inspired by SQL (Structured Query Language), which used to query large databases.
* If values are missing during the join, `NA`'s are inserted.
* This [illustration](https://twitter.com/yutannihilation/status/551572539697143808) succinctly summarizes all of them.



