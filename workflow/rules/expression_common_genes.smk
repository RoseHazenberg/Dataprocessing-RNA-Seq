"""
Expression of the common genes using a matplot.
#expression_genes, expresses the common genes with an R script that produces an matplot as jpg
"""

rule expression_genes:
    input:
        script = 'workflow/scripts/expressionCommonGenes.R',
        common = 'mergeGeneID/Sample-1-2-common-genesCuffdiff-DESeq-edgeR.csv',
        edgeR = 'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-edgeR-results.csv'
    output:
        matplot = 'results/expressionGenes.jpg',
        volcano = 'results/volcanoPlot.jpg'
    benchmark:
        'benchmarks/commonGenesExpression.benchmark.txt'
    log:
        'logs/commonGenesExpression/commonGenesExpression.log'
    threads:
        2
    message:
        'expression of common genes with an R script {input.script} on {input.common} and {input.edgeR} '
        'to create {output.matplot} and {output.volcano}'
    shell:
        '(Rscript {input.script} {input.common} {output.matplot} {input.edgeR} {output.volcano}) 2> {log}'