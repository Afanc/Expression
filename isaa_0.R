#!/usr/bin/R
library(isa2)
library(lattice)
library(topGO)
source("https://bioconductor.org/biocLite.R")
library(biomaRt)


exp = read.csv("data/rpkm.txt", sep = ",")
exp = as.matrix(exp)

#normalisation log des données
epsilon = 0.04

pdf("log_expression.pdf")
head(exp)
exp+epsilon
hist(log10(as.vector(as.matrix(exp+epsilon))),100)

log_exp = log10(exp+epsilon)
zscored_exp = scale(log_exp)

#Sys.time()
#modules2 = isa(log10(exp+epsilon), thr.row = c(0.5, 1, 1.5, 2), thr.col = c(0.5, 1, 1.5, 2))

#Sys.time() #permet de savoir le temps que prend la fonction pour compiler
#modules = isa(exp)
#Sys.time()



droplevelsthatworks = function(x){
    return(droplevels(x))
}

rmod = vector(,length(modules$rows[1,]))
for(i in length(modules$rows[1,])){
    rmod[i] = modules$rows[,i]
    #très moche, pas faire ça
    assign(paste("rmod", i, sep = ""), which(rmod1_i != 0))
    assign(paste("g_mod",i, sep = ""), gene_id[i])
    assign(paste("g_mod",i, sep = ""),  droplevelsthatworks(eval(parse(text = paste("g_mod",i, sep = "")))))
}

g_mod1

