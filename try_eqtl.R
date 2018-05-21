#!/usr/bin/R
############################################################################################################
############################################################################################################
#### obtenir modules ####
    

eQTL_list <- read.table("./colaus_FDR_005_cis_eQTL.txt", header = T); names(eQTL_list)
eQTL_list[1:5,]


filelist <- list.files(path = "corrected_pascal_output", pattern = "module4pascal--sum")
## assuming tab separated values with a header
datalist = lapply(paste("corrected_pascal_output/",filelist, sep = ""), function(x)read.table(x, header=T)) 


merged = datalist[[1]]
for(i in 2:length(datalist)){
  merged = merge(merged, datalist[i], by = "Name")
}

colquinousinteressePAS = seq(2, 35, by = 2)
pval = as.matrix(merged)
pval <- pval[,-colquinousinteressePAS]
pval[1:5,]

chisq = as.matrix(merged[,seq(2, 34, by = 2)])
sorted_chi = sort(as.vector(chisq),decreasing = F)

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
    #load("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/isa/.RData")
    load("images/isa05-6-05")

all_names_ensg = read.table("data/geneID.txt", header = F)
all_names_ensg = as.array(all_names_ensg[,1])

## issu de R_output2 :
all_genes =  matrix(nrow = length(isa_out[[1]]$rows[,1])) #vide, contiendra les gènes

for(i in 1:length(isa_out)){
  all_genes = cbind(all_genes, isa_out[[i]]$rows)
}
dim(all_genes)
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

eQTL_output <- matrix(NA, nrow = 200000, ncol = 600)
## builds an output for one module
add_snpToGeneID <- function(mod) {
  
  modgene_id <- genenames_ensg(mod)
  snps <- c()
  
  for(i in 1:modgene_id) {
    for(j in 1:length(eQTL_list$snp_rs)) {
      if(modgene_id[i] == eQTL_list$gene_id[j]) {
        snps <- eQTL_list$snp_rs[eQTL_list$gene_id==modgene_id[i]] ## vecteur de snp_rs
        
        ## there will be an error with the dimensions if the rows are not all of the same length
        ## a solution is to add NAs to the empty cells.
        
        semicomplete <- append(modgene_id[i], snps) # the row that is not complete (yet)
        n <- length(semicomplete)
        t <- ncol(eQTL_output) - n # number times to add NAs
        complete <- c(semicomplete, rep(NA, times=t)) # a complete row to replace in the matrix
        eQTL_output[i] <- complete # there should be no error linked to the dimensions
        
      }}}
  
  write(eQTL_output, file = "eQTL_output.txt", ncolumns = ncol(eQTL_output))
  file.create("./eqtl/eQTL_output.txt", showWarnings = FALSE)
  return(eQTL_output)
}
                 
add_snpToGeneID(692) ## le file est bien créé, mais est vide .....
                  
   #### essai pour 1 seul gene               
eQTL_output <- c()
add_snpToGeneID <- function(mod) {
  
  modgene_id <- genenames_ensg(mod) ## taille de 5477 gènes
  oneID <- modgene_id[1] ## changer d'indice si on veut un autre gène
  snps <- c()
  
  
  for(j in 1:length(eQTL_list$snp_rs[eQTL_list$gene_id==oneID])) {
    snps <- eQTL_list$snp_rs[eQTL_list$gene_id==oneID] ## vecteur de snp_rs
    
    ## there will be an error with the dimensions if the rows are not all of the same length
    ## a solution is to add NAs to the empty cells.
    
    semicomplete <- append(oneID, snps) # the row that is not complete
    n <- length(semicomplete)
    t <- ncol(eQTL_output) - n # number times to add NAs
    
    complete <- c(semicomplete, rep(NA, times=t)) # a complete row to replace in the matrix
    eQTL_output <- complete # there should be no error linked to the dimensions
    }
  write(eQTL_output, file = "eQTL_output.txt", ncolumns = ncol(eQTL_output))
  file.create("./eqtl/eQTL_output.txt", showWarnings = FALSE)
  return(eQTL_output)
}

