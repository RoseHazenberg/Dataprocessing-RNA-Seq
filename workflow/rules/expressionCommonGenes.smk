"""
Expression of the common genes using a matplot.
#expressionGenes, expresses the common genes with an R script that produces an matplot as jpg
"""

# configfile: 'config/config.yaml'
#
# rule all:
#     input:
#         'results/expressionGenes.jpg'

rule expressionGenes:
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
        'expression of common genes'
    shell:
        '(Rscript {input.script} {input.common} {output}) 2> {log}'