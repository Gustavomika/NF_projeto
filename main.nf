#!/usr/bin/env nextflow

//parametros de input e output

params.input_dir = "$projectDir/data"
params.output_dir = "merged_fastq"

//processo para juntar replicatas de arquivos fastq

include { MERGE_REPLICATES } from './modules/merge_replicates'


workflow {
    // cria um canal a partir do diretorio de input
    fastq_files = Channel
        .fromFilePairs("${params.input_dir}/*_{R1,R2}.fastq.gz", flat: true, checkIfExists: true)
        .map { patient_rep, r1, r2 ->
            def (patient, rep) = patient_rep.split('_')
            [patient, r1, r2]
        }
        .groupTuple()

    // juntar replicatas
    MERGE_REPLICATES(fastq_files)
}
