"""
Merges assembled transcriptome from gtf files with cuffmerge
#cuffmerge, uses cuffmerge to merge assembled transcriptomes from gtf files
"""
#
# configfile: 'config/config.yaml'
# SAMPLES = ['SRR2073144', 'SRR2073145']

rule cuffmerge:
    input:
        gtf = config['annotation'],
        fa = config['genome'],
        assembly = config['assembly']
    benchmark:
        'benchmarks/cuffmerge.benchmark.txt'
    log:
        'logs/cuffmerge/cuffmerge.log'
    threads:
        4
    message:
        'executing cuffmerge with gtf files {input.gtf}'
    shell:
        '(cuffmerge -g {input.gtf} -s {input.fa} -p 6 {input.assembly} > log.out) 2> {log}'
