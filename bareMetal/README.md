# Simulation study

*This project was rendered with ASReview-Makita version 0.6.3.*

This project was rendered from the Makita-ARFI template. See [asreview/asreview-makita#templates](https://github.com/asreview/asreview-makita#templates) for template rules and formats.

The template is described as: 'All Relevant, Fixed Irrelevant'.

## Installation

This project depends on Python 3.7 or later (python.org/download), and [ASReview](https://asreview.nl/download/). Install the following dependencies to run the simulation and analysis in this project.

```sh
pip install asreview asreview-insights asreview-datatools
```

## Data

The performance on the following datasets is evaluated:

- data/van_de_Schoot_2018.csv

## Run simulation

To start the simulation, run the following command in the project directory.

```sh
sh jobs.sh
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
    │   └── 📜...
    ├── 📜jobs.sh
    └── 📜README.md
