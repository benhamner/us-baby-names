import os
import pandas as pd

base_path = "input/namesbystate/"
data = pd.DataFrame()

for state in [x[:2] for x in os.listdir("input/namesbystate") if len(x)==6]:
    state_data = pd.read_csv(base_path + state + ".TXT",
                             header=None,
                             names=["State", "Gender", "Year", "Name", "Count"])
    data = pd.concat([data, state_data])

data = data[["Name", "Year", "Gender", "State", "Count"]]
data.insert(0, "Id", list(range(1, len(data)+1)))
data.to_csv("output/StateNames.csv", index=False)
