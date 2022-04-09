"""
Transcript identification using cufflinks
#cufflinks, uses cufflinks on both samples to identify transcripts.
"""

# configfile: 'config/config.yaml'
# SAMPLES = ['SRR2073144', 'SRR2073145']
#
# rule all:
#     input:
#         expand('cufflinks/{sample}-cufflinks', sample = SAMPLES)

rule cufflinks:
    input:
        gtf = config['annotation'],
        bam = 'alignment/{sample}-aligned-tophat/accepted_hits.bam'
    output:
        directory('cufflinks/{sample}-cufflinks')
    benchmark:
        'benchmarks/{sample}.cufflinks.benchmark.txt'
    log:
        'logs/cufflinks/{sample}.log'
    threads:
        4
    message:
        'executing cufflinks with gtf file {input.gtf} to {output} on {input.bam}'
    shell:
        '(cufflinks -I 5000 --min-intron-length 40 -G {input.gtf} -p 6 -o {output} {input.bam}) 2> {log}'

