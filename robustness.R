load("images/isa1-2-1")

rob = c(1,2) #à reprendre
robust_out = list()

for(it in isa_out){
  rob = it$seeddata[6]
  robust_out[[i]] = rob
  i = i + 1
}

save.image("images/rob-1-2-1")

