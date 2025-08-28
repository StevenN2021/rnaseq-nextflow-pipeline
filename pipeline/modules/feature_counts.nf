process FEATURE_COUNTS {

publishDir "Read_counts", mode: 'copy'

input:
    path(sorted_bams)
    path(gtf)

output:
    "*"

script:
"""

featureCounts \
-a "${gtf}" \
-o "raw_counts.txt" \
-s 2 \
-t exon \
-p \
-T 4 \
${sorted_bams}
"""
}