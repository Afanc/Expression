library(isa2)
data = read.csv("rpkm_small.txt", sep = ",", header = F)
data = as.matrix(data)

vec = c(rep(0, times = 10),
      rep(c(0,0,0,0,1,1,1,0,0,0), times = 3),
      rep(0,times = 60))

mama = matrix(vec, nrow = 10, byrow = T)

isa = isa(mama)

co = isa$columns[,1]

li = isa$rows[,1]
co = as.logical(co)
li = as.logical(li)

selco = c(which(co), which(!co))
selli = c(which(li), which(!li))

mama[c(which(li), which(!li)),c(which(co), which(!co))]

images(list(mama), strip = F)
images(list(mama[selli,selco]), xlab = "", ylab = "", strip = FALSE)

### test mieux...


#
#
#
####data
#eazy = isa(data)
#normie =isa.normalize(data)
#
#co = eazy$columns[,1]
#li = eazy$rows[,1]
#
#co = as.logical(co)
#li = as.logical(li)
#
#selco = c(which(co), which(!co))
#selli = c(which(li), which(!li))
#
#images(list(normie$Er), xlab = "", ylab = "", strip = FALSE)
#
##visualiser les données
#boxplot(data[1:10,1:50])
#boxplot(normie$Ec[sample(1:500, size = 300),1:50])
#boxplot(normie$Ec[1:300,51:100])
#boxplot(normie$Ec[1:300,101:150])
#boxplot(normie$Ec[1:300,151:200])
#boxplot(normie$Ec[1:300,51:100])
#boxplot(normie$Ec[1:300,51:100])
