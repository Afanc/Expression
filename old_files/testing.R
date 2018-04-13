#!/usr/bin/R
library('isa2')

raw_data <- read.table("rpkm_small.txt", sep=",", header=FALSE)

head(raw_data[1,])

test <- na.omit(raw_data[,1:100])
test
#png('test1.png')
boxplot(t(test))

scaled_test = scale(test)
scaled_test

png('test2.png')
hist(scaled_test)

loged = log(scaled_test)

png('test3.png')
hist(loged)

#data <- isa.in.silico(10, 10, 2)
#normed.data <- isa.normalize(data[[1]])
#row.seeds <- generate.seeds(length = nrow(data[[1]]), count = 10)#, sparsity = c(2, 5, 10, 100))
#modules <- isa.iterate(normed.data, row.seeds = row.seeds, thr.row = 2, thr.col = 2, direction = "up")
#
#data
#normed.data
#row.seeds
#modules

#data <- isa.in.silico(10, 10, 2, 3,3 )[[1]]
#images(list(data), xlab = "", ylab = "", strip = FALSE)

