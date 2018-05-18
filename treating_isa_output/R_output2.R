#!/usr/bin/R
library(isa2)

load("../images/isa05-6-05")

all_indiv =  matrix(nrow = length(isa_out[[1]]$columns[,1])) #individus
all_genes =  matrix(nrow = length(isa_out[[1]]$rows[,1])) #contient les gènes

for(i in 1:length(isa_out)){
  all_indiv = cbind(all_indiv,isa_out[[i]]$columns)
  all_genes = cbind(all_genes, isa_out[[i]]$rows)
}

all_indiv = all_indiv[,2:length(all_indiv[1,])]
all_genes = all_genes[,2:length(all_genes[1,])]

all_names = read.table("./entrez_ids_2.txt", header = F)
all_names = as.array(all_names[,1])

load("../images/grp_unsize_unrob.Rdata")

genenames = function(module){
    column = all_genes[,module]
    more0 = column > 0
    names = all_names[more0]
    names = names[-which(is.na(names))]

    return(names)
}

#str(all_genes) # Compactly Display the Structure of an Arbitrary R Object
#str(unrob)

#file.create("../export/all_modules_d.txt", showWarnings = FALSE)

#for (i in 1:ncol(all_genes)){
#  write(x = c(paste("module", i, sep = "_"), "isa", as.character(genenames(i))),
#        sep = "\t", 
#        file = "../export/all_modules_d.txt",
#        append = T,
#        ncolumns = 19000)
#}
#
sel_goodmodules = unsize < 1000 & unrob > 50

#str(unsize)
#unsize[sel_goodmodules]
#unsize[sel_goodmodules][1]
#sel_goodmodules
for (i in seq(0:ncol(all_genes))[sel_goodmodules]){
    print(paste("module : ", i, ", size : ", unsize[i], sep= ""))
}

#genenames = function(module){
#  column = all_genes[,module]
#  more0 = column > 0
#  print(module[more0])
#}

file.create("../export/module4pascal_dtest.txt", showWarnings = FALSE)

for (i in seq(0:ncol(all_genes))[sel_goodmodules]){
    write(x = c(paste("module", i, sep = "_"), "isa", as.character(genenames(i))),
        sep = "\t", 
        file = "../export/module4pascal_dtest.txt",
        append = T,
        ncolumns = 19000)
}

