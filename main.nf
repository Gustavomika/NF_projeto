#!/usr/bin/env nextflow

//input and output parameters

params.input_dir = "$projectDir/data"
params.output_dir = "merged_fastq"

//process that merge fastq files replicates

include { MERGE_REPLICATES } from './modules/merge_replicates'


workflow {
    // create a channel from the input directory
    fastq_files = Channel
        .fromFilePairs("${params.input_dir}/*_{R1,R2}.fastq.gz", flat: true, checkIfExists: true)
        .map { patient_rep, r1, r2 ->
            def (patient, rep) = patient_rep.split('_')
            [patient, r1, r2]
        }
        .groupTuple()

    // merge replicates
    MERGE_REPLICATES(fastq_files)
}
