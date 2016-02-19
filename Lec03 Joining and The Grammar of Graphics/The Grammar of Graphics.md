The Grammar of Graphics
========================================================
author: Albert Y. Kim
date: Monday 2016/2/22




What is a statistical graphic?
========================================================

At its simplest:

A statistical graphic is a mapping of variables in a

* **`data`** set to 
* **`aes()`**thetic attributies of 
* **`geom_`**etric objects.

These are, in my view, the most important components to think about.



Example: Napolean's March on Moscow
========================================================
Famous graphical illustration by Minard of Napolean's march to and retreat from Moscow in 1812
![alt text](Minard.png)



Example: Napolean's March on Moscow
========================================================

6 dimensions (variables) of information on a 2 dimensional page:

**`data`** | **`aes()`**  | **`geom_`**
------------- | ------------- | -------------
longitude | **`x`** | **`point`** 
latitude | **`y`** | **`point`** 
army size | **`size`** | **`path`**
forward vs retreat | **`color`** | **`path`**
date | **`x, y`** | **`text`**
temperature | **`x, y`** | **`line`**



Example from Paper
========================================================



```
Error in parse(text = x, srcfile = src) : 
  <text>:11:0: unexpected end of input
9: ggplot(data=simple, aes(x=A, y=B)) + geom_point()
10: ggplot(data=simple, aes(x=A, y=B)) + geom_point() + 
   ^
```
