import random
import seq_utils

def dummy_blast_results(seq_df, output_csv):
    # Randomly assign either 'dummy_NR1' or 'dummy_NR4' to each sequence
    seq_df['blast_results'] = [random.choice(['dummy_NR1', 'dummy_NR4']) for _ in range(len(seq_df))]

    # Write the updated DataFrame to CSV
    seq_df.to_csv(output_csv, index=False)


def main():
    fasta = snakemake.input.generated_sequences
    output_csv = snakemake.output.blast_csv

    seq_df = seq_utils.get_sequence_df(fasta)

    dummy_blast_results(seq_df, output_csv)


if __name__ == "__main__":
    main()
