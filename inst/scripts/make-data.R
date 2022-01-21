#!/usr/bin/env R

# download source data, some of the data have to be downloaded manually please
# look into download.sh for details
system2("./download.sh")

source("promoters_f5.R")
source("promoters_f5_core.R")
source("remap_promoters_f5.R")
source("remap_meta.R")
source("chip_atlas_promoters_f5.R")
source("chip_atlas_meta.R")
