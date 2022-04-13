"""
Expression of the common genes using a matplot.
#expression_genes, expresses the common genes with an R script that produces an matplot as jpg
"""

rule expression_genes:
    input:
        script = 'workflow/scripts/expressionCommonGenes.R',
        common = 'mergeGeneID/Sample-1-2-common-genesCuffdiff-DESeq-edgeR.csv'
    output:
        'results/expressionGenes.jpg'
    benchmark:
        'benchmarks/commonGenesExpression.benchmark.txt'
    log:
        'logs/commonGenesExpression/commonGenesExpression.log'
    threads:
        2
    message:
        'expression of common genes with an R script {input.script} on {input.common} to create {output}'
    shell:
        '(Rscript {input.script} {input.common} {output}) 2> {log}'