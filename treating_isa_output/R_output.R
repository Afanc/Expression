#!/usr/bin/R
load("../images/isa05-6-05")

all_indiv =  matrix(nrow = length(isa_out[[1]]$columns[,1])) #individus
all_genes =  matrix(nrow = length(isa_out[[1]]$rows[,1])) #contient les gènes

for(i in 1:length(isa_out)){
#    current_isa = isa_out[[i]]
#    rob_index = isa_out[[i]]$robustness > 100
#    size_index = colSums(isa_out[[i]]$columns != 0)
#
#    print(size_index)

    all_indiv = cbind(all_indiv,isa_out[[i]]$columns)
    all_genes = cbind(all_genes, isa_out[[i]]$rows)
}

#----------------------- gene names 4 pascal ------------------------

all_names = read.table("../data/geneID.txt", header = F)
all_names = as.array(all_names[,1])

#convertit les genes ID du ficher de Sarvenaz en entreZ 
# créée un data frame all_names 3 qui contient [,1] esng [,2] entrez
library("biomaRt")
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
all_names3 = getBM(attributes = c("ensembl_gene_id", "entrezgene"),
      filters = "ensembl_gene_id",
      values = all_names,
      mart = mart)
head(all_names3)

#la meme fonction qu'avant, prend un module et donne les ENSG
egenenames = function(module){
  column = all_genes[,module]
  more0 = column > 0
  return(droplevels(all_names[more0]))
}

#z gene names, convertit un module de ENSG vers entrez, 
#mais avant teste si les l'equivalent existe dans all_names3.
#problème: tout les modules testés pour l'instant ont des gènes manquants

zgenenames = function(olist){
  bool = olist %in% all_names3[,1]
  outlist = c()
  if(FALSE %in% bool){ print("ERREUR: tout les gene ne sont pas dans la liste")
    print(length(which(!bool)))
    print(olist[which(!bool)])
  }else{
    for(i in 1:length(olist)){
      lequel = which(all_names3[,1] == olist[i])
      outlist[i] = all_names3[lequel,2]
    }
    
  }
  return(outlist)
}


load("../images/grp_unsize_unrob.Rdata") #on a besoin de usize et unrob 
sel_goodmodules = unsize < 500 & unrob > 100


file.create("../export/all_modules.txt", showWarnings = FALSE)

for (i in 1:ncol(all_genes)){
  write(x = c(paste("module", i, sep = "_"), "isa",as.character(genenames(i))),
        sep = "\t", 
        file = "../export/all_modules.txt",
        append = T,
        ncolumns = 19000)
}



file.create("../export/module4pascal.txt", showWarnings = FALSE)

for (i in seq(1:ncol(all_genes))[sel_goodmodules]){
  write(x = c(paste("module", i, sep = "_"), "isa",as.character(genenames(i))),
        sep = "\t", 
        file = "../export/module4pascal.txt",
        append = T,
        ncolumns = 19000)

}


