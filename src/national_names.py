import os
import pandas as pd

base_path = os.path.join("input", "names", "yob")

data = pd.DataFrame()

for year in range(1880, 2015):
    year_data = pd.read_csv(base_path+str(year)+".txt",
                            header=None,
                            names=["Name", "Gender", "Count"])
    year_data.insert(1, "Year", year)
    data = pd.concat([data, year_data])

data.insert(0, "Id", list(range(1, len(data)+1)))
data.to_csv("output/NationalNames.csv", index=False)
