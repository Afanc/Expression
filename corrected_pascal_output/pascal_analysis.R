#!/usr/bin/R

filelist = list.files(pattern = "module4pascal--sum.txt")

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
chisq = as.matrix(merged[,c(1,seq(2, 34, by = 2))])
sorted_chi = sort(as.vector(chisq),decreasing = F)
sorted_chi5 = sort(as.vector(chisq[,5]),decreasing = F)

i = 1
for(i in 1:10){#changer ici pour plus
  a = which(as.numeric(chisq[,2:ncol(chisq)]) == sorted_chi7[i])
  col = ceiling(a / 61) #r magic <3
  mod = a - ((col-1) * 61)
  print(as.character(pval[mod,1]))
}

min(sorted_chi)

head(pval)
head(as.vector(pval[,2:18]))

alpha = 0.05/(61)

sorted = sort(as.vector(pval[,2:11]), decreasing = F)
sorted = as.numeric(sorted)
min(sorted) < 0.05/61


#trouver le nom des 10 modules les plus significatifs pour Cynthia
for(i in 1:10){#changer ici pour plus
    a = which(as.vector(pval[,2:ncol(pval)]) == sorted[i])
    print(a)
    col = floor(a / 61) + 2 #r magic <3
    mod = a - ((col-2) * 61)
    print(pval[mod,1])
}

#tentative de FDR

sorted = as.numeric(sorted)
head(sorted_chi * 61)

for(i in 1:length(sorted)){
  if(sorted[i] < (i/length(sorted))* 0.05){
    print(paste("result", i-1))
    #break()
  }
}
i = 1
j = 5

sig = c()
for(j in 1:ncol(chisq)){
  col = chisq[,j]
  sor = sort(col, decreasing = F)
  for(i in 1:length(sor)){
    seuil = i/length(sor) * 0.05
    if(sor[i] <= i/length(sor) * 0.05){
      print("yey")
      print(paste("col : ", j))
      print(paste("mod  ", merged[,1][which(col == sor[i])]))
      print(paste(sor[i], "vs", seuil))
    }
  }
}

print(paste("mod  ", merged[,1][which(chisq[,5] == sort(chisq[,5])[5])]))

for(i in 1:length(sorted_chi)){
  if(sorted_chi[i] < (i/length(sorted_chi))* 0.05){
    print(paste("result", i-1))
    break()
  }
}

library(qvalue)

q = qvalue(chisq[,5])
head(sort(q$qvalues))


hist(chisq[,5])
qqnorm(chisq[,4])
qqline(chisq[,4])

qqnorm(-log(as.array(chisq)))
qqline(-log(as.array(chisq)))

plot(sort(-log(1:length(as.array(chisq)/length(as.array(chisq))))), -log(tail(sort(as.array(chisq), decreasing = T))))
plot(sort(-log(1:length(as.array(chisq))/length(as.array(chisq)))),
     -log(sort(as.array(chisq),decreasing = T))
     ,main = "QQplot PASCAL"
     ,xlab = "Expected -log(p)"
     ,ylab = "Observed -log(p)")
abline(a = 0, b= 1)

plot(sort(-log(1:length(as.array(chisq[,5]))/length(as.array(chisq[,5])))),
     -log(sort(as.array(chisq[,5]),decreasing = T))
     ,main = "QQplot PASCAL\nCoronary artery disease"
     ,xlab = "Expected -log(p)"
     ,ylab = "Observed -log(p)")
abline(a = 0, b= 1)






