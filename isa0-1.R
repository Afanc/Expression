library(isa2)

exp = read.csv("data/rpkm.txt", sep = ",")
exp = as.matrix(exp)

epsilon = 0.04

log_exp = log10(exp+epsilon)
norm_expr = scale(log_exp)

thresholdzz = seq(0,1, by = 0.1)

print("let's goooo\n")
print(Sys.time())
isa_out = list()
i = 1

for(threshold in thresholdzz){
  m = isa(norm_expr, threshold)
  isa_out[[i]] = m

  print(paste("itération ",i, " terminée\n", sep=""))
  print(Sys.time())

  i = i + 1
}

save.image("images/isa0-1-01")         #A CHANGER


