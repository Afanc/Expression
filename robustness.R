<<<<<<< HEAD
load("C:/Users/leoje/isa1-2-1")
=======
load("images/isa1-2-1")
>>>>>>> ea221517f5e6202f3fb181c51d1c93e4caf46c88

rob = c(1,2) #à reprendre
robust_out = list()

i = 1
for(it in 1:length(isa_out)){
  robu = isa_out[[it]]$seeddata$rob
  robust_out[[i]] = robu
  i = i + 1
}

<<<<<<< HEAD

length(isa_out)
isa_out[[2]]$seeddata$rob

length(robust_out)
hist(as.numeric(robust_out[[1]]))
hist(as.numeric(robust_out[[2]]))
=======
save.image("images/rob-1-2-1")

robust_out[1]
hist(as.numeric(robust_out[[4]]))
>>>>>>> ea221517f5e6202f3fb181c51d1c93e4caf46c88
