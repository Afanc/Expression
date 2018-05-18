#!/usr/bin/R

filelist = list.files(pattern = ".*.txt")

#assuming tab separated values with a header    
datalist = lapply(filelist, function(x)read.table(x, header=T)) 

arglist = list()
arglist[[1]] = "Name"
names(arglist) = c("by")

length(datalist)
merged = datalist[[1]]
i = 2
for(i in 2:10){
  merged = merge(merged, datalist[i], by = "Name")

}
mergenames = c("Names", paste(rep(substr(filelist[1:10],start = 5, stop = 25),each = 2), rep(c("chisq", "pval"), times = 10)))
names(merged) = mergenames
head(merged)


pval = as.matrix(merged[,seq(1, 21, by = 2)])

alpha = 0.05/(61)

which(as.vector(pval[,2:11]) < alpha)

#tentative de FDR

sorted = sort(as.vector(pval[,2:11]), decreasing = F)

head(sorted)

for(i in 1:length(sorted)){
  if(sorted[i] > (i/length(sorted))* 0.05){
    return(paste("result", i-1))
    break()
  }
}

