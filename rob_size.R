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

pdf("results/test.pdf")           #A CHANGER

robust_out
msize_out
plot(unlist(robust_out), unlist(msize_out), xlab='robustness', ylab='size', main="robust vs size", col=thresholdzz)

for(i in 1:length(isa_out)){
    plot(robust_out[[i]],msize_out[[i]], xlab='robustness', ylab='size', main=paste("threshold = ", thresholdzz[i], sep=""))
}

dev.off()
