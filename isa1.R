#!/usr/bin/R
library(isa2)
library(lattice)
library(topGO)
#library(ALL)
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
#biocLite("ALL")
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

#cmod_i contiennent les colonnes des modules en binaire
#PAS ENCORE
#cmod1_i = modules$rows[,1]
#cmod2_i = modules$rows[,2]
#cmod3_i = modules$rows[,3]

#les nom des gènes dans les modules 1, 2 et 3
#le gènes dans les modules 1, 2 et 3
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
