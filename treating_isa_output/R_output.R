#!/usr/bin/R
library(isa2)

load("isa05-6-05")
typeof(isa_out[[1]])
length(isa_out)

all_columns =  matrix(,length(isa_out[[1]]$columns[,1]))
all_rows =  matrix(,length(isa_out[[1]]$rows[,1]))

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
