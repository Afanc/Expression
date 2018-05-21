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

merged

pval = as.matrix(merged[,seq(1, 35, by = 2)])
chisq = as.matrix(merged[,seq(2, 34, by = 2)])

sorted = sort(as.vector(pval[,2:11]), decreasing = F)
sorted_chisq = sort(as.vector(chisq[,2:11]), decreasing = F)

sorted = as.numeric(sorted)
sorted_chisq = as.numeric(sorted_chisq)

correction_factor = 61

head(sorted*correction_factor)
head(sorted_chisq*correction_factor)

pval[,2:ncol(pval)]
chisq[,2:ncol(chisq)]

for(i in 1:10){
    a = which(as.vector(chisq[,2:ncol(chisq)]) == sorted_chisq[i])
    col = floor(a / correction_factor) + 2 #r magic <3
    mod = a - ((col-2) * correction_factor)
    print(chisq[mod,1])
}

#le nom des modules
for(i in 1:10){
    a = which(as.vector(pval[,2:ncol(pval)]) == sorted[i])
    col = floor(a / correction_factor) + 2 #r magic <3
    mod = a - ((col-2) * correction_factor)
    print(pval[mod,1])
}
