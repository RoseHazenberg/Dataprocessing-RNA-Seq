"""
Differential gene expression using cuffdiff from two samples
#cuffdiff, performs differential expression analysis with GTF and BAM files
"""

# configfile: 'config/config.yaml'

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
        4
    message:
        'executing cuffdiff on {input.bam}'
    shell:
        '(cuffdiff -o {output} -b {input.fa} -p 6 -L SRR2073144,SRR2073145 -u {input.merged} {input.bam} --library-norm-method quartile --multi-read-correct) 2> {log}'
