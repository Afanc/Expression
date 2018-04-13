load("images/hello.Rdata")

isa_out = vector(mode = "list")
i = 1
for(threshold in seq(1,2)){
  isa_out[[i]] = paste("t_", threshold, sep = "")
  assign(paste("t_", threshold, sep = ""),seq(1:10))
  i = i + 1
}

isa_out[[1]]

robust_out = list()

i = 1

for(it in isa_out){
  rob = it$seeddata[6]
  robust_out[[i]] = rob
  i = i + 1
}


test = vector(mode = "list", length = 3)

for( i in 1:3){ 
  test[[i]] = paste("l", i, sep = "_")
  assign(paste("l", i, sep = "_"), 1:10)
  }

for(i in test){
  print(i)
}
