"""
Merges the read counts of the samples using gene identifier.
#mergeReadCounts, merges the read counts with an R script
"""

# configfile: 'config/config.yaml'
#
# rule all:
#     input:
#         'htseq_counts/sample-1-sample-2.txt'

rule mergeReadCounts:
    input:
        script = 'workflow/scripts/mergeReadCounts.R',
        S44 = 'htseq_counts/SRR2073144-read-counts.out',
        S45 = 'htseq_counts/SRR2073145-read-counts.out'
    output:
        'htseq_counts/sample-1-sample-2.txt'
    benchmark:
        'benchmarks/mergeReadCounts.htseq.benchmark.txt'
    log:
        'logs/htseq/mergeReadCounts.log'
    threads:
        2
    message:
        'executing'
    shell:
        '(Rscript {input.script} {input.S44} {input.S45} {output}) 2> {log}'
