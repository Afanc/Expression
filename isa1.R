#!/usr/bin/R
library(isa2)
library(lattice)
library(topGO)
library(ALL)
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("ALL")
library(biomaRt)


#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)
#gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")
#gene_id = as.array(gene_id[,1]) #n'est plus utile car gene_id est dans rdata

#exp = read.csv("data/rpkm.csv", sep = ";",header=False)
#exp = as.matrix(exp)
#gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")

#normalisation log des données
epsilon = 0.04
hist(log10(as.vector(as.matrix(exp+epsilon))),100)

log_exp = log10(exp+epsilon)
zscored_exp = scale(log_exp)

#isa
Sys.time()
#modules2 = isa(log10(exp+epsilon), thr.row = c(0.5, 1, 1.5, 2), thr.col = c(0.5, 1, 1.5, 2))
Sys.time()

#Sys.time() #permet de savoir le temps que prend la fonction pour compiler
#modules = isa(exp)
#Sys.time()

#levelplot(as.matrix(modules2))
#images(as.matrix(modules2$rows), strip = FALSE, xlab = "", ylab = "")

#rmod_i contiennent les lignes des modules en binaire
rmod = vector(,length(modules$rows[1,]))
for(i in length(modules$rows[1,])){
    rmod[i] = modules$rows[,i]
    assign(paste("rmod", i, sep = ""), which(rmod1_i != 0))
    assign(paste("g_mod",i, sep = ""), gene_id[i])
    assign(paste("g_mod", i, sep= ""), droplevels(eval(parse(text = paste("g_mod",i,sep= ""))))) #marche pas
}

g_mod1

#cmod_i contiennent les colonnes des modules en binaire
#PAS ENCORE
cmod1_i = modules$rows[,1]
cmod2_i = modules$rows[,2]
cmod3_i = modules$rows[,3]
cmod1 = which(cmod1_i != 0)
#+droplevels

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
ensembl = useMart("ensembl")
ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl)

infos = getBM(attributes= c("ensembl_gene_id", "external_gene_name","description","interpro_description"), filters="ensembl_gene_id", values=g_mod1, mart=ensembl)

infos

# GO, done with Sarvenaz
data(ALL)
data(geneList)
library(topGO)

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
