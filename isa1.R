#library(isa2)
#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)
gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")

Sys.time()
modules2 = isa(exp, thr.row = c(0.5, 1, 1.5, 2), thr.col = c(0.5, 1, 1.5, 2))
Sys.time()

Sys.time() #permet de savoir le temps que prend la fonction pour compiler
modules = isa(exp)
Sys.time()

rmod1 = which(rmod1 != 0)
cmod1 = which(cmod1 != 0)
length(which(rmod1 != 0))
length(which(cmod1 != 0))

rmod2 = which(rmod2 != 0)
cmod2 = which(cmod2 != 0)
length(which(rmod2 != 0))
length(which(cmod2 != 0))

rmod3 = which(rmod3 != 0)
cmod3 = which(cmod3 != 0)
length(which(rmod3 != 0))
length(which(cmod3 != 0))

gene_id = as.array(gene_id[,1])
gene_id[1:5]
#le gènes dans les modules 1, 2 et 3
g_mod1 = gene_id[rmod1]

g_mod2 = gene_id[rmod2]

g_mod3 = gene_id[rmod3]
