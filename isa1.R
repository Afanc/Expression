#!/usr/bin/R
library(isa2)
library(lattice)
library(topGO)
library(biomaRt)

#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)
#gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")
#gene_id = as.array(gene_id[,1]) #n'est plus utile car gene_id est dans rdata

#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)
#gene_id = read.csv("C:/Users/leoje/Dropbox/uni/semestre 6/math/data/geneID.txt", sep = " ")

#Sys.time()
#modules2 = isa(exp, thr.row = c(0.5, 1, 1.5, 2), thr.col = c(0.5, 1, 1.5, 2))
#Sys.time()
#
#Sys.time() #permet de savoir le temps que prend la fonction pour compiler
#modules = isa(exp)
#Sys.time()
#modules

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

ensembl = useMart("ensembl")
ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl)

infos = getBM(attributes= c("ensembl_gene_id", "external_gene_name","description","interpro_description"), filters="ensembl_gene_id", values=g_mod1, mart=ensembl)

infos


