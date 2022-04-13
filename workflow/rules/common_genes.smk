"""
Extracts the common genes from the cuffdiff, DESeq and edgeR files.
#common_genes, extract the common genes and gene id names with an R script
"""

rule common_genes:
    input:
        script = 'workflow/scripts/extractCommonGenes.R',
        common = 'mergeGeneID/Sample-1-2-common-genesCuffdiff-DESeq-edgeR.csv'
    output:
        csv = 'commonGenes/Sample-1-2-common-genes-C-DE.csv',
        idname = 'commonGenes/Sample-1-2-common-genes-C-D-E-idname.csv'
    benchmark:
        'benchmarks/commonGenes.benchmark.txt'
    log:
        'logs/commonGenes/commonGenes.log'
    threads:
        2
    message:
        'extracting common genes from {input.common} with an R script {input.script} to generate {output.csv} and {output.idname}'
    shell:
        '(Rscript {input.script} {input.common} {output.csv} {output.idname}) 2> {log}'