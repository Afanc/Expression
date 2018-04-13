#!/usr/bin/R

ensembl = useMart("ensembl")
ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl)

infos = getBM(attributes= c("ensembl_gene_id", "external_gene_name","description","interpro_description"), filters="ensembl_gene_id", values=g_mod1, mart=ensembl)

infos

# GO, done with Sarvenaz
data(ALL)
data(geneList)

gene_universe = as.vector(modules$rows[,1])
names(gene_universe) = gene_id [2:19902] # remove index in the future
sampleGOdata <- new("topGOdata",
                     description = "Simple session", ontology = "BP",
                     allGenes = geneList, geneSel = function(a) a!=0,
                     nodeSize = 10,
                     annot = annFUN.db, affyLib = affyLib)

resultFisher <- runTest(sampleGOdata, algorithm = "classic", statistic = "fisher")

allRes <- GenTable(sampleGOdata, classicFisher = resultFisher
                   , ranksOf = "classicFisher", topNodes = 10)
