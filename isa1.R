library(isa2)
library(lattice)
library(biomaRt)

#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)
#gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")

Sys.time()
#modules2 = isa(exp, thr.row = c(0.5, 1, 1.5, 2), thr.col = c(0.5, 1, 1.5, 2))
Sys.time()

modules2

Sys.time() #permet de savoir le temps que prend la fonction pour compiler
#modules = isa(exp)
Sys.time()
#modules

#levelplot(as.matrix(modules2))
#images(as.matrix(modules2$rows), strip = FALSE, xlab = "", ylab = "")

rmod1_i = modules$rows[,1]
rmod2_i = modules$rows[,2]
rmod3_i = modules$rows[,3]

cmod1_i = modules$rows[,1]
cmod2_i = modules$rows[,2]
cmod3_i = modules$rows[,3]

rmod1 = which(rmod1_i != 0)
cmod1 = which(cmod1_i != 0)
length(rmod1)
length(rmod1)

rmod2 = which(rmod2_i != 0)
cmod2 = which(cmod2_i != 0)
length(rmod2)
length(cmod2)

rmod3 = which(rmod3_i != 0)
cmod3 = which(cmod3_i != 0)
length(rmod3)
length(cmod3)

#gene_id = as.array(gene_id[,1])
gene_id[1:5]
#le gènes dans les modules 1, 2 et 3
g_mod1 = gene_id[rmod1]
g_mod1
g_mod2 = gene_id[rmod2]
g_mod3 = gene_id[rmod3]

ensembl=useMart("ensembl")
ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl)

infos = getBM(attributes= c("ensembl_gene_id", "external_gene_name","description","interpro_description"), filters="ensembl_gene_id", values=g_mod1, mart=ensembl)

infos



