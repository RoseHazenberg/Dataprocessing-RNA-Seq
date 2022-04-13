"""
Merges the read counts with an R script.
#merge_read_counts, merges the read counts from the htseq-count output
"""

rule merge_read_counts:
    input:
        script = 'workflow/scripts/mergeReadCounts.R',
        S44 = 'htseq_counts/SRR2073144-read-counts.out',
        S45 = 'htseq_counts/SRR2073145-read-counts.out'
    output:
        'htseq_counts/sample-1-sample-2.txt'
    benchmark:
        'benchmarks/mergeReadCounts.htseq.benchmark.txt'
    log:
        'logs/htseq/mergeReadCounts.log'
    threads:
        2
    message:
        'merge {input.S44} and {input.S45} with {input.script} to generate {output}'
    shell:
        """
        sed -i '1i GeneID\t\tSample-SRR2073144' {input.S44} &&
        sed -i '1i GeneID\t\tSample-SRR2073145' {input.S45} &&
        (Rscript {input.script} {input.S44} {input.S45} {output}) 2> {log}
        """