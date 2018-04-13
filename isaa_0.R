#!/usr/bin/R
library(isa2)
library(lattice)
library(topGO)
source("https://bioconductor.org/biocLite.R")
library(biomaRt)


exp = read.csv("data/rpkm.txt", sep = ",")
exp = as.matrix(exp)

epsilon = 0.04

log_exp = log10(exp+epsilon)
norm_expr = scale(log_exp)

#pdf("log_expression.pdf")
#hist(log10(as.vector(as.matrix(exp+epsilon))),100)


print("let's goooo\n")
Sys.time()
isa_out = list()
i = 1
rob = c(1,2)
for(threshold in rob){
    m = isa(norm_expr, threshold)
    isa_out[[i]] = m
    i = i + 1
    print(paste("itération ",i, " terminée\n", sep=""))
    print(Sys.time())
}

save.image("images/isa1-2-1")


#droplevelsthatworks = function(x){
    #return(droplevels(x))
#}

#rmod = vector(,length(modules$rows[1,]))
#for(i in length(modules$rows[1,])){
#    rmod[i] = modules$rows[,i]
#    #très moche, pas faire ça
#    assign(paste("rmod", i, sep = ""), which(rmod1_i != 0))
#    assign(paste("g_mod",i, sep = ""), gene_id[i])
#    assign(paste("g_mod",i, sep = ""),  droplevelsthatworks(eval(parse(text = paste("g_mod",i, sep = "")))))
#}
#
#g_mod1
#
