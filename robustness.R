#!/usr/bin/R

load("images/isa1-2-1")

thresh = thresholdzz
robust_out = list()

i = 1
for(it in 1:length(isa_out)){
  robu = isa_out[[it]]$seeddata$rob
  robust_out[[i]] = robu
  i = i + 1
}

#length(isa_out)
#isa_out[[2]]$seeddata$rob

<<<<<<< HEAD
summary(robust_out[[1]])
summary(robust_out[[2]])
boxplot(robust_out)

save.image("images/rob-1-2-1")
=======
for(i in 1:length(isa_out)){
    summary(robust_out[[i]])
}
>>>>>>> cfd6f98b26d5ec77834c54f171f9e35841be6cde

pdf("results/rob1-2-1.pdf")

boxplot(robust_out, xlab=thresholdzz)

for(i in 1:length(isa_out)){
    hist(as.numeric(robust_out[[i]]))
}

dev.off()

save.image("images/rob-1-2-1")
