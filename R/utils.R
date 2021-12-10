#' Annotate with Nearest Promoter on the Same Strand
#' @param regions query genomic regions as GRanges object
#' @param gencode complete Gencode annotation as GRanges object, e.g. obrained by rtracklayer::import.gff(con = "gencode.v31.annotation.gff3.gz") ,  (gencode[ gencode$type == "transcript"] is also OK)
#' @param cut_off_distance distance in bp used as a cut-off when annotating nearest promoters
#' @return GRanges with new columns added to the feature metadata: mcols(regions)
#' @importFrom GenomicRanges promoters mcols
#' @importFrom S4Vectors DataFrame
#' @export
gencode_nearest_promoter_same_strand = function( regions, gencode , cut_off_distance = 500) {

	  gencode_promoters   = GenomicRanges::promoters( gencode[ gencode$type == "transcript"] , upstream = 0, downstream = 0, use.names=TRUE)

  regions = gencode_one_direction_distanceToNearest( regions = regions, gencode = gencode_promoters)

    if( !is.null( cut_off_distance )){
	        too_far = regions$nearest_distance > cut_off_distance
      regions$nearest_symbol     [ too_far ]  = ""
          regions$nearest_gene_type  [ too_far ]  = ""
        }

    regions
}

#' Annotation Worker by Same Strand DistanceToNearest
#'
#' @param regions query genomic regions as GRanges object
#' @param gencode Gencode annotation as GRanges object, usually of one type like gencode[ gencode$type == "exon"]
#' @return GRanges with new columns added to the feature metadata: mcols(regions)
#' @importFrom GenomicRanges distanceToNearest
#' @export
gencode_one_direction_distanceToNearest = function( regions , gencode){

	  # ordering so higher level gene annotation will overwrie lower level annotation
	  # if multiple genes are annotated to same region
	  gencode = gencode[ order( gencode$level , decreasing = F),]

  if( is.null(regions$nearest_symbol) )       { regions$nearest_symbol         = ""}
    if( is.null(regions$nearest_gene_type) )    { regions$nearest_gene_type      = ""}
    if( is.null(regions$nearest_distance) )     { regions$nearest_distance       = -1}

      hits = GenomicRanges::distanceToNearest( regions, gencode , ignore.strand=FALSE)
      regions$nearest_symbol[hits@from]       = gencode$gene_name[hits@to]
        regions$nearest_gene_type[hits@from]    = gencode$gene_type[hits@to]
        regions$nearest_distance                = hits@elementMetadata$distance

	  regions
}
