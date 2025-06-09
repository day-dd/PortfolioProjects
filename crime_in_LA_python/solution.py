# (source: https://www.datacamp.com/projects/1876)
# The goal is to analyze crime data from crimes.csv to identify patterns in criminal behavior.

# Questions to answer:
# 1) Which hour has the highest frequency of crimes?
# 2) Which area has the largest frequency of night crimes (crimes committed between 10pm and 3:59am)?
# 3) Identify the number of crimes committed against victims of different age groups (0-17, 18-25, 26-34, 35-44, 45-54, 55-64, 65+).

# ----- Solution ------

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
crimes = pd.read_csv("crimes.csv", dtype={"TIME OCC": str})
crimes.head()

# 1) Which hour has the highest frequency of crimes?
# Extracting the first two digits from "TIME OCC", representing the hour, and converting to integer data type
crimes["HOUR OCC"] = crimes["TIME OCC"].str[:2].astype(int)
# Producing a countplot to find the largest frequency of crimes by hour
sns.countplot(data=crimes, x="HOUR OCC")
plt.show()
# Answer 1: 12pm is the peak crime hour. See crimes_per_hour_distribution.png for the countplot plotted with Seaborn
peak_crime_hour = 12

# 2) Which area has the largest frequency of night crimes (crimes committed between 10pm and 3:59am)?
# Defining night hours
night_time = crimes[crimes["HOUR OCC"].isin([22,23,0,1,2,3])]
# Grouping by "AREA NAME" and counting occurrences, filtering for the largest value and saving the "AREA NAME"
peak_night_crime_location = night_time.groupby("AREA NAME", as_index=False)["HOUR OCC"].count().sort_values("HOUR OCC", ascending=False).iloc[0]["AREA NAME"]
print(f"The area with the largest frequency of night crimes is {peak_night_crime_location}")
# Answer 2: Central is the area with the largest frequency of night crimes

# 3) Identify the number of crimes committed against victims of different age groups (0-17, 18-25, 26-34, 35-44, 45-54, 55-64, 65+).
# Creating bins
age_bins = [0, 17, 25, 34, 44, 54, 64, np.inf]
age_labels = ["0-17", "18-25", "26-34", "35-44", "45-54", "55-64", "65+"]

# Adding a new column using pd.cut() to bin values into discrete intervals
crimes["Age Bracket"] = pd.cut(crimes["Vict Age"],
                               bins=age_bins,
                               labels=age_labels)

# Finding the category with the highest volume
victim_ages = crimes["Age Bracket"].value_counts()
print(victim_ages)

# Answer 3: 
# 26-34    47470
# 35-44    42157
# 45-54    28353
# 18-25    28291
# 55-64    20169
# 65+      14747
# 0-17      4528
# Name: Age Bracket, dtype: int64


