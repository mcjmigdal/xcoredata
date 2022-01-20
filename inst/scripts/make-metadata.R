#!/usr/bin/env R
metadata <- data.frame(
  Title = c(
    "ChIP-Atlas molecular signatures metadata",
    "ReMap2020 molecular signatures metadata",
    "ChIP-Atlas molecular signatures",
    "ReMap2020 molecular signatures",
    "FANTOM5 promoters",
    "core FANTOM5 promoters"
  ),
  Description = c(
    "Metadata associated with chip_atlas_promoters_f5",
    "Metadata associated with remap_promoters_f5",
    "An intersection matrix describing overlaps between ChIP-Atlas's ChIP-seq tracks and promoters_f5. To find overlapping regions promoters were extended by 500bp in both directions.",
    "An intersection matrix describing overlaps between ReMap2020's ChIP-seq tracks and promoters_f5. To find overlapping regions promoters were extended by 500bp in both directions.",
    "FANTOM5's hg38 promoters annotated with nearest features in GENCODE ver. 38 annotation and UCSC hg38 knownGene annotation ver. 3.13.0.",
    "Core promoters selected from promoters_f5. Selection criteria were GENCODE confirmation and ENCODE ROADMAP confirmation. Further for each gene single promoter with highest FANTOM5 score was selected."
  ),
  BiocVersion = c("3.15", "3.15", "3.15", "3.15", "3.15", "3.15"),
  Genome = c(NA, NA, "GRCh38", "GRCh38", "GRCh38", "GRCh38"),
  SourceType = c("BED", "BED", "BED", "BED", "BED", "BED"),
  SourceUrl = c(
    "https://www.chip-atlas.org",
    "https://remap.univ-amu.fr/storage/remap2020/hg38/MACS2/remap2020_all_macs2_hg38_v1_0.bed.gz",
    "https://www.chip-atlas.org",
    "https://remap.univ-amu.fr/storage/remap2020/hg38/MACS2/remap2020_all_macs2_hg38_v1_0.bed.gz",
    "https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks/hg38_fair+new_CAGE_peaks_phase1and2.bed.gz",
    "https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks/hg38_fair+new_CAGE_peaks_phase1and2.bed.gz"
  ),
  SourceVersion = c("7/2021", "ReMap2020", "7/2021", "ReMap2020", "v8", "v8"),
  Species = c(
    NA,
    NA,
    "Homo sapiens",
    "Homo sapiens",
    "Homo sapiens",
    "Homo sapiens"
  ),
  TaxonomyId = c(NA, NA, "9606", "9606", "9606", "9606"),
  Coordinate_1_based = c(NA, NA, NA, NA, TRUE, TRUE),
  DataProvider = c("ChIP-Atlas", "ReMap", "ChIP-Atlas", "ReMap", "RIKEN", "RIKEN"),
  Maintainer = "Maciej Migdal <mcjmigdal@gmail.com>",
  RDataClass = c(
    "data.table",
    "data.table",
    "dgCMatrix",
    "dgCMatrix",
    "GRanges",
    "GRanges"
  ),
  DispatchClass = c("Rda", "Rda", "Rda", "Rda", "Rda", "Rda"),
  Location_Prefix = "https://zdglab.iimcb.gov.pl/mmigdal/",
  RDataPath = paste0(
    "xcoredata/",
    c(
      "chip_atlas_meta.rda",
      "remap_meta.rda",
      "chip_atlas_promoters_f5.rda",
      "remap_promoters_f5.rda",
      "promoters_f5.rda",
      "promoters_f5_core.rda"
    )
  ),
  Tags = NA
)
 
write.csv(
  metadata,
  file = "../extdata/metadata.csv",
  row.names = FALSE
)
