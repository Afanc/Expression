############################################################################################################
############################################################################################################
#### obtenir modules ####
    

eQTL_list <- read.table("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/eqtl/colaus_FDR_005_cis_eQTL.txt", header = T); names(eQTL_list)
eQTL_list[1:5,]




filelist <- list.files(path = "/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/Pascal/output/outputrealshit")
## assuming tab separated values with a header
datalist = lapply(filelist, function(x)read.table(x, header=T)) 




merged = datalist[[1]]
for(i in 2:length(datalist)){
  merged = merge(merged, datalist[i], by = "Name")
}

colquinousinteressePAS = seq(2, 35, by = 2)
pval = as.matrix(merged)
pval <- pval[,-colquinousinteressePAS]
pval[1:5,]

sorted = sort(as.vector(pval[,2:11]), decreasing = F) ### View(sorted)

#trouver les noms des 10 modules les plus significatifs pour Cynthia
#au lieu de print(), mettre un vecteur
vec_modules = c()
for(i in 1:10){#changer ici pour plus de modules significatifs
  a = which(as.vector(pval[,2:ncol(pval)]) == sorted[i])
  col = floor(a / 61) + 2 #r magic <3 ||| n°col=pathway
  mod = a - ((col-2) * 61)
  print(pval[mod,1]) # retourne ID des modules, qu'il faut cross-eQTL
  vec_modules <- append(vec_modules, pval[mod,1])
}



############################################################################################################
############################################################################################################
#### obtenir gene IDs de chaque module ####
    ## isa_out
    load("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/isa/.RData")
    load("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/isa/isa05-6-05")

## issu de R_output2 :
all_genes =  matrix(nrow = length(isa_out[[1]]$rows[,1])) #vide, contiendra les gènes
all_names_ensg = read.table("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/geneID.txt", header = F)
all_names_ensg = as.array(all_names_ensg[,1])

for(i in 1:length(isa_out)){
  all_genes = cbind(all_genes, isa_out[[i]]$rows)
}
all_genes = all_genes[,2:length(all_genes[1,])]

genenames_ensg = function(module){
  column = all_genes[,module]
  more0 = column > 0
  names = all_names_ensg[more0]
  return(droplevels(names))
}
genenames_ensg(1) ## === gene IDs du module 1, go check pour vec_module[1]



############################################################################################################
############################################################################################################
#### croiser chaque module avec eQTL_list ####

eQTL_output <- matrix(NA, nrow = 200000, ncol = 200)

## builds an output for one module
add_snpToGeneID <- function(mod) {
  
  modgene_id <- genenames_ensg(mod)
  snps <- c()
  
  for(i in 1:modgene_id) {
    for(j in 1:length(eQTL_list$snp_rs)) {
      if(modgene_id[i] == eQTL_list$gene_id[j]) {
        snps <- eQTL_list$snp_rs[eQTL_list$gene_id==modgene_id[i]] ## vecteur de snprs
        
        ## there will be an error with the dimensions if the rows are not all of the same length
        ## a solution is to add NAs to the empty cells.
        
        semicomplete <- append(modgene_id[i], snps) # the row that is not complete (yet)
        n <- length(semicomplete)
        t <- ncol(eQTL_output) - n # number times to add NAs
        complete <- c(semicomplete, rep(NA, times=t)) # a complete row to replace in the matrix
        eQTL_output[i] <- complete # there should be no error linked to the dimensions
      }}}
  
  
  file.create("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/eqtl/snp_id.txt", showWarnings = FALSE)
  return(eQTL_output)
}
                 
add_snpToGeneID(1) ## le file est bien créé, mais est vide .....
