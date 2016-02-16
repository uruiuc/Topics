More dplyr
========================================================
author: Albert Y. Kim
date: Wednesday 2016/2/16





Data Files
========================================================

CSV. No fluff, just the important stuff.




Berkeley Admissions Data
========================================================


```r
# Write UC Berkeley data to CSV.
library(readr)
data("UCBAdmissions")
UCBAdmissions <- UCBAdmissions %>% as.data.frame()
write_csv(UCBAdmissions, path = "./Lec02 More dplyr/UCBAdmissions.csv")
```

