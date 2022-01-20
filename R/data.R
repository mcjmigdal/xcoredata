#' Promoters GenomicRanges object
#'
#' FANTOM5's hg38 promoters annotated with nearest features in GENCODE ver.
#' 38 annotation and UCSC hg38 knownGene annotation ver. 3.13.0.
#'
#' @format A \code{GenomicRanges} object of length 209911, with 11 metadata columns:
#' \describe{
#'   \item{name}{Promotor name.}
#'   \item{score}{Numeric vector.}
#'   \item{gene_type_gencode}{Gene type of associated gene as defined by GENCODE annotation.}
#'   \item{ENTREZID}{ENTREZ ID of associated gene as defined by all three annotation sources.
#'                   Prevalence of annotations: UCSC > GENCODE > FANTOM5.}
#'   \item{SYMBOL}{Gene symbol of associated gene as defined by all three annotation sources.
#'                 Prevalence of annotations: UCSC > GENCODE > FANTOM5.}
#' }
#'
"promoters_f5"

#' Core promoters GenomicRanges object
#'
#' Core promoters selected from promoters_f5.
#' Selection criteria were GENCODE confirmation and ENCODE ROADMAP confirmation.
#' Further for each gene single promoter with highest FANTOM5 score was selected.
#'
#' @format A \code{GenomicRanges} object of length 14191, with 16 metadata columns:
#' \describe{
#'   \item{name}{Promotor name.}
#'   \item{score}{Numeric vector.}
#'   \item{gene_type_gencode}{Gene type of associated gene as defined by GENCODE annotation.}
#'   \item{ENTREZID}{ENTREZ ID of associated gene as defined by all three annotation sources.
#'                   Prevalence of annotations: UCSC > GENCODE > FANTOM5.}
#'   \item{SYMBOL}{Gene symbol of associated gene as defined by all three annotation sources.
#'                 Prevalence of annotations: UCSC > GENCODE > FANTOM5.}
#' }
#'
"promoters_f5_core"

#' ReMap2020 and FANTOM5 promoters intersection matrix
#'
#' An intersection matrix describing overlaps between ReMap2020's ChIP-seq tracks
#' and \code{\link{promoters_f5}}. To find overlapping regions promoters were extended
#' by 500bp in both directions.
#'
#' @format A Matrix with 209911 rows and 5728 columns. Row names corresponds to promoters
#'         names, column names are formatted as ExperimentID.TranscriptionFactor.Biotype.
#'
"remap_promoters_f5"

#' ChIP-Atlas FANTOM5 promoters intersection matrix
#'
#' An intersection matrix describing overlaps between ChIP-Atlas's ChIP-seq tracks
#' and \code{\link{promoters_f5}}. To find overlapping regions promoters were extended
#' by 500bp in both directions.
#'
#' @format A \code{Matrix} with 209911 rows and 13891 columns. Row names corresponds to promoters
#'         names, column names are formatted as TranscriptionFactor_Origin_Cell_ExperimentID
#'	   (eg. PARK7_Neural_SH-SY5Y_DRX000550, MLL-AF6_Blood_ML-2_DRX001460).
#'
"chip_atlas_promoters_f5"

#' ReMap2020 metadata
#'
#' Metadata associated with \code{remap_promoters}.
#'
#' @format A \code{data.table} with 5798 rows and 6 columns.
#' \describe{
#'   \item{id}{Character giving internal experiment ID.}
#'   \item{tf}{Character giving transcription factor name.}
#'   \item{tf_dbd}{Character giving transcription factor DNA binding domain
#'                 family, as per CIS BP database.}
#'   \item{biotype}{Character giving experiment biological origin.}
#'   \item{study}{Character giving study ID.}
#'   \item{condition}{Character specifiying experiment conditions or treatment.}
#' }
#'
"remap_meta"

#' ChIP-Atlas metadata
#'
#' Metadata associated with \code{chip_atlas_promoters}.
#'
#' @format A \code{data.frame} with 13891 rows and 5 columns.
#' \describe{
#'   \item{id}{Character giving internal experiment ID.}
#'   \item{tf}{Character giving transcription factor name.}
#'   \item{tf_dbd}{Character giving transcription factor DNA binding domain
#'                 family, as per CIS BP database.}
#'   \item{biotype}{Character giving experiment biological origin.}
#'   \item{study}{Character giving study ID.}
#' }
#'
"chip_atlas_meta"

