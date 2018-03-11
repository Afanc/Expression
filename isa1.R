#library(isa2)
#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)
head(exp[,1:10])
data3 = isa(exp[1:100])
Sys.time()

Sys.time() #pour savoir le temps que prend la fonction
datai2 = isa(exp, thr.row = c(4, 5, 6), thr.col = c(4,5,6), no.seeds = 200)
Sys.time()