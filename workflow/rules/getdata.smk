"""
Downloads the SRR2073144.sra and SRR2073145.sra and converts the SRA files to Fastq files.
Prefetch is used to download and fastq-dump is used to convert to fastq.
#download_and_convert, downloads the sra data with prefetch and convert the sra files into fastq files with fastq-dump
for both sample SRR2073144 and SRR2073145
"""

rule download_and_convert:
    params:
        '{sample}'
    output:
        sra = directory('sra_data/{sample}'),
        fastq = directory('fastq_data/{sample}')
    benchmark:
        'benchmarks/{sample}.prefetch/fastq-dump.benchmark.txt'
    log:
        'logs/prefetch-fastq-dump/{sample}.log'
    threads:
        4
    message:
        'download file: {params} to {output.sra} and convert with fastq-dump to {output.fastq}'
    shell:
        '(prefetch {params} -O {output.sra} && fastq-dump {params} -O {output.fastq}) 2> {log}'