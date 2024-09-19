Notes 

- Needs 'ancestor_embedding_df.csv' to be placed in data folder
- Only running Gene3D and PRINTS interproscan atm (can update this in the call to interproscan in snakefile)
- Running the local version of interproscan
- The embeddings are saved weirdly in the merged df
- Currently needs the NR1_ids.txt / NR4_ids.txt and uses these to classify the original ancestor df
- Quite a bit of hardcoded stuff, especially in plot_pca + merge_outputs
- run_blast is just a dummy script for now
- The random seed is just set new each time, but should either be specified or saved somewhere
- Not currently deleting the /temp folder that is created after running interproscan