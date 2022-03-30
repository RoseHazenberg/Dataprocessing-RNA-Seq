configfile: 'config/config.yaml'
SAMPLES = ['SRR2073144', 'SRR2073145']

rule all:
    input:
        expand('fastq/{sample}.fastq', sample = config['samples'])

rule convert_sra_to_fastq:
    input:
        'data/{sample}/{sample}/{sample}.sra'
    output:
        directory('fastq/{sample}.fastq')
    shell:
        'fastq-dump {input}'
