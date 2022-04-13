"""
Converts the BAM files into SAM files using samtools.
#samtools, first it indexes BAM files with samtools index and then it generates SAM files with samtools view -h
"""

rule samtools:
    input:
        bam = 'alignment/{sample}-aligned-tophat/accepted_hits.bam'
    output:
        'alignment/{sample}-samtools/accepted_hits.sam'
    benchmark:
        'benchmarks/{sample}.samtools.benchmark.txt'
    log:
        'logs/samtools/{sample}.log'
    threads:
        4
    message:
        'executing samtools index on {input.bam} and samtools view on {input.bam} to generate {output}'
    shell:
        '(samtools index {input.bam} | samtools view -h {input.bam} > {output}) 2> {log}'