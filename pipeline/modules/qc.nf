process FASTQC_MULTIQC {

publishDir "qc_report", mode: 'copy'

input:
    path(reads)

output:
    path "*"

script:
"""
fastqc ${reads}
multiqc *fastqc*

mkdir FASTQC
mv *fastqc* FASTQC

"""


}