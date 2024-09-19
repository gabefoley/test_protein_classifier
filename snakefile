try:
    NUM_REPLICATES = config['num_replicates']
except KeyError:
    NUM_REPLICATES = 3

try:
    DATASET_PATH = config['dataset_path']
except KeyError:
    DATASET_PATH = './data/'

try:
    ALL_DATASET_NAMES = config['all_dataset_names']
except KeyError:
    ALL_DATASET_NAMES = ['NR4_NR1_ancestors']

rule all:
    input:
        generate_sequences = expand(
        "workflows/{dataset_name}/fasta/{dataset_name}_{rep}.fasta",
        dataset_name=ALL_DATASET_NAMES,
        rep=range(1, NUM_REPLICATES + 1)
        ),

rule generate_mutations:
    input:
        fasta=DATASET_PATH + "{dataset_name}.fasta"
    output:
        generated_sequences="workflows/{dataset_name}/fasta/{dataset_name}_{rep}.fasta",
    script:
        "scripts/generate_mutations.py"


rule run_interproscan:
    input:
        generated_sequences="workflows/{dataset_name}/fasta/{dataset_name}_{rep}.fasta",
    output:
        interproscan_csv="workflows/{dataset_name}/interproscan/{dataset_name}_{rep}.csv",
    script:
        "scripts/generate_sequences.py"


rule generate_embeddings:
    input:
        generated_sequences="workflows/{dataset_name}/fasta/{dataset_name}_{rep}.fasta",
    output:
        embedding_csv="workflows/{dataset_name}/embeddings/{dataset_name}_{rep}.csv",
    script:
        "scripts/generate_sequences.py"

rule run_blast:
    input:
        generated_sequences="workflows/{dataset_name}/fasta/{dataset_name}_{rep}.fasta",
    output:
        blast_csv="workflows/{dataset_name}/blast/{dataset_name}_{rep}.csv",
    script:
        "scripts/generate_sequences.py"

rule merge_outputs:
    input:
        generated_sequences="workflows/{dataset_name}/fasta/{dataset_name}_{rep}.fasta",
        interproscan_csv="workflows/{dataset_name}/interproscan/{dataset_name}_{rep}.csv",
        embedding_csv="workflows/{dataset_name}/embeddings/{dataset_name}_{rep}.csv",
        blast_csv="workflows/{dataset_name}/blast/{dataset_name}_{rep}.csv",

    output:
        merged_csv="workflows/{dataset_name}/merged/{dataset_name}_{rep}.csv",
    script:
        "scripts/merge_sequences.py"