#!/usr/bin/R

load("images/isa05-6-05")

robust_out = list()
msize_out = list()

i = 1
for(it in 1:length(isa_out)){
  robu = isa_out[[it]]$seeddata$rob
  robust_out[[i]] = robu

  msize = colSums(isa_out[[it]]$rows != 0)
  msize_out[[i]] = msize

  i = i + 1
}

normed_rob = list()
for(i in 1:length(robust_out)){
    normed_rob[[i]] = robust_out[[i]]/msize_out[[i]]
}

pdf("results/normed_rob05-6-05.pdf")           #A CHANGER

boxplot(normed_rob, names=thresholdzz, main="normed robust vs thresholds")

for(i in 1:length(isa_out)){
    hist(as.numeric(robust_out[[i]]/msize_out[[i]]), main=paste("normed robustness = ", thresholdzz[i], sep=""))
}

dev.off()

save.image("images/normed_rob-05-6-05")        #A CHANGER
