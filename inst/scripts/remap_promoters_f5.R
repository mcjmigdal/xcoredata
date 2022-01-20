#!/usr/bin/env R
# the purpose of the script is to overlap the FANTOM5 DPI/promoter regions with ReMap Chip Seq data-base
devtools::load_all()
library(xcore)

# read in the peak into R 
remap_input <-
    system.file("inst", "extdata", "remap2020_all_macs2_hg38_v1_0.bed.gz", package = "xcoredata")
remap <- rtracklayer::import(remap_input)
remap$name <- gsub("\\s+", "", remap$name) # remove white spaces from features names
remap$name <- gsub("__", "_", remap$name)
remap$name <- gsub("--", "", remap$name)


# create intersection matrix
remap_promoters_f5 <-
  xcore::getInteractionMatrix(a = promoters_f5,
                              b = remap,
                              ext = 500,
                              count = FALSE)

# standarize signatures names
srx2srastudy <- data.table::fread(
  file = system.file(
    "inst",
    "extdata",
    "srx2study.csv",
    package = "xcoredata"
  )
)

translate <- function(x, key, value) {
  newx <- value[match(x, key)]
}

remap_meta <- remap_promoters_f5 %>%
  colnames() %>%
  stringr::str_split(pattern = "\\.", n = 3) %>%
  do.call(what = rbind) %>%
  data.table::as.data.table()
colnames(remap_meta) <- c("id", "tf", "background")

colnames(remap_promoters_f5) <- remap_meta[, paste(tf, background, id, sep = ".")]

# save
save(remap_promoters_f5, file = "../extdata/remap_promoters_f5.rda")
