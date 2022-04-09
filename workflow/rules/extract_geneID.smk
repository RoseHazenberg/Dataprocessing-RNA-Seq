"""
Extract the gene IDs, performing commands in the shell.
#extract_geneID, extract the gene name and id from merged.gtf
"""

# configfile: 'config/config.yaml'

rule extract_geneID:
    input:
        gtf = 'merged_asm/merged.gtf'
    output:
        directory('extract/')
    benchmark:
        'benchmarks/extractGeneID.benchmark.txt'
    log:
        'logs/extract/extractGeneID.log'
    threads:
        4
    message:
        'extracting gene id from {input.gtf}'
    shell:
        """
        (cut -f9 {input.gtf} > extract/col-9.txt &&
        cut -d';' -f4 extract/col-9.txt > extract/genename.txt &&
        cut -d';' -f5 extract/col-9.txt > extract/geneid1.txt && 
        sed 's/gene_name //g' extract/genename.txt > extract/genename1.txt && 
        sed 's/"//g' extract/genename1.txt > extract/genename2.txt &&
        sed '1i\gene\' extract/genename2.txt > extract/genename3.txt && 
        sed 's/oId //g' extract/geneid1.txt > extract/geneid2.txt &&
        sed 's/"//g' extract/geneid2.txt > extract/geneid3.txt &&
        sed '1i\id\' extract/geneid3.txt > extract/geneid4.txt &&
        paste -d',' extract/genename3.txt extract/geneid4.txt > extract/geneid_genename.txt &&
        rm extract/col-9.txt extract/genename.txt extract/geneid1.txt extract/genename1.txt extract/genename2.txt extract/geneid2.txt extract/geneid3.txt) 2> {log}
        """








