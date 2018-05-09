read.table("EUR.ASN.C4D_CAD_discovery_metaanalysis_update.CAD.PathwaySet--module4pascal--sum.txt",
           header = T, 
           sep = "\t")
data = read.table("EUR.ASN.C4D_CAD_discovery_metaanalysis_update.CAD.sum.genescores.txt", header = T)

head(data)
which(data$pvalue < 0.05/length(data$pvalue))

data$gene_id[data$pvalue < 0.05/length(data$pvalue)]
