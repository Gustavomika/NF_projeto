// modules/merge_replicates.nf

process MERGE_REPLICATES {
    publishDir params.output_dir, mode: 'copy'

    input:
    tuple val(patient), path(r1_files), path(r2_files)

    output:
    tuple path("${patient}_R1.fastq.gz"), path("${patient}_R2.fastq.gz")

    script:
    """
    cat ${r1_files.join(' ')} > ${patient}_R1.fastq.gz
    cat ${r2_files.join(' ')} > ${patient}_R2.fastq.gz
    """
}
