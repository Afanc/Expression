library(isa2)

print("let's goooo\n")
print(Sys.time())
isa_out = list()
i = 1
for(threshold in seq(0.5,6, by = 0.5)){
  m = isa(norm_expr, threshold)
  isa_out[[i]] = m
  print(paste("itération ",i, " terminée\n", sep=""))
  print(Sys.time())
  i = i + 1
}

save.image("images/isa05-6-05")


