#!/usr/bin/env R
# ENTREZ IDs to FANTOM5 promoters mapping
load("promoters_f5_core.rda")

entrez2fantom <- setNames(promoters_f5_core$name, promoters_f5_core$ENTREZID)
i_dups <- 
  duplicated(promoters_f5_core$ENTREZID) | duplicated(promoters_f5_core$ENTREZID, fromLast = TRUE)
entrez2fantom <- entrez2fantom[! i_dups]

save(entrez2fantom, file = "entrez2fantom.rda")