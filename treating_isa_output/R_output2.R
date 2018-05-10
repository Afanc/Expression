#!/usr/bin/R
library(isa2)

load("../images/isa05-6-05")

typeof(isa_out[[1]])
length(isa_out)

isat = isa_out[[1]]
isat

all_indiv =  matrix(nrow = length(isa_out[[1]]$columns[,1])) #individus
all_genes =  matrix(nrow = length(isa_out[[1]]$rows[,1])) #contient les gènes

norm_all = isa.normalize(norm_expr)

head(all_genes)
head(all_indiv)


#length(all_modules[,1])
#length(isa_out[[1]]$columns[,1])

for(i in 1:length(isa_out)){
  #    current_isa = isa_out[[i]]
  #    rob_index = isa_out[[i]]$robustness > 100
  #    size_index = colSums(isa_out[[i]]$columns != 0)
  #
  #    print(size_index)
  
  all_indiv = cbind(all_indiv,isa_out[[i]]$columns)
  all_genes = cbind(all_genes, isa_out[[i]]$rows)
}

all_indiv = all_indiv[,2:length(all_indiv[1,])]
all_genes = all_genes[,2:length(all_genes[1,])]

dim(all_genes)
head(all_genes)

all_indiv
#all_modules = list(columns = all_indiv, rows = all_genes)

#unique_modules = isa.unique(norm_all, all_modules)

names(isa_out[[1]])

all_names = read.table("./entrez_ids_2.txt", header = F)
all_names = as.array(all_names[,1])

load("../images/grp_unsize_unrob.Rdata")

genenames = function(module){
  column = all_genes[,module]
  more0 = column > 0
  return(all_names[more0])
}

length(unrob)
length(unsize)
length(all_genes[1,])

str(all_genes) # Compactly Display the Structure of an Arbitrary R Object
str(unrob)


file.create("../export/all_modules_d.txt", showWarnings = FALSE)

for (i in 1:ncol(all_genes)){
  write(x = c(paste("module", i, sep = "_"), "isa",as.character(genenames(i))),
        sep = "\t", 
        file = "../export/all_modules_d.txt",
        append = T,
        ncolumns = 19000)
}


sel_goodmodules = unsize < 500 & unrob > 100
file.create("../export/module4pascal_d.txt", showWarnings = FALSE)

for (i in seq(1:ncol(all_genes))[sel_goodmodules]){
  write(x = c(paste("module", i, sep = "_"), "isa",as.character(genenames(i))),
        sep = "\t", 
        file = "../export/module4pascal_d.txt",
        append = T,
        ncolumns = 19000)
  
}

m_quelconque = all_genes[,sel_goodmodules]

length(which(sel_goodmodules))
