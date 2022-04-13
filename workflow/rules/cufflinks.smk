"""
Transcript identification using cufflinks.
Merges assembled transcriptome from gtf files with cuffmerge.
Differential gene expression using cuffdiff from two samples.
#cufflinks, uses cufflinks on both samples to identify transcripts.
#cuffmerge, uses cuffmerge to merge assembled transcriptomes from gtf files
#cuffdiff, uses cuffdiff to generate differentially expressed genes
"""

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


rule cuffmerge:
    input:
        gtf = config['annotation'],
        fa = config['genome'],
        assembly = config['assembly']
    output:
        'merged_asm/merged.gtf'
    benchmark:
        'benchmarks/cuffmerge.benchmark.txt'
    log:
        'logs/cuffmerge/cuffmerge.log'
    threads:
        8
    message:
        'executing cuffmerge with {input.gtf} {input.fa} {input.assembly}'
    shell:
        '(cuffmerge -g {input.gtf} -s {input.fa} -p 6 {input.assembly} > log.out) 2> {log}'


rule cuffdiff:
    input:
        bam = expand('alignment/{sample}-aligned-tophat/accepted_hits.bam', sample = config['samples']),
        fa = config['genome'],
        merged = config['merged']
    output:
        directory('cuffdiff/diff_out_quartile')
    benchmark:
        'benchmarks/cuffdiff.benchmark.txt'
    log:
        'logs/cuffdiff/out.log'
    threads:
        8
    message:
        'executing cuffdiff on {input.bam} with {input.fa} {input.merged} to generate {output}'
    shell:
        '(cuffdiff -o {output} -b {input.fa} -p 6 -L SRR2073144,SRR2073145 -u {input.merged} {input.bam} --library-norm-method quartile --multi-read-correct) 2> {log}'