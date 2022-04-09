"""
Perform read alignment using tophat.
#tophat_alignment, aligns reads for both the sample using tophat with multiple arguments
"""

# configfile: 'config/config.yaml'
# SAMPLES = ['SRR2073144', 'SRR2073145']
#
# rule all:
#     input:
#         expand('alignment/{sample}-aligned-tophat', sample = SAMPLES)

rule tophat_alignment:
    input:
        SRA = 'cutadapt/{sample}_trimmed.fastq',
        gtf = config['annotation']
    output:
        directory('alignment/{sample}-aligned-tophat')
    benchmark:
        'benchmarks/{sample}.tophat.aligned.benchmark.txt'
    log:
        'logs/tophat-aligned/{sample}.log'
    threads:
        8
    message:
        'executing tophat on {input.SRA} which produces {output}'
    shell:
        '(python2 {config[tophat]} -p 8 --max-multihits 1 -i 40 -I 5000 --library-type fr-unstranded --b2-very-sensitive \
         --segment-length 20 --segment-mismatches 2 -F 0 -g 1 -a 10 -G {input.gtf} -o {output} \
         references/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome {input.SRA}) 2> {log}'
