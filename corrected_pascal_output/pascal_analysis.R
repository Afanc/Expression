#!/usr/bin/R

filelist = list.files(pattern = ".module4pascal--sum.txt")

#assuming tab separated values with a header    
datalist = lapply(filelist, function(x)read.table(x, header=T)) 


length(datalist)
merged = datalist[[1]]
for(i in 2:length(datalist)){
  merged = merge(merged, datalist[i], by = "Name")
}

mergenames = c("Names", paste(rep(substr(filelist[1:length(filelist)],start = 5, stop = 25),each = 2), rep(c("chisq", "pval"), times = 10)))
names(merged) = mergenames
head(merged)


pval = as.matrix(merged[,seq(1, 35, by = 2)])

head(pval)
head(as.vector(pval[,2:18]))

alpha = 0.05/(61)

sorted = sort(as.vector(pval[,2:11]), decreasing = F)

#trouver le nom des 10 modules les plus significatifs pour Cynthia
for(i in 1:10){#changer ici pour plus
    a = which(as.vector(pval[,2:ncol(pval)]) == sorted[i])
    print(a)
    col = floor(a / 61) + 2 #r magic <3
    mod = a - ((col-2) * 61)
    print(pval[mod,1])
}

#tentative de FDR

sorted = sorted*61
head(sorted)

for(i in 1:length(sorted)){
  if(sorted[i] < (i/length(sorted))* 0.05){
    print(paste("result", i-1))
    #break()
  }
}

