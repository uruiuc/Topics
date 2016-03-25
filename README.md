# Lecture Topics

The course syllabus (and setup instructions) can be found [here](http://rudeboybert.github.io/pages/teaching/courses/MATH216/2016-02.html).


### Week 7: 4/4 - 4/8

* **Lec17: GIS and Shapefiles**
    + 






### Week 6: 3/21 - 3/25

* **Lec14: Packages & Vignettes and Finishing Dates & Times**
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec14" target="_blank">Slides</a>: Hadleyverse, R Packages, and Vignettes.
    + Files:
        + `Lec14.R` Exercise.
        + Example of 3D plot using `plotly`: `3D_plot_ex.Rmd`
* **Lec16: Shiny**
    + [xkcd on GitHub](http://explainxkcd.com/wiki/index.php/1597:_Git).
    + [`datacamp.com`](http://www.datacamp.com) resource for learning R/Python in browser.
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec16" target="_blank">Slides</a>: Shiny.



### Week 5: 3/14 - 3/18

* **Lec11: Even More Logistic Regression**
    + In-class Lecture
    + Files: `Lec11.R` Exercise.
* **HW-1 Discussion**
    + In lab discussion
    + Files: `HW-1_Albert_Notes.Rmd` from the `HW-1` folder. 
    + Setup:
        + Save `HW-1_Albert_Notes.Rmd` in your `HW-1` project folder.
        + If you haven't already, install the `DT`, `knitr`, and `plotly` packages.
        + Load the datasets in your console.
* **Lec13: Final Project and Dates & Times with `lubridate`**
    + Final project [guidelines](http://htmlpreview.github.io/?https://raw.githubusercontent.com/Middlebury-Data-Science/Topics/master/Lec13%20Project/project.html). Your project proposal is due Wednesday April 6th (after break) at 11:15.
    + Open this [Quandl](https://www.quandl.com/data/BAVERAGE/USD-USD-BITCOIN-Weighted-Price) link.
    + Files: `Lec13.R` Exercise from "Lec13: Dates and Times with lubridate" folder.




### Week 4: 3/7 - 3/11

* **Lec08: More Regression**
    + In-class Lecture and <a href="http://htmlpreview.github.io/?https://raw.githubusercontent.com/Middlebury-Data-Science/Topics/master/Lec08%20More%20Regression/Orders_of_Magnitude.html#1" target="_blank">Slides</a>
    + Files: `Lec08.R` Exercise.
* **Lec09: Logistic Regression and OkCupid Data**
    + In-class Lecture and <a href="http://rpubs.com/rudeboybert/MATH216_Lec09" target="_blank">Slides</a>
    + Files:
        + `Lec09.R` Exercise.
        + [OkCupid Data CSV](https://github.com/rudeboybert/JSE_OkCupid/raw/master/profiles.csv.zip)
* **Lec10: More Logistic Regression**
    + In-class Lecture







### Week 3: 2/29 - 3/4

* **Lec05: R Markdown and More `ggplot2`**
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec05b" target="_blank">Slides</a>: Markdown and R Markdown
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec05" target="_blank">Slides</a>: More ggplot2
    + Link to [R Markdown Debugging Checks](https://docs.google.com/document/d/1P7IyZ4On9OlrCOhygFxjC7XhQqyw8OludwChz-uFd_o/edit?usp=sharing)
    + Files: `Lec05.R` Exercise.
* **Lec06: Finishing `ggplot2` and Tidy Data using `tidyr`**
    + <a href="https://github.com/Middlebury-Data-Science/Topics/blob/master/Lec06%20Tidy%20Data%20with%20tidyr/UCB.pdf" target="_blank">Slides</a>: UC Berkeley admissions data discussions (Click on RAW to download)
    + <a href="https://github.com/Middlebury-Data-Science/Topics/blob/master/Lec06%20Tidy%20Data%20with%20tidyr/DataWranglingWithR.pdf" target="_blank">Slides</a>: `tidyr` Package
    + Files:
        + `Lec06.R` Exercise.
        + `popdensity1990_00_10.csv` 1990, 2000, 2010 Census data.
* **Lec07: Regression to the Mean**
    + In-class Lecture
    + Files: `Lec07.R` Exercise.







### Week 2: 2/22 - 2/26

* **Lec04: `ggplot2` Package**
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec04" target="_blank">Slides</a>: More components of a statistical graphic and other ressources.
    + Files: `Lec04.R` Exercise.
* **Lec03:**
    + **`dplyr` Joins**
        + <a href="http://rpubs.com/rudeboybert/MATH216_Lec03a" target="_blank">Slides</a>: `dplyr` joins for merging data frames.
        + Files:
            * `Lec03.R` Exercise.
            * `states.csv`. Click on `Raw` button, then Save Page As `states.csv` and not `states`.
    + **Grammar of Graphics**
        + <a href="http://rpubs.com/rudeboybert/MATH216_Lec03b" target="_blank">Slides</a>: Discussion on [The Grammar of Graphics paper](http://byrneslab.net/classes/biol607/readings/wickham_layered-grammar.pdf).
        + Files: `babynames.Rmd`. Example of Shiny app (interactive visualization); install `shiny` and listed packages first.
      


            


            
### Week 1: 2/15 - 2/19

* **Lec02: Loading Data**
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec02" target="_blank">Slides</a>: The importance of minimizing prerequisites to research, loading data into RStudio via CSV files or webscraping.
    + Files:
        * `Lec02.R` Exercise. To download:
            1. Go to the above directory "Lec02 Loading Data"
            1. Click on `Lec02.R` -> Raw
            1. From your browser's menu bar -> File -> Save Page As... Be sure to save as `Lec02.R` and not `Lec02.R.txt`
        * `UCBAdmissions.xlsx` Excel spreadsheet. To download repeat steps a. and b. above.
    + <a href="https://github.com/Middlebury-Data-Science/HW-0" target="_blank">HW-0</a>, due Wednesday 2016/2/24, is posted. This is merely a practice homework to familiarize yourselves to the HW submission format and process.
* **Lec01: Data manipulation with `dplyr`**
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec01" target="_blank">Slides</a>: Tidy data, data manipulation verbs, piping `%>%` with the `magrittr` package.
    + Files: `Lec01.R` Exercise
* **Lec00: Intro to Data Science**
    + <a href="http://rpubs.com/rudeboybert/MATH216_Lec00" target="_blank">Slides</a>: What is data science? Building our data toolbox.
    
    
    