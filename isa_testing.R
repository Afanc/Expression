library("isa2")
library("gplots")
library("RColorBrewer")

#### example 1 ##########################################
set.seed(1)
lamb <- isa.in.silico(num.rows = 100, num.cols = 100); lamb
normed.lamb <- isa.normalize(lamb[[1]]); normed.lamb ## gives the 2 matrices Ec & Er

row.seeds <- generate.seeds(length=nrow(lamb[[1]]), count=100)
isaresult <- isa.iterate(normed.lamb, thr.row=1, thr.col=1,
                         row.seeds=row.seeds); isaresult

isa.unique(normed.lamb, isaresult) ## merge similar modules

## draw heatmaps for both matrices
heatmap(as.matrix(normed.lamb$Er), col=brewer.pal(9, "Blues"))
heatmap(as.matrix(normed.lamb$Ec), col=brewer.pal(9, "Blues"))


#### example 2 (foireux) #################################
random.matrix <- isa.in.silico(num.rows=3, num.cols=3); random.matrix

normed.random <- isa.normalize(random.matrix[[1]]); normed.random ## gives the 2 matrices Ec & Er

row.seeds2 <- generate.seeds(length=nrow(random.matrix[[1]]), count=10)
isaresult2 <- isa.iterate(normed.random, thr.row=1, thr.col=1,
                         row.seeds=row.seeds2); isaresult2

isa.unique(normed.random, isaresult2) ## merge similar modules

#images(random.matrix, isaresult2) ## ne fct pas
