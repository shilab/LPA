library(igraph)
library(MASS)
library(biomaRt)
setwd('/Users/BC/Documents/MATLAB')

inweb_names <- read.table('inweb_cutoff.txt',header=T, sep="\t")
ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")
conn <- as.matrix(read.table('edgelist_lpa.txt', header=T, sep="\t"))



eQTls <- as.matrix(read.table('eqtl-genes.txt', header=T, sep="\t"))
conn <- as.matrix(read.table('edgelist_cis_trans_eqtl.txt', header=T, sep="\t"))
#inweb <- as.matrix(read.csv('InWeb29.csv', header=T))
inweb <- as.matrix(read.table('inweb_test.txt', header=T, sep="\t"))
#targets <- as.matrix(read.table('tarbase_gene_miRNA.dapple.txt', header=T, sep='\t'))

regulatory <- as.matrix(read.table('reg_network_hc.txt', header=T, sep="\t"))

e <- graph.edgelist(eQTls[,1:2], directed=F)

i <- graph.edgelist(inweb[,1:2], directed=F)
E(i)$Weight=as.numeric(inweb[,3])
t <- graph.edgelist(targets, directed=F)
r <- graph.edgelist(regulatory, directed=F)
c <- graph.edgelist(conn, directed=F)

e.adj <- get.adjacency(e)
i.adj <- get.adjacency(i)#, attr='Weight')
t.adj <- get.adjacency(t)
r.adj <- get.adjacency(r)
c.adj <- get.adjacency(c)



e.lapl <- graph.laplacian(e, norm=F)
i.lapl <- graph.laplacian(i, norm=F)
t.lapl <- graph.laplacian(t, norm=T)
r.lapl <- graph.laplacian(r, norm=F)
c.lapl <- graph.laplacian(c, norm=F)


write.matrix(c.lapl, file="cis_trans_lpa_network.txt", sep="\t")
write.matrix(e.lapl, file="eQTL-laplacian.txt", sep="\t")
write.matrix(i.lapl, file="inWebtestlapl.txt", sep="\t")
#write.matrix(t.lapl, file="targets_laplacian.txt", sep="\t")
write.matrix(r.lapl, file="reg_hc_lapl.txt", sep="\t")

write.matrix(e.adj, file="eQTL_adj.txt", sep="\t")
write.matrix(i.adj, file="inWeb_adj.txt", sep="\t")
write.matrix(t.adj, file="targets_adj.txt", sep="\t")
write.matrix(r.adj, file="regulatory_adj.txt", sep="\t")

#plot(e,layout=layout.fruchterman.reingold)#,edge.width=E(g)$weight)


conn <- as.matrix(read.table('conn_edgesbi', header=T, sep="\t"))
c <- graph.edgelist(conn, directed=F)
c.lapl <- graph.laplacian(c, norm=F)
write.matrix(c.lapl, file="conn_bi.txt", sep="\t")











#Process files in folder
files <- list.files(pattern="nodes") 

lapply(files, function(x) {
    #write.table(out, "../nodes_smgi/", sep="\t", quote=F, row.names=F, col.names=T)
})
