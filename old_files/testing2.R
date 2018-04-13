#!/usr/bin/R
library("isa2")
library('gplots')
library('RColorBrewer')
library('lattice')
library('ComplexHeatmap')


exp = read.csv("rpkm_small.txt", sep=",")
exp = as.matrix(exp)

exp = scale(exp)
exp_before = exp

#m = isa(exp)

#images(list(exp), strip = FALSE, xlab = "", ylab = "")

for(i in length(m$columns[1,])){

    col = as.logical(m$columns[,i])
    ro = as.logical(m$rows[,i])
    exp = exp[c(which(ro), which(!ro)), c(which(col), which(!col))]

    return(exp)
}

#col = as.logical(m$columns[,1])
#ro = as.logical(m$rows[,1])
#exp = exp[c(which(ro), which(!ro)), c(which(col), which(!col))]

#images(list(exp), strip = FALSE, xlab = "", ylab = "", breaks=col_breaks)
#levelplot(exp, col.regions = my_palette)
#heatmap(exp, cellnote=exp, col=my_palette, breaks=col_breaks, xlab="", ylab="", dendrogram='row',trace='none', cellnote='none')

col_breaks = c(seq(-1,5, length=10), seq(5.1,10,length=10), seq(10.1, 15, length=10))

Heatmap(exp, cluster_rows = FALSE, cluster_columns = FALSE)


