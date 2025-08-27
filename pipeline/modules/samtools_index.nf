process SAMTOOLS_INDEX {

    publishDir "bai_indices", mode: 'copy'
    cpus 4

    input: 
        path(bam_file)

    output:
        path "*.sorted.bam.bai", emit: bai_index
    
    script:
    """
    samtools index -@ ${task.cpus} "${bam_file}" 
    """
}