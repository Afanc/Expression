#!/usr/bin/R
load("images/isa05-6-05")

msize_out = list()

i = 1
for(it in 1:length(isa_out)){
  msize = colSums(isa_out[[it]]$rows != 0)
  msize_out[[i]] = msize
  i = i + 1
}

pdf("results/size-05-6-05.pdf")

for(i in 1:length(msize_out)){
    hist(msize_out[[i]])
}

boxplot(msize_out)

dev.off()

save.image("images/size-05-6-05")
