"""
Makes a quality metrics using FastQC.
And repeats the quality metrics using FastQC to check for any errors on the trimmed fastq files.
#fastqc, performs fastqc on the fastq files generated after fastq-dump
#fastqc_trimmed, performs fastqc on the trimmed files after cutadapt, to check for any errors
"""

# SAMPLES = ['SRR2073144', 'SRR2073145']
#
# rule all:
#     input:
#         expand('fastqc_reports/{sample}_fastqc.zip', sample = SAMPLES),
#         expand('fastqc_reports/{sample}_fastqc.html', sample = SAMPLES),
#         expand('fastqc_reports/{sample}_trimmed_fastqc.zip', sample = SAMPLES),
#         expand('fastqc_reports/{sample}_trimmed_fastqc.html', sample = SAMPLES)

rule fastqc:
    input:
        'fastq_data/{sample}/{sample}.fastq'
    output:
        'fastqc_reports/{sample}_fastqc.zip',
        'fastqc_reports/{sample}_fastqc.html'
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

rule fastqc_trimmed:
    input:
        'cutadapt/{sample}_trimmed.fastq'
    output:
        'fastqc_reports/{sample}_trimmed_fastqc.zip',
        'fastqc_reports/{sample}_trimmed_fastqc.html'
    benchmark:
        'benchmarks/{sample}.fastqc.trimmed.benchmark.txt'
    log:
        'logs/fastqc-trimmed/{sample}.log'
    threads:
        8
    message:
        'executing fastqc on {input} to check for any errors and reportes it in {output}'
    shell:
        '(fastqc {input} -o fastqc_reports/) 2> {log}'
