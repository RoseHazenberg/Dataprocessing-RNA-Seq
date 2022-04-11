"""
Remove adapter sequences using cutadapt.
#cutadapt, removes the first 15 bases of each read
"""

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