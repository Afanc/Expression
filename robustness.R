#!/usr/bin/R

load("images/isa1-2-1")

rob = c(1,2) #à reprendre
robust_out = list()

i = 1
for(it in 1:length(isa_out)){
  robu = isa_out[[it]]$seeddata$rob
  robust_out[[i]] = robu
  i = i + 1
}

length(isa_out)
isa_out[[2]]$seeddata$rob

save.image("images/rob-1-2-1")

length(robust_out)
hist(as.numeric(robust_out[[1]]))
hist(as.numeric(robust_out[[2]]))

