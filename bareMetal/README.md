# Multprocessing the Simulation study

## Description

This project does the parallelisation of ARFI Makita Template using GNU  parallel package for bash.  
The implementation based on GNU is suitable for other Makta templates as well.
<h6> This project was rendered with ASReview-Makita version 0.6.3.
This project was rendered from the Makita-ARFI template.

See [asreview/asreview-makita#templates](https://github.com/asreview/asreview-makita#templates) for template rules and formats. The template is described as: 'All Relevant, Fixed Irrelevant'.

## Installation

This project depends on Python 3.7 or later (python.org/download), [ASReview](https://asreview.nl/download/) and [GNU parallel](https://www.gnu.org/software/parallel/) package. Install the following dependencies to run the simulation and analysis in this project.

ASReview installation:
```python
pip install asreview asreview-insights asreview-datatools
```
GNU installation (make sure to change the NUMBER from the installed file):
```bash
wget https://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2
tar -xjf parallel-latest.tar.bz2
cd parallel-NUMBER
./configure
make
sudo make install
```




## Data

The performance on the following datasets is evaluated:

- data/van_de_Schoot_2018.csv

## Run simulation

To parallelize your `jobs.sh` file, we need to split it into blocks that can be parallelized.  
The `split-file.py` is inherited from and inspired by the Kubernetes implementation,  
and is was written by [Abel Siquera](https://github.com/abelsiqueira). 

### Steps:

1\. Run `split-file.py` script to separate `jobs.sh` file. 
```python
python split-file.py jobs.sh
```

2\.Then you can just run the script below, specifying the number of cores as an argument.
> **Warning**
> We recommend not using all of your CPU cores at once.
> Leave at least one or two to allow your machine to process other tasks.
> Notice that there is no limitation on memory usage per task, so for models that use a lot of memory, there might be some competition for resources.

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
