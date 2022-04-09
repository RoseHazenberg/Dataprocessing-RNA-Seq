"""
Counts the reads using HTSeq
#htseq_count, counts the reads from the sam and gtf files
"""

# configfile: 'config/config.yaml'
# SAMPLES = ['SRR2073144', 'SRR2073145']
#
# rule all:
#     input:
#         expand('htseq_counts/{sample}-read-counts.out', sample = SAMPLES)

rule htseq_count:
    input:
        sam = 'alignment/{sample}-aligned-tophat/accepted_hits.sam',
        gtf = config['annotation']
    output:
        'htseq_counts/{sample}-read-counts.out'
    benchmark:
        'benchmarks/{sample}.htseq.benchmark.txt'
    log:
        'logs/htseq/{sample}.log'
    threads:
        16
    message:
        'executing htseq-conut {input.sam} with {input.gtf} to generate {output}'
    shell:
        '(htseq-count {input.sam} {input.gtf} > {output}) 2> {log}'
