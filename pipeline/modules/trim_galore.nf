
process TRIM_GALORE {

cpus 4
publishDir "TRIMMED",mode: 'copy'

input:

    tuple val(sampleid), path(reads)

output:
    path "*"
    path "*trimmed*.fq.gz", emit: trimmed

script:
"""
trim_galore --paired -q 20 --gzip --cores ${task.cpus} --basename ${sampleid}_trimmed ${reads} 
"""
}