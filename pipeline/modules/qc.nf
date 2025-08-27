process FASTQC_MULTIQC {

publishDir "qc_report", mode: 'copy'

input:
    path(reads)

output:
    path "*"


script:
"""
#run fastqc on all trimmed reads
fastqc ${reads}

#run multiqc to aggregate the fastqc reports
multiqc *fastqc*

mkdir FASTQC
mv *fastqc* FASTQC
"""
}