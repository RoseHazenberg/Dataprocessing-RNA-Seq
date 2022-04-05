"""
Counts the reads using HTSeq
#htseq_count, count the reads from the sam and gtf files
"""

configfile: 'config/config.yaml'

rule all:
    input:
        'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-no-replicates-DESeq-results.csv'

rule computeDEG_DESeq:
    input:
        script = 'workflow/scripts/DEG_DESeq.R',
        merged = 'htseq_counts/sample-1-sample-2.txt'
    output:
        'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-no-replicates-DESeq-results.csv'
    benchmark:
        'benchmarks/computeDEG_DESeq.benchmark.txt'
    log:
        'logs/DEG/computeDEG_DESeq.log'
    threads:
        2
    message:
        'executing'
    shell:
        '(Rscript {input.script} {input.merged} {output}) 2> {log}'

rule computeDEG_edgeR:
    input:
        script = 'workflow/scripts/DEG_edgeR.R',
        merged = 'htseq_counts/sample-1-sample-2.txt'
    output:
        'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-no-replicates-DESeq-results.csv'
    benchmark:
        'benchmarks/computeDEG_edgeR.benchmark.txt'
    log:
        'logs/DEG/computeDEG_edgeR.log'
    threads:
        2
    message:
        'executing'
    shell:
        '(Rscript {input.script} {input} {output}) 2> {log}'