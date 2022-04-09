"""
Merges DEG genes from cuffdiff, DESeq and edgeR in individual sample pairs.
#mergeGeneID, merges the gene ids from cuffdiff, DESeq and edgeR
"""

# configfile: 'config/config.yaml'
#
# rule all:
#     input:
#         'mergeGeneID/Sample-1-Sample-2-significantpadj-lessthan-0.05-Cuffdiff-results.csv',
#         'mergeGeneID/Sample-1-Sample-2-significantpadj-lessthan-0.05-DESeq-results.csv',
#         'mergeGeneID/Sample-1-Sample-2-significantpadj-lessthan-0.05-edgeR-results.csv',
#         'mergeGeneID/Sample-1-2-common-genesCuffdiff-DESeq-edgeR.csv'


rule mergeGeneID:
    input:
        script = 'workflow/scripts/mergeGeneIDCuffDiff.R',
        geneid = 'extract/geneid_genename.txt',
        cuf = 'cuffdiff/diff_out_quartile/gene_exp.diff',
        deseq = 'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-DESeq-results.csv',
        egdeR = 'DEG/Sample-1-Sample-2-significant-padj-lessthan-0.05-edgeR-results.csv'
    output:
        cuf = 'mergeGeneID/Sample-1-Sample-2-significantpadj-lessthan-0.05-Cuffdiff-results.csv',
        deseq = 'mergeGeneID/Sample-1-Sample-2-significantpadj-lessthan-0.05-DESeq-results.csv',
        edgeR = 'mergeGeneID/Sample-1-Sample-2-significantpadj-lessthan-0.05-edgeR-results.csv',
        both = 'mergeGeneID/Sample-1-2-common-genesCuffdiff-DESeq-edgeR.csv'
    benchmark:
        'benchmarks/mergedGeneID.benchmark.txt'
    log:
        'logs/mergedGeneID/mergedGeneID.log'
    threads:
        2
    message:
        'merging gene id'
    shell:
        '(Rscript {input.script} {input.cuf} {input.deseq} {input.egdeR} {input.geneid} {output.cuf} {output.deseq} {output.edgeR} {output.both}) 2> {log}'