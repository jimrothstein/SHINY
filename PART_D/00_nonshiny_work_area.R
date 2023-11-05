
##  PURPOSE: NO shiny.   Here develop working R code.

## Out of 32.7k appeals in year ending SEP 30, 2023; 15/16 were rejected
library(data.table)
library(shiny)

the_dir = "./"
x  <- fread(paste0(the_dir, "cms_part_d_01OCT2022_30SEPT2023_data.csv"))


# -----------------
#   table of decisions
# -----------------
table(x$decision)
# -----------------

## SAME, data.table
y  <- x[ , .N, by=decision]
y
# -----------------


# -----------------
# BARPLOT
# -----------------
 barplot(y$N, names.arg=y$decision, 
              main="CMS Decisions: Part D, 01 OCT 2022 -- 30 SEPT 2023")
  

# 
# ----------------------
#   DISPLAY 1st 5 rows
# ----------------------

head(x, n=5)


# -----------------------
#   DISPLAY TOP N Drugs
# -----------------------

x[, .N, by= drug]

  names(x)
  str(x)




### decision_rational (paragraph, very large)
```{r}
if (F) x$decision_rationale
head(x$decision_rationale, 3)
```

```{r}
library(knitr)
library(data.table)
library(kableExtra)
options(knitr.table.format = "html") 

x[, .(decision_number, decision_rationale)][1:10] |>
  kable(table.attr = 'data-quarto-disable-processing="true"') 
```


head(x$decision_date)
head(x$decision_date_sortable)   # YYYYmmdd
```


### appeal_type; mostly drug
```{r}
table(x$appeal_type)
```
### _condition (1 word, can be sentence)
```{r}

head(x[, c(1,7)], n=20)
```

### top 16 drugs (in grievances)
```{r}
length(unique(x$drug))  # 4289 unique drugs
y  <- table(x$drug)


dt  <- data.table(y)
dt[order(-(N))][1:10, ]
dt[order(N)][1:10, ]

dt[order(N)][N>20] # 344
dt[order(N)][N>50] # 121
dt[order(N)][N>100] # 49 drugs

t16 = dt[order(N)][N>200] # 16 drugs
t16

barplot(t16$N, names.arg = t16$V1)
hist(t16$N)


```

### decision_rational (paragraph, very large)
```{r}
if (F) x$decision_rationale
head(x$decision_rationale, 3)

```

