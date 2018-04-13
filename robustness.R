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

for(i in 1:length(isa_out)){
    summary(robust_out[[i]])
}

pdf("results/rob1-2-1.pdf")

boxplot(robust_out, xlab=thresholdzz)

for(i in 1:length(isa_out)){
    hist(as.numeric(robust_out[[i]]))
}

dev.off()

save.image("images/rob-1-2-1")
