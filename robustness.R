#load("C:/Users/leoje/isa1-2-1")

robust_out = list()

isa_out[[1]]$seeddata$rob

i = 1
for(it in isa_out){
  robu = it$seeddata$rob
  robust_out[[i]] = robu
  i = i + 1
}

robust_out[1]
hist(as.numeric(robust_out[[4]]))
