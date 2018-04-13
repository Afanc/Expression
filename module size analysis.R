load("C:/Users/leoje/isa1-2-1")


msize_out = list()


i = 1
for(it in 1:length(isa_out)){
  msize = colSums(isa_out[[it]]$rows != 0)
  msize_out[[i]] = msize
  i = i + 1
}


length(msize_out[[1]])
length(msize_out[[2]])

hist(msize_out[[1]])
hist(msize_out[[2]])
boxplot(msize_out)
