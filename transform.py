import pandas as pd
import os
from pathlib import Path
from typing import List
from copy import deepcopy

base_dir = Path(os.path.dirname(os.path.abspath(__file__)))


def get_file_list(path: Path) -> List[Path]:
    return [
        file_
        for x in path.iterdir()
        if x.is_dir()
        for item in x.iterdir()
        if item.name == "stats"
        for file_ in item.iterdir()
        if file_.name.endswith(".txt")
    ]


def transform_to_csv(files: List[Path]) -> None:
    for file_ in files:
        values_list = list()
        with open(file_, "r") as f:
            row = dict()
            while line := f.readline():
                value, *column = line.split(" ")
                column = " ".join(column).strip("[").strip("]").strip("\n")
                row[column] = value
                if len(row) == 26:
                    values_list.append(deepcopy(row))
                    row.clear()
        df = pd.DataFrame(values_list)
        df.to_csv(file_.with_suffix(".csv"), index=False)


if __name__ == "__main__":
    apache_path = base_dir /  "data" / "vm" /"apache"
    nginx_path = base_dir / "data" / "vm" /"nginx"
    for folder in [apache_path, nginx_path]:
        files = get_file_list(folder)
        transform_to_csv(files)
