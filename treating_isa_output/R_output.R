#!/usr/bin/R
library(isa2)

#load("C:/Users/leoje/OneDrive/Documents/GitHub/Expression/images/isa05-6-05")

typeof(isa_out[[1]])
length(isa_out)

all_columns =  matrix(nrow = length(isa_out[[1]]$columns[,1]))
all_rows =  matrix(nrow = length(isa_out[[1]]$rows[,1]))

norm_all = isa.normalize(norm_expr)

#length(all_modules[,1])
#length(isa_out[[1]]$columns[,1])

thresholdzz = seq(0.5,6, by = 0.5)

for(i in 1:length(thresholdzz)){
  all_columns = cbind(isa_out[[i]]$columns, all_columns)
  all_rows = cbind(isa_out[[i]]$rows, all_rows)
}

all_modules = list(columns = all_columns, rows = all_rows)

unique_modules = isa.unique(norm_all, all_modules)

names(isa_out[[1]])

all_names = read.table("C:/Users/leoje/OneDrive/Documents/GitHub/Expression/data/geneID.txt", header = F)
load("images/grp_unsize_unrob.Rdata")

all_names = as.array(all_names[,1])

genenames = function(module){
  column = all_columns[,module]
  more0 = column > 0
  return(droplevels(all_names[more0]))
}

length(unrob)
length(unsize)
length(all_columns[1,])
genenames(820)

str(all_columns)
str(unrob)



write(x = c(paste("module", i, sep = "_"), "isa",as.character(genenames(1))),
            sep = "\t", 
            file = "export/module4pascal.txt",
            append = F,
            ncolumns = 19000)


for (i in 1:ncol(all_columns)){
  write(x = c(paste("module", i, sep = "_"), "isa",as.character(genenames(i))),
        sep = "\t", 
        file = "export/all_modules.txt",
        append = T,
        ncolumns = 19000)
}

sel_goodmodules = unsize< 500 & unrob > 100
for (i in seq(1:ncol(all_columns))[sel_goodmodules]){
  write(x = c(paste("module", i, sep = "_"), "isa",as.character(genenames(i))),
        sep = "\t", 
        file = "export/all_modules.txt",
        append = T,
        ncolumns = 19000)
}

