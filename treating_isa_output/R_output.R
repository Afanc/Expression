#!/usr/bin/R
library(isa2)

load("../images/isa05-6-05")

typeof(isa_out[[1]])
length(isa_out)

all_columns =  matrix(nrow = length(isa_out[[1]]$columns[,1]))
all_rows =  matrix(nrow = length(isa_out[[1]]$rows[,1]))

norm_all = isa.normalize(norm_expr)

#length(all_modules[,1])
#length(isa_out[[1]]$columns[,1])

for(i in 1:length(isa_out)){
    current_isa = isa_out[[i]]
    rob_index = isa_out[[i]]$robustness > 100
    size_index = colSums(isa_out[[i]]$columns != 0)

    print(rob_index)
    print(size_index)

#    for(j in 1:length(current_isa$columns)){
#        if (current_isa$seeddata$rob > 100 & colSums(current_isa$rows != 0) < 1000) {
#            all_columns = cbind(isa_out[[i]]$columns[,j], all_columns)
#        }
#    }



    #all_columns = cbind(isa_out[[i]]$columns, all_columns)
    #all_rows = cbind(isa_out[[i]]$rows, all_rows)
}

all_columns
#all_modules = list(columns = all_columns, rows = all_rows)

#unique_modules = isa.unique(norm_all, all_modules)

names(isa_out[[1]])

all_names = read.table("C:/Users/leoje/OneDrive/Documents/GitHub/Expression/data/geneID.txt", header = F)
all_names = as.array(all_names[,1])

genenames = function(module){
  column = all_columns[,module]
  more0 = column > 0
  return(droplevels(all_names[more0]))
}

genenames(1)
