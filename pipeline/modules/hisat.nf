process HISAT_MAP {
    publishDir 'Mapping', mode:'copy'
    
    cpus 4

    input:
        tuple val(sampleid), path(read1), path(read2), path(index)

    output:
        path "${sampleid}.sorted.bam", emit: sorted_bams


    script:
    """
    hisat2 -q -x /Users/stevennguyen/Projects/nextflowrnaseq/data/index/genome \
        -1 ${read1} \
        -2 ${read2} \
        --threads ${task.cpus} \
        --no-unal \
        | samtools view -@ ${task.cpus} -Sb \
        | samtools sort -o "${sampleid}.sorted.bam"
    """

}