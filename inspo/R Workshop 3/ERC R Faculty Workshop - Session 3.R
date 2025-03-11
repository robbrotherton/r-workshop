rm(list=ls(all=TRUE))


library(dplyr)
library(lmtest)
library(sandwich)

setwd("/Users/patriciakirkland/Dropbox/Empiprical Reasoning Center/R Workshop")

### user-defined functions

addVectors <- function(a,b) {
    
    out.vec <- a + b
    
    return(out.vec)
    
}

a <- 1:10
b <- -1:-10

addVectors(a, b)

x <- 1:10
y <- -1:-10

addVectors(x, y)

z <- addVectors(a=x, b=y)

cluster_se   <- function(dat,fm, cluster){
    require(sandwich, quietly = TRUE)
    require(lmtest, quietly = TRUE)
    M <- length(unique(cluster))
    N <- length(cluster)
    K <- fm$rank
    dfc <- (M/(M-1))*((N-1)/(N-K))
    uj  <- apply(estfun(fm),2, function(x) tapply(x, cluster, sum));
    vcovCL <- dfc*sandwich(fm, meat=crossprod(uj)/N)
    coeftest(fm, vcovCL) }


load("muni_finance_data_cleaned.RData")

fit_3 <- lm(Total.Expenditure.PC ~ Total.Taxes.PC + Population + Census.Region, data=COG.fips)
summary(fit_3)

# heteroskedasticity-robust standard errors
coeftest(fit_3, vcov=vcovHC(fit_3, type="HC1"))

robust_se <- function(regmodel){
    require(sandwich, quietly = TRUE)
    require(lmtest, quietly = TRUE)
    coeftest(regmodel, vcov=vcovHC(regmodel, type="HC1"))
}

# robust SEs with our user-defined function
robust_se(fit_3)

# cluster-robust standard errors
cluster_se(COG.fips, fit_3, COG.fips$fipsid)


## clear the workspace
rm(list=ls(all=TRUE))

setwd("/Users/patriciakirkland/Dropbox/Empiprical Reasoning Center/R Workshop")

source("ERC R Workshop Source.R")

load("muni_finance_data_cleaned.RData")

fit_3 <- lm(Total.Expenditure.PC ~ Total.Taxes.PC + Population + Census.Region, data=COG.fips)
summary(fit_3)

# robust SEs with our user-defined function (from source file)
robust_se(fit_3)

# cluster-robust standard errors (from source file)
cluster_se(COG.fips, fit_3, COG.fips$fipsid)


#------------------------------------------------------
# 
# Automating tasks--- an example
#
#------------------------------------------------------

rm(list=ls(all=TRUE))


library(dplyr)

setwd("/Users/patriciakirkland/Dropbox/Empiprical Reasoning Center/R Workshop")



#### build annual .csv files from COG text files
directory <- "/Users/patriciakirkland/Dropbox/Census of Governments/_IndFin_1967-2007"
year <- 2000:2007

COG.muni <- data.frame()

for(j in year){ 
    
i <- substr(as.character(j), 3, 4)
    
COG.a <- read.csv(paste0(directory, "/", "IndFin", formatC(i, width = 2, flag = "0"), "a",
                        ".txt"))

COG.b <- read.csv(paste0(directory, "/", "IndFin", formatC(i, width = 2, flag = "0"), "b",
                        ".txt"))

COG.c <- read.csv(paste0(directory, "/", "IndFin", formatC(i, width = 2, flag = "0"), "c",
                        ".txt"))

COGmerge <- left_join(COG.a, COG.b)

COGmerge <- left_join(COGmerge, COG.c)

COG.muni.temp <- subset(COGmerge, Type.Code == 2)  

COG.muni <- rbind(COG.muni, subset(COGmerge, Type.Code == 2))

}











