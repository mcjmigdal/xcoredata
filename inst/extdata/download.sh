#!/usr/bin/bash
# Download external dataset including ReMap peaks.
# Caution! CIS-BP classification has to be downloaded manually

## Check if the dataset, given as the URL, has been already downloaded and download it if it has not.
function downloadDataset {
  dataset=`basename $1`
  if [ ! -f ${dataset} ]; then
    wget $1
  fi
}

# Download ChIP-Atlas
# hg38 TFs and others (15217) in All cell types (61679) with 50 Threshold for Significance
downloadDataset http://dbarchive.biosciencedbc.jp/kyushu-u/hg38/assembled/Oth.ALL.05.AllAg.AllCell.bed
# process ChIP-Atlas data to extract SRX field and remove unncecessary data from 4th column
if [ ! -f chip_atlas_hg38.Oth.ALL.05.AllAg.AllCell_SRX_only.bed.gz ]; then
  cat Oth.ALL.05.AllAg.AllCell.bed | \
    awk '{gsub(";.*|ID=","",$4)}1' |  \
    awk 'OFS="\t" {print $1,$2,$3,$4,$5,$6}' | \
    tail -n +2 | \
    gzip > chip_atlas_hg38.Oth.ALL.05.AllAg.AllCell_SRX_only.bed.gz
fi
# download experiments metadata
downloadDataset http://dbarchive.biosciencedbc.jp/kyushu-u/metadata/experimentList.tab
if [ ! -f experimentList_TF_hg38.txt ]; then
  grep -w hg38 experimentList.tab | grep -w 'TFs and others' | awk '{if($2 == "hg38"){print $0}}' > experimentList_TF_hg38.txt
fi

# CIS-BP classification
# has to be downloaded manually from http://cisbp.ccbr.utoronto.ca/bulk.php, 
# select By Species: Homo_sapiens and TF info

# Epigenome5DRoadmapDHS_promoter_hg38_liftOver.bed TODO

# Download GENCODE annotation
downloadDataset http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_38/gencode.v38.annotation.gff3.gz

# Download FANTOM5 annotations
# promoters bed hg38
downloadDataset https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks/hg38_fair+new_CAGE_peaks_phase1and2.bed.gz
# promoters annotation hg38
downloadDataset https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks_expression/hg38_fair+new_CAGE_peaks_phase1and2_ann.txt.gz
# CAGE peaks (promoters) counts tables
downloadDataset https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_v8/extra/CAGE_peaks_expression/hg38_fair+new_CAGE_peaks_phase1and2_counts_ann.osc.txt.gz

# Download ReMap
# all peaks hg38
downloadDataset https://remap.univ-amu.fr/storage/remap2020/hg38/MACS2/remap2020_all_macs2_hg38_v1_0.bed.gz
# merged (non redundant) peaks hg38
downloadDataset https://remap.univ-amu.fr/storage/remap2020/hg38/MACS2/remap2020_nr_macs2_hg38_v1_0.bed.gz

