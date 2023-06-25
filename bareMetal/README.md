# Multprocessing the ARFI Simulation study with GNU parallel

## Description

This project does the parallelisation of ARFI Makita Template using GNU parallel package for bash.  
The implementation based on GNU is suitable for other Makta templates as well.
<h6> This project was rendered with ASReview-Makita version 0.6.3.
This project was rendered from the Makita-ARFI template.

See [asreview/asreview-makita#templates](https://github.com/asreview/asreview-makita#templates) for template rules and formats. The template is described as: ARFI 'All Relevant, Fixed Irrelevant'.

## Data

The performance on the following datasets is evaluated:

- data/van_de_Schoot_2018.csv

## Run simulation

To parallelize your `jobs.sh` file, first, we need to split it into blocks that can be parallelized.  
The `split-file.py` is inherited from and inspired by the Kubernetes implementation,  
and is was written by [Abel Siquera](https://github.com/abelsiqueira). 

### Steps:

1\. Run `split-file.py` script to separate `jobs.sh` file. 
```python
python scripts/split-file.py jobs.sh
```

2\. Then start with a non-parallelised run, specifying 1 as the number of CPUs.

```bash
bash parallel_run.sh 1
```
3\. The script will output the running time, collect it and store it. In our case time mesurements from the conducted analysis are stored in the parent directory of this repositrory in `data/experiment_resutls.csv`.
> Note
> If you want to reproduce the results of the study with max precision, do not run any
> computations or processes on your machine, as it will take CPU resources from the simulations run
> and will result in a different coputation time. By default computation time should not 
> differ in range ± 5 seconds.

4\. Remove the `output` folder with the following command: 
``` bash
rm -f -r output/
```

5\. Then you can just repeat the process from (2.) by runing the script below, specifying the number of cores as an argument. Increase the number initially to 2 CPU and then with increament of 2 (i.e. 4, 6, 8 etc.).


```bash
bash parallel_run.sh <the_number_of_cores>
```

## Structure

The following files are found in this project:

    📦
    ├── 📂data
    │   ├── 📜van_de_Schoot_2018.csv
    ├── 📂output
    │   ├── 📂simulation
    |   |   └── 📂van_de_Schoot_2018
    |   |       ├── 📂descriptives
    |   |       |   ├── 📜data_stats_van_de_Schoot_2018.json
    |   |       |   ├── 📜wordcloud_van_de_Schoot_2018.png
    |   |       |   ├── 📜wordcloud_relevant_van_de_Schoot_2018.png
    |   |       |   └── 📜wordcloud_irrelevant_van_de_Schoot_2018.png
    |   |       ├── 📂state_files
    |   |       |   ├── 📜sim_van_de_Schoot_2018_`x`.asreview
    |   |       |   └── 📜...
    |   |       ├── 📂metrics
    |   |       ├   ├── 📜metrics_sim_van_de_Schoot_2018_`x`.json
    |   |       |   └── 📜...
    |   |       └── 📜plot_recall_van_de_Schoot_2018.png
    │   └── 📂tables
    |       ├── 📜data_descriptives.csv
    |       ├── 📜data_descriptives.xlsx
    |       ├── 📜data_metrics.csv
    |       └── 📜data_metrics.xlsx
    ├── 📂scripts
    │   ├── 📜get_plot.py
    │   ├── 📜merge_descriptives.py
    │   ├── 📜merge_metrics.py
    │   ├── 📜merge_tds.py
    │   └── 📜split-file.py
    ├── 📜jobs.sh
    ├── 📜parallel_run.sh
    └── 📜README.md
