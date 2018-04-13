load("C:/Users/leoje/isa1-2-1")

robust_out = list()

i = 1
for(it in 1:length(isa_out)){
  robu = isa_out[[it]]$seeddata$rob
  robust_out[[i]] = robu
  i = i + 1
}


length(isa_out)
isa_out[[2]]$seeddata$rob

length(robust_out)
hist(as.numeric(robust_out[[1]]))
hist(as.numeric(robust_out[[2]]))
