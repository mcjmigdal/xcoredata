#!/usr/bin/env R
# Bogumil Kaczkowski
# the purpose of the script is to overlap the FANTOM5 DPI/promoter regions
# with ChipAtlas, Chip-Seq peak data-base
devtools::load_all()
library(xcore)

# read in the peak into R
chip_atlas_file <-
  system.file("inst", "extdata", "chip_atlas_hg38.Oth.ALL.05.AllAg.AllCell_SRX_only.bed.gz", package = "xcoredata")
chip_atlas <- rtracklayer::import(chip_atlas_file)
chip_atlas$score <- as.integer(chip_atlas$score)
chip_atlas_meta <-
  read.delim(
    file = system.file("inst", "extdata", "experimentList_TF_hg38.txt", package = "xcoredata"),
    sep = "\t",
    header = FALSE,
    quote = "\"")

# remove ambiguous records
ambiguous_tf <- c("5-hmC", "5-mC", "8-Hydroxydeoxyguanosine", "Biotin", "BMI",
                  "BrdU", "Cas9", "Cyclobutane", "MethylCap", "O-GlcNAc",
                  "Pan-acetyllysine", "pFM2", "RTA", "SVS-1", "EBNA1", "EBNA2",
                  "EBNA3", "EBV-ZEBRA", "AML1-ETO", "VSV-G", "MLL-AF4",
                  "MLL-AF6", "Hepatitis", "HIV", "KSHV", "MCPV", "Epitope tags",
                  "GFP", "HIV Tat", "MCPV ST", "KSHV LANA", 
                  "Cyclobutane pyrimidine dimers", "Hepatitis B Virus X antigen")
ambiguous_srx <-
  chip_atlas_meta %>%
  dplyr::filter(V4 %in% ambiguous_tf) %>% # V4 == TF column
  dplyr::pull(V1) # V1 == experiment ID
chip_atlas <- chip_atlas[! chip_atlas$name %in% ambiguous_srx, ]

unique_srxIDs <- unique(chip_atlas$name)
unique_srxIDs <- unique_srxIDs[order(unique_srxIDs)]

# create intersection matrises
chip_atlas_promoters_f5 <-
  xcore::getInteractionMatrix(a = promoters_f5,
                              b = chip_atlas,
                              ext = 500,
                              count = FALSE)
chip_atlas_promoters_f5 <- chip_atlas_promoters_f5[, unique_srxIDs]

# standarize signatures names
data.table::setDT(chip_atlas_meta)
ids <- colnames(chip_atlas_promoters_f5)
data.table::setkey(chip_atlas_meta, V1)
chip_atlas_meta[ids][["V6"]] <- gsub("\\s+", "_", chip_atlas_meta[ids][["V6"]])
chip_atlas_meta[ids][["V6"]] <- gsub("\\.", "_", chip_atlas_meta[ids][["V6"]])

#                                                            tf, background, experiment id
colnames(chip_atlas_promoters_f5) <- chip_atlas_meta[ids, paste(V4, V6, V1, sep = ".")]

# save
usethis::use_data(chip_atlas_promoters_f5, internal = FALSE, overwrite = TRUE)
