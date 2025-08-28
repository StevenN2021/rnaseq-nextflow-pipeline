include { FASTQC_MULTIQC } from './modules/qc.nf'
include { TRIM_GALORE } from './modules/trim_galore.nf'
include { HISAT_MAP } from './modules/hisat.nf'
include { SAMTOOLS_INDEX } from './modules/samtools_index.nf'
include { FEATURE_COUNTS } from './modules/feature_counts.nf'

/*
 * Pipeline Parameters
 */

// raw reads 
params.reads='/Users/stevennguyen/Projects/nextflowrnaseq/data/raw/*{_1,_2}*.fastq.gz'

// trimmed reads
params.trimmed='/Users/stevennguyen/Projects/nextflowrnaseq/pipeline/TRIMMED/*{_1,_2}*.fq.gz'

// hisat2 indices
params.index = '/Users/stevennguyen/Projects/nextflowrnaseq/data/index/'

// hg38 gtf file
params.gtf = '/Users/stevennguyen/Projects/nextflowrnaseq/data/annotation/gencode.v42.annotation.gtf'

workflow {

// trimming raw reads
reads_ch=Channel.fromFilePairs(params.reads)
TRIM_GALORE(reads_ch)

// fastqc and multiqc report on trimmed
FASTQC_MULTIQC(TRIM_GALORE.out.trimmed)

// hisat2 alignment and samtools sort 
trimmed_ch=Channel.fromFilePairs(params.trimmed, flat: true)
index_ch=Channel.fromPath(params.index)
hisat_input=trimmed_ch.combine(index_ch)
HISAT_MAP(hisat_input)

// samtools index
SAMTOOLS_INDEX(HISAT_MAP.out.sorted_bams)

// read counts with featureCounts
sorted_bams=HISAT_MAP.out.sorted_bams
                        .collect()
                        .set{finalbams}
gtf_annotation=Channel.fromPath(params.gtf)  

FEATURE_COUNTS(finalbams,gtf_annotation)

 }
