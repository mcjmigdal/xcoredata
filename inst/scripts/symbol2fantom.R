#!/usr/bin/env R
# Gene symbols to FANTOM5 promoters mapping
load("promoters_f5_core.rda")

symbol2fantom <- setNames(promoters_f5_core$name, promoters_f5_core$SYMBOL)
i_dups <- 
  duplicated(promoters_f5_core$SYMBOL) | duplicated(promoters_f5_core$SYMBOL, fromLast = TRUE)
symbol2fantom <- symbol2fantom[! i_dups]

save(symbol2fantom, file = "symbol2fantom.rda")