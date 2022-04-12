"""
Counts the reads using HTSeq
#htseq_count, count the reads from the sam and gtf files
"""

rule htseq_count:
    input:
        sam = 'alignment/{sample}-samtools/accepted_hits.sam',
        gtf = config['annotation']
    output:
        'htseq_counts/{sample}-read-counts.out'
    benchmark:
        'benchmarks/{sample}.htseq.benchmark.txt'
    log:
        'logs/htseq/{sample}.log'
    threads:
        16
    message:
        'executing htseq-count {input.sam} with {input.gtf} to generate {output}'
    shell:
        '(htseq-count {input.sam} {input.gtf} > {output}) 2> {log}'