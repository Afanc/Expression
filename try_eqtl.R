############################################################################################################
############################################################################################################
#### obtenir modules ####

    ##    obtenir RData de pascal avec les "... module4pascal_d--sum.txt" ----------> done.
    

eQTL_list <- read.table("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/eqtl/colaus_FDR_005_cis_eQTL.txt", header = T); names(eQTL_list)
eQTL_list[1:5,]


##essai 0.0 THE ONE THAT I'M USING
filelist <- list.files(path = "/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/Pascal/output/outputrealshit")
##essai 1 --> junk (empty)
junk <- dir(path = "/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/Pascal/output", 
            pattern = ".module4pascal_d--sum.txt") ## impossible de faire pattern != "module4pascal_d--sum.txt"
filelist <- file.remove(junk)
##essai 2 --> filelist (empty)
getwd()
filelist = list.files(pattern = ".module4pascal_d--sum.txt")
##essai 3 --> filelist2 is okay, but filelist is empty
filelist2 = list.files(path = "/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/Pascal/output")
filelist <- lapply(filelist2, function(x)list.files(pattern = ".module4pascal_d--sum.txt"))
##essai pourrave
#filelist = list.files(c("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/eqtl/EUR.ASN.C4D_CAD_discovery_metaanalysis_update.CAD.PathwaySet--module4pascal_d--sum.txt",
    #                        "/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/eqtl/EUR.ASN.CARDIoGRAMplusC4D_data_stage2.CAD.PathwaySet--module4pascal_d--sum.txt",
    #                        "/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/eqtl/EUR.CARDIoGRAM_2010_lipids.LDL_ONE.PathwaySet--module4pascal_d--sum.txt"))
##essai 4 entrer à la main LOL
    dat1 <- read.table("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/Pascal/corrected_pascal_output/EUR.ASN.C4D_CAD_discovery_metaanalysis_update.CAD.PathwaySet--module4pascal--sum.txt", header=T)
    dat2 <- read.table("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/Pascal/corrected_pascal_output/EUR.ASN.CARDIoGRAMplusC4D_data_stage2.CAD.PathwaySet--module4pascal--sum.txt", header=T)
    dat3 <- read.table("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/Pascal/corrected_pascal_output/EUR.CARDIoGRAM_2010_lipids.HDL_ONE.PathwaySet--module4pascal--sum.txt", header=T)
    datalist <- cbind(dat1,dat2,dat3) ## erreur à la 1e boucle où :
                                      ## 'by' doit spécifier une colonne unique correcte (pour datalist issu de dat1...3)


## assuming tab separated values with a header
datalist = lapply(filelist, function(x)read.table(x, header=T)) 


merged = datalist[[1]]
for(i in 2:length(datalist)){
  merged = merge(merged, datalist[i], by = "Name")
}

#colquinousinteresse = seq(1, 35, by = 2)
#pval = as.matrix(merged[,colquinousinteresse])
#colquinousinteresse = seq(1, 35, by = 2) ; ncol(merged)
colquinousinteressePAS = seq(2, 35, by = 2)
pval = as.matrix(merged)
pval <- pval[,-colquinousinteressePAS]
pval[1:5,]


## sorted pval
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
  all_indiv = cbind(all_indiv,isa_out[[i]]$columns)
  all_genes = cbind(all_genes, isa_out[[i]]$rows)
}

all_indiv = all_indiv[,2:length(all_indiv[1,])]
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


# if(data[i] %in% eqtl[j]) alors add
# add <- eQTL_list$snp_rs[eQTL_list$gene_id %in% gene_id] ## possible ????????????????????????????
# add <- cbind(add, eQTL_list$snp_rs[eQTL_list$gene_id==gene_id])

## builds an output for one module
add_snpToGeneID <- function(mod) { ## entrer à la main le numéro du module : p.ex. si vec_modules[1]="module_692", entrer 692 pour mod
  modgene_id <- genenames_ensg(mod) ## gene IDs of the module
  gene_id <- c()
  snp <- c() ## corresponding snp_rs
  eQTL_output <- c() ## matrix of 2 columns : the genes IDs and the corresponding SNPs
  for(i in 1:modgene_id) {
    for(j in 1:eQTL_list$gene_id) {
      if(modgene_id[i] == eQTL_list$gene_id[j]) {
        gene_id <- append(gene_id, modgene_id[i])
        snp <- append(snp, eQTL_list$snp_rs[j])
      }}}
  eQTL_output <- cbind(gene_id, snp)
#  write(eQTL_output, file = "eQTL_output.txt", ncolumns = 2)
  file.create("/home/synth/UNIL/4e + re4e semestre/Étude de cas mathématiques appliqués à la biologie/eqtl/snp_id.txt", showWarnings = FALSE)
  return(eQTL_output)
}
add_snpToGeneID(1) ## le file est bien créé, mais est vide .....
