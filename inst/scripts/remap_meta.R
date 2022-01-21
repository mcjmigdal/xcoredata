#!/usr/bin/env R
# ReMap2020 metadata
library(xcore)
load("remap_promoters_f5.rda")

# Studies ids fix
srx2srastudy <- data.table::fread("../extdata/srx2study.csv")

translate <- function(x, key, value) {
  value[match(x, key)]
}

remap_id <- colnames(remap_promoters_f5)

remap_meta <- remap_id %>%
  stringr::str_split(pattern = "\\.", n = 3) %>%
  do.call(what = rbind) %>%
  data.table::as.data.table()
colnames(remap_meta) <- c("tf", "background", "id")
remap_meta$biotype <- remap_meta$background %>%
  gsub(pattern = "_.*", replacement = "")
remap_meta$condition <- remap_meta$background %>%
  sub(pattern = "(.*?)_", replacement = "")
remap_meta$condition[! grepl("_", remap_meta$background)] <- ""
remap_meta[, background := NULL]

# fix study ids
remap_meta$study <- remap_meta$id
remap_meta$study[grepl(pattern = "ENCSR", x = remap_meta$id)] <-
  translate(grep(pattern = "ENCSR", x = remap_meta$id, value = TRUE),
            srx2srastudy$Experiment,
            srx2srastudy$SRAStudy)
remap_meta$study <- ifelse(is.na(remap_meta$study), remap_meta$id, remap_meta$study)

# restore id
remap_meta$id <- remap_id

# CIS-BP TF classification
cis_bp <- data.table::fread("cis_bp_tf_class.txt")
cis_bp <- cis_bp[, .(tf_dbd = unique(DBDs)), by = TF_Name]
data.table::setnames(cis_bp, "TF_Name", "tf")
remap_meta <- cis_bp[remap_meta, on = c("tf" = "tf")]

data.table::setcolorder(remap_meta, c("id", "tf", "tf_dbd", "biotype", "study", "condition"))
save(remap_meta, file = "remap_meta.rda")
