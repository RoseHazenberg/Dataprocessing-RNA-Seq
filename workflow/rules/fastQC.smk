"""
Makes a quality metrics using FastQC.
And repeats the quality metrics using FastQC to check for any errors on the trimmed fastq files.
#fastqc, performs fastqc on the fastq files generated after fastq-dump and performs fastqc on the trimmed fastq files
"""

rule fastqc:
    input:
        'fastq_data/{sample}/{sample}.fastq',
        'cutadapt/{sample}_trimmed.fastq'
    output:
        'fastqc_reports/{sample}_fastqc.zip',
        'fastqc_reports/{sample}_fastqc.html',
        'fastqc_reports/{sample}_trimmed_fastqc.zip',
        'fastqc_reports/{sample}_trimmed_fastqc.html'
    benchmark:
        'benchmarks/{sample}.fastqc.benchmark.txt'
    log:
        'logs/fastqc/{sample}.log'
    threads:
        4
    message:
        'executing fastqc on {input} to generate {output}'
    shell:
        '(fastqc {input} -o fastqc_reports/) 2> {log}'