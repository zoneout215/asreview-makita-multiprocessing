# Data
This folder should contain `van_de_Schoot_2018.csv` file from [Synergy datasets](https://github.com/asreview/synergy-dataset) if you want to reproduce the results.

To acquire data do these steps:

1\. Make sure you have `pip` and install the `synergy-dataset package` running this command

```bash
pip install synergy-dataset
```

2\. Dowload the data running this command from the `data` directory to put the dataset in this folder
```bash
synergy get -d van_de_Schoot_2018 -l
mv synergy_dataset/van_de_Schoot_2018.csv ../data 
rm -f -r synergy_dataset/
```

> **Note**
> To download the data for other simulation folder, repeat the process