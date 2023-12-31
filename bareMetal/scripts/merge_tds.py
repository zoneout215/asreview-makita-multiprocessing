"""Script to merge td files.

Example
-------

> python scripts/merge_tds.py

or

> python scripts/merge_tds.py -s output/simulation/*/metrics_sim*.json

or

> python scripts/merge_tds.py -o output/my_table.json

Authors
-------
- Teijema, Jelle
- De Bruin, Jonathan
"""

# version 0.6.3

import argparse
import glob
import json
from pathlib import Path
import pandas as pd


def create_table_state_tds(metrics):
    values = []

    for metric in metrics:
        with open(metric) as f:
            i = next(filter(lambda x: x['id'] == 'td', json.load(f)['data']['items']))['value']
            values.extend(i)

    df = pd.DataFrame(values, columns=['record_id', 'td'])
    return df.groupby('record_id').mean()


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description="Merge tds of multiple metrics into single table."
    )
    parser.add_argument(
        "-s",
        type=str,
        default="output/simulation/*/metrics/metrics_sim_*.json",
        help="metrics location")
    parser.add_argument(
        "-o",
        type=str,
        default="output/tables/data_tds.csv",
        help="Output table location")
    args = parser.parse_args()

    # load metrics
    metrics = glob.glob(args.s)

    # merge results
    result = create_table_state_tds(metrics)

    # store result in output folder
    Path(args.o).parent.mkdir(parents=True, exist_ok=True)
    result.to_csv(Path(args.o))
    result.to_excel(Path(args.o).with_suffix('.xlsx'))
