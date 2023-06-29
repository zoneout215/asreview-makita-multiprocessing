# Multprocessing the ARFI Simulation study with GNU parallel

## Description

This project does the parallelisation of ARFI Makita Template using GNU parallel package for bash.  
The implementation based on GNU is suitable for other Makta templates as well.
<h6> This project was rendered with ASReview-Makita version 0.6.3.
This project was rendered from the Makita-ARFI template.

See [asreview/asreview-makita#templates](https://github.com/asreview/asreview-makita#templates) for template rules and formats. The template is described as: ARFI 'All Relevant, Fixed Irrelevant'.

## Table of contents
* `data` contains the information about the dataset used in the study
* `output` contains the output of the simulations
* `scripts` contains the scripts to run the simulations
* `bare-metal-reproduction.ipynb` contains the example of run the simulations on bare CPUs. Here the resutls can be easily reproduced with this notebook
* `jobs.sh` contains the commands to run the simulations
* `parallel_run.sh` contains the commands to run the `jobs.sh` in parallel
* `README.md` contains the description of the bareMetalproject

## Data

The performance on the following datasets is evaluated:

- data/van_de_Schoot_2018.csv

## How to run the simulations

To parallelize your `jobs.sh` file, first, we need to split it into blocks that can be parallelized.  
The `split-file.py` is inherited from and inspired by the Kubernetes implementation,  
and is was written by [Abel Siquera](https://github.com/abelsiqueira). 

### Steps:

0\. Go to `data` folder and follow the instructions in the `README.md` there.
> **Note**
> You can use the `bareMetal_reproduction.ipynb` notebook to reproduce the results of the study with ease, but also you can run the following steps in the CLI.

1\. Account for the fact that by default SURF uses `python3` as a command to run python scripts.
So you should either change `python` to `python3` in the `jobs.sh` file or move the `python3` interpreter to `python` with the following command:

```bash
cd /usr/bin
sudo mv -s python3 python
```

If you chose to move the interpreter, check the path to the interpreter with the following command:
```bash
which python
```
It should output `/usr/bin/python` if you moved the interpreter correctly.

2\. Run `split-file.py` script to separate `jobs.sh` file. 
```python
python scripts/split-file.py jobs.sh
```

3\. Then start with a non-parallelised run, specifying 1 as the number of CPUs.

```bash
bash parallel_run.sh 1
```
3\. The script will output the running time, collect it and store it. In our case time mesurements from the conducted analysis are stored in the parent directory of this repositrory in `resultsData/experiment_resutls.csv`.
> Note
> If you want to reproduce the results of the study with max precision, do not run any
> computations or processes on your machine, as it will take CPU resources from the simulations run
> and will result in a different coputation time. By default computation time should not 
> differ in range ± 5 seconds.

5\. Remove the `output` folder with the following command: 
``` bash
rm -f -r output/
```

6\. Then you can just repeat the process from (2.) by runing the script below, specifying the number of cores as an argument. Increase the number initially to 2 CPU and then with increament of 2 (i.e. 4, 6, 8 etc.).

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
    ├── 📜bareMetal_reproduction.ipynb
    └── 📜README.md

### Citations
* De Bruin, J., Ma, Y., Ferdinands, G., Teijema, J., & Van de Schoot, R. (2023). SYNERGY - Open machine learning dataset on study selection in systematic reviews. DataverseNL. https://doi.org/10.34894/HE6NAQ
* Van De Schoot, R., Sijbrandij, M., Winter, S. D., Depaoli, S., & Vermunt, J. K. (2017). The GRoLTS-checklist: guidelines for reporting on latent trajectory studies. Structural Equation Modeling: A Multidisciplinary Journal, 24(3), 451-467.
