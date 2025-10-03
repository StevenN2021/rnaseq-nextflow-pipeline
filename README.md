# rnaseq-nextflow-pipeline

This Nextflow project allows for processing of bulk NGS RNAseq datasets in the form of FASTQ files to obtain a counts matrix for downstream DE analysis (Trim Galore -> FASTQC/MULTIQC -> Hisat2 -> featureCounts) 
Pipeline is containerized with docker and the workflow script can be viewed in the [main.nf](https://github.com/StevenN2021/RNAseq-Processing-Pipeline-with-Nextflow/blob/main/pipeline/main.nf) file.

## Modules/Processes
[TRIM_GALORE](https://github.com/StevenN2021/RNAseq-Processing-Pipeline-with-Nextflow/blob/main/pipeline/modules/trim_galore.nf) - runs trim galore on raw fastq files to remove adapter sequences. 

[FASTQC_MULTIQC](https://github.com/StevenN2021/RNAseq-Processing-Pipeline-with-Nextflow/blob/main/pipeline/modules/qc.nf) - creates a multiqc report from all samples. 

[HISAT_MAP](https://github.com/StevenN2021/RNAseq-Processing-Pipeline-with-Nextflow/blob/main/pipeline/modules/hisat.nf) - aligns reads to human genome using HISAT2 and converts to + sorts SAM file to avoid redundant storage. 

[SAMTOOLS_INDEX](https://github.com/StevenN2021/RNAseq-Processing-Pipeline-with-Nextflow/blob/main/pipeline/modules/samtools_index.nf) - indexes SAM file. 

[FEATURE_COUNTS](https://github.com/StevenN2021/RNAseq-Processing-Pipeline-with-Nextflow/blob/main/pipeline/modules/feature_counts.nf) - runs featureCounts quantification on sorted SAM files to obtain counts matrix. 

## Containers 
Containers can be found in [this](https://github.com/StevenN2021/RNAseq-Processing-Pipeline-with-Nextflow/blob/main/pipeline/nextflow.config) config file 
