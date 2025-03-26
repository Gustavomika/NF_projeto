# NF_projeto

This Nextflow workflow that merges replicates from FASTQ files named following this pattern: "PatientX_repX_R1.fastq.gz".

Here's an explanation of how this workflow works:

  The main script (main.nf) sets up the input, a path to a folder with fastq files (default = ./data), and output, a folder with the merged fastq files (default = ./merged_fastq).
  It creates a channel from the input directory, grouping files by patient and separating R1 and R2 reads.
  The MERGE_REPLICATES process is called with the grouped files.
  In the MERGE_REPLICATES process:
    It uses cat to combine all R1 files for each patient, and separately all R2 files.
    The merged files are named according to the patient and read direction (R1 or R2).
    The merged files are published to the output directory.
    
To run this workflow, you would use:

nextflow run main.nf --input_dir path/to/your/input_dir --output_dir path/to/your/output

A test data is present in the data folder, with 12 files from three patients. 
