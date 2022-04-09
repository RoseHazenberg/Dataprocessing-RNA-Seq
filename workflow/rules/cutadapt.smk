"""
Remove adapter sequences using cutadapt.
#cutadapt, removes the first 15 bases of each read
"""
# SAMPLES = ['SRR2073144', 'SRR2073145']
#
# rule all:
#     input:
#         expand('cutadapt/{sample}_trimmed.fastq', sample=SAMPLES)

rule cutadapt:
    input:
        'fastq_data/{sample}/{sample}.fastq'
    output:
        'cutadapt/{sample}_trimmed.fastq'
    benchmark:
        'benchmarks/{sample}.cutadapt.benchmark.txt'
    log:
        'logs/cutadapt/{sample}.log'
    threads:
        4
    message:
        'executing cutadapt on {input} which generates {output}'
    shell:
        '(cutadapt -u 15 -o {output} {input}) 2> {log}'
