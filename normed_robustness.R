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

pdf("results/rob_size2.pdf")

unsize = unlist(msize_out) #Rmagic <3
unrob = unlist(robust_out)

grp = c()
x = 1
for(i in seq(0.5,4, 0.25)){
  grp = append(grp, rep(i, times = length(msize_out[[x]]))) #rep the treshold, times = len of module
  x = x + 1
}

plot(unsize, unrob, col = rainbow(15)[as.factor(grp)],
     main = "Size vs robustness of modules between thresholds",
     xlab = "Size",
     ylab = "Robustness",
     xlim = c(0, 8000)) #so faboulous 
legend(x ="topright", legend = unique(grp), fill = rainbow(15), cex = 0.7)

sel = unsize< 500 & unrob > 100
which(sel)
plot(unsize[sel], unrob[sel])

dev.off()

save.image("images/normed_rob-05-6-05")        #A CHANGER


save(list = c("grp", "unsize", "unrob"), file = "images/grp_unsize_unrob.Rdata")
