"""
Converts the BAM files into SAM files using samtools.
#samtools_index, index bam files
#samtools_view, convert bam into sam
"""

# SAMPLES = ['SRR2073144', 'SRR2073145']
#
# rule all:
#     input:
#         expand('alignment/{sample}-aligned-tophat/accepted_hits.sam', sample = SAMPLES)

rule samtools:
    input:
        bam = 'alignment/{sample}-aligned-tophat/accepted_hits.bam'
    output:
        'alignment/{sample}-aligned-tophat/accepted_hits.sam'
    benchmark:
        'benchmarks/{sample}.samtools.benchmark.txt'
    log:
        'logs/samtools/{sample}.log'
    threads:
        8
    message:
        'executing samtools index on {input.bam} and samtools view on {input.bam} to generate {output}'
    shell:
        '(samtools index {input.bam} | samtools view -h {input.bam} > {output}) 2> {log}'
