#!/usr/bin/R
library(isa2)
library(lattice)
library(topGO)
<<<<<<< HEAD
library(ALL)
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("ALL")
=======
>>>>>>> ea799e37cb550cfe234d88db6b7e30ffc2d0c869
#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)
#gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")
#gene_id = as.array(gene_id[,1]) #n'est plus utile car gene_id est dans rdata

#exp = read.csv("data/rpkm.csv", sep = ";",header=False)
#exp = as.matrix(exp)
#gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")

<<<<<<< HEAD
epsilon = 0.04
hist(log10(as.vector(as.matrix(exp+epsilon))),100)

log_exp = log10(exp+epsilon)
zscored_exp = scale(log_exp)
Sys.time()
#modules2 = isa(log10(exp+epsilon), thr.row = c(0.5, 1, 1.5, 2), thr.col = c(0.5, 1, 1.5, 2))
Sys.time()

Sys.time() #permet de savoir le temps que prend la fonction pour compiler
=======
>>>>>>> ea799e37cb550cfe234d88db6b7e30ffc2d0c869
#modules = isa(exp)
#modules

#levelplot(as.matrix(modules2))
#images(as.matrix(modules2$rows), strip = FALSE, xlab = "", ylab = "")

#rmod_i contiennent les lignes des modules en binaire

#cmod_i contiennent les colonnes des modules en binaire
#PAS ENCORE
cmod1_i = modules$rows[,1]
cmod2_i = modules$rows[,2]
cmod3_i = modules$rows[,3]
cmod1 = which(cmod1_i != 0)
#+droplevels

<<<<<<< HEAD
rmod2 = which(rmod2_i != 0)
cmod2 = which(cmod2_i != 0)
length(rmod2)
length(cmod2)

rmod3 = which(rmod3_i != 0)
cmod3 = which(cmod3_i != 0)
length(rmod3)
length(cmod3)

#les nom des gènes dans les modules 1, 2 et 3
gene_id = as.array(gene_id[,1])
gene_id[1:5]
#le gènes dans les modules 1, 2 et 3
g_mod1 = gene_id[rmod1]
g_mod2 = gene_id[rmod2]
g_mod3 = gene_id[rmod3]

#droplevels
g_mod1 = droplevels(g_mod1)
g_mod1 = as.array(g_mod1)
typeof(c(1:10))

g_mod1
typeof(g_mod1[1])
g_mod2 = droplevels(g_mod2)
g_mod3 = droplevels(g_mod3)
=======
ensembl = useMart("ensembl")
ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl)

infos = getBM(attributes= c("ensembl_gene_id", "external_gene_name","description","interpro_description"), filters="ensembl_gene_id", values=g_mod1, mart=ensembl)

infos
>>>>>>> ea799e37cb550cfe234d88db6b7e30ffc2d0c869

# GO 
data(ALL)
data(geneList)
library(topGO)

<<<<<<< HEAD
gene_universe = as.vector(modules$rows[,1])
names(gene_universe) = gene_id [2:19902] # remove index in the future
sampleGOdata <- new("topGOdata",
                     description = "Simple session", ontology = "BP",
                     allGenes = geneList, geneSel = function(a) a!=0,
                     nodeSize = 10,
                     annot = annFUN.db, affyLib = affyLib)

resultFisher <- runTest(sampleGOdata, algorithm = "classic", statistic = "fisher")

allRes <- GenTable(sampleGOdata, classicFisher = resultFisher
                   , ranksOf = "classicFisher", topNodes = 10)
=======
>>>>>>> ea799e37cb550cfe234d88db6b7e30ffc2d0c869
