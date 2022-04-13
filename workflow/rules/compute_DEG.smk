"""
Runs DESeq and edgeR on the sample pairs to obtain differentially expressed genes.
#compute_DEG_DESeq, uses DESeq with an R script to obtain DEGs
#compute_DEG_edgeR, uses edgeR with an R script to obtain DEGs
"""

rule compute_DEG_DESeq:
    input:
        script = 'workflow/scripts/DEG_DESeq.R',
        merged = 'htseq_counts/sample-1-sample-2.txt'
    output:
        'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-DESeq-results.csv'
    benchmark:
        'benchmarks/computeDEG_DESeq.benchmark.txt'
    log:
        'logs/DEG/computeDEG_DESeq.log'
    threads:
        2
    message:
        'computing Differentially Expressed Genes from {input.merged} using DESeq'
    shell:
        '(Rscript {input.script} {input.merged} {output}) 2> {log}'

rule compute_DEG_edgeR:
    input:
        script = 'workflow/scripts/DEG_edgeR.R',
        merged = 'htseq_counts/sample-1-sample-2.txt'
    output:
        'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-edgeR-results.csv'
    benchmark:
        'benchmarks/computeDEG_edgeR.benchmark.txt'
    log:
        'logs/DEG/computeDEG_edgeR.log'
    threads:
        2
    message:
        'computing Differentially Expressed Genes from {input.merged} using edgeR'
    shell:
        '(Rscript {input.script} {input.merged} {output}) 2> {log}'