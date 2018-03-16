#!/usr/bin/R
library('isa2')

raw_data <- read.table("rpkm_small.txt", sep=",", header=FALSE)

head(raw_data[1,])

test <- na.omit(raw_data[,1:100])
test
boxplot(t(test))

scaled_test = scale(test)
scaled_test

png('test2.png')
hist(scaled_test)

loged = log(scaled_test)

png('test3.png')
hist(loged)

