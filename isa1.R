library(isa2)
library(lattice)

#exp = read.csv("data/rpkm.csv", sep = ";")
#exp = as.matrix(exp)


Sys.time()
#modules2 = isa(exp, thr.row = c(0.5, 1, 1.5, 2), thr.col = c(0.5, 1, 1.5, 2))
Sys.time()

modules2

Sys.time() #permet de savoir le temps que prend la fonction pour compiler
#modules = isa(exp)
Sys.time()
#modules

#levelplot(as.matrix(modules2))
images(as.matrix(modules2$rows), strip = FALSE, xlab = "", ylab = "")

