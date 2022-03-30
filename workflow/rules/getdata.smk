SAMPLES = ['SRR2073144', 'SRR2073145']

rule all:
    input:
        expand('data/{sample}', sample = SAMPLES)

rule download:
    params:
        '{sample}'
    output:
        directory('data/{sample}')
    shell:
        'prefetch {params} -O {output}'


