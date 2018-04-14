#!/usr/bin/R

load("images/isa05-6-05")

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

pdf("results/rob05-6-05.pdf")           #A CHANGER

boxplot(robust_out, names=thresholdzz, main="robust vs thresholds")

for(i in 1:length(isa_out)){
    hist(as.numeric(robust_out[[i]]), main=paste("robustness = ", i, sep=""))
}

dev.off()

save.image("images/rob-05-6-05")        #A CHANGER
