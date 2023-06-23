

# version 0.6.3

# Create folder structure. By default, the folder 'output' is used to store output.
mkdir output
mkdir output/simulation

##################################
### DATASET: van_de_Schoot_2018
##################################
# Create output folder
mkdir output/simulation/van_de_Schoot_2018/
mkdir output/simulation/van_de_Schoot_2018/metrics

# Collect descriptives about the dataset
mkdir output/simulation/van_de_Schoot_2018/descriptives
asreview data describe data/van_de_Schoot_2018.csv -o output/simulation/van_de_Schoot_2018/descriptives/data_stats_van_de_Schoot_2018.json

# Generate wordcloud visualizations of all datasets
asreview wordcloud data/van_de_Schoot_2018.csv -o output/simulation/van_de_Schoot_2018/descriptives/wordcloud_van_de_Schoot_2018.png --width 800 --height 500
asreview wordcloud data/van_de_Schoot_2018.csv -o output/simulation/van_de_Schoot_2018/descriptives/wordcloud_relevant_van_de_Schoot_2018.png --width 800 --height 500 --relevant
asreview wordcloud data/van_de_Schoot_2018.csv -o output/simulation/van_de_Schoot_2018/descriptives/wordcloud_irrelevant_van_de_Schoot_2018.png --width 800 --height 500 --irrelevant

# Simulate runs, collect metrics and create plots
mkdir output/simulation/van_de_Schoot_2018/state_files
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_51.asreview --prior_record_id 51 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_51.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_51.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_116.asreview --prior_record_id 116 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_116.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_116.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_462.asreview --prior_record_id 462 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_462.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_462.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_730.asreview --prior_record_id 730 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_730.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_730.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_767.asreview --prior_record_id 767 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_767.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_767.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_831.asreview --prior_record_id 831 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_831.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_831.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_902.asreview --prior_record_id 902 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_902.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_902.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_953.asreview --prior_record_id 953 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_953.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_953.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1033.asreview --prior_record_id 1033 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1033.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1033.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1180.asreview --prior_record_id 1180 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1180.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1180.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1248.asreview --prior_record_id 1248 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1248.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1248.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1356.asreview --prior_record_id 1356 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1356.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1356.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1429.asreview --prior_record_id 1429 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1429.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1429.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1514.asreview --prior_record_id 1514 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1514.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1514.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1554.asreview --prior_record_id 1554 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1554.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1554.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1565.asreview --prior_record_id 1565 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1565.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1565.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1746.asreview --prior_record_id 1746 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1746.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1746.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1881.asreview --prior_record_id 1881 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1881.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1881.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1994.asreview --prior_record_id 1994 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_1994.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_1994.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2279.asreview --prior_record_id 2279 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2279.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_2279.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2496.asreview --prior_record_id 2496 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2496.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_2496.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2545.asreview --prior_record_id 2545 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2545.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_2545.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2624.asreview --prior_record_id 2624 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2624.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_2624.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2740.asreview --prior_record_id 2740 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2740.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_2740.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2803.asreview --prior_record_id 2803 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_2803.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_2803.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3076.asreview --prior_record_id 3076 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3076.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_3076.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3314.asreview --prior_record_id 3314 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3314.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_3314.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3442.asreview --prior_record_id 3442 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3442.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_3442.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3608.asreview --prior_record_id 3608 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3608.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_3608.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3680.asreview --prior_record_id 3680 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3680.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_3680.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3769.asreview --prior_record_id 3769 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3769.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_3769.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3842.asreview --prior_record_id 3842 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_3842.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_3842.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4154.asreview --prior_record_id 4154 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4154.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_4154.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4201.asreview --prior_record_id 4201 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4201.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_4201.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4269.asreview --prior_record_id 4269 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4269.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_4269.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4327.asreview --prior_record_id 4327 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4327.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_4327.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4377.asreview --prior_record_id 4377 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4377.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_4377.json
asreview simulate data/van_de_Schoot_2018.csv -s output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4461.asreview --prior_record_id 4461 231 36 3065 4202 2193 694 1944 785 291 3867 --seed 165
asreview metrics output/simulation/van_de_Schoot_2018/state_files/sim_van_de_Schoot_2018_4461.asreview -o output/simulation/van_de_Schoot_2018/metrics/metrics_sim_van_de_Schoot_2018_4461.json

# Generate plot for dataset
python scripts/get_plot.py -s output/simulation/van_de_Schoot_2018/state_files/ -o output/simulation/van_de_Schoot_2018/plot_recall_sim_van_de_Schoot_2018.png

# Merge descriptives and metrics
python scripts/merge_descriptives.py
python scripts/merge_metrics.py
python scripts/merge_tds.py