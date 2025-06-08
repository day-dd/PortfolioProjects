# (source: https://www.datacamp.com/projects/1674)
# The goal of the project is to perform exploratory data analysis to research movies released in the 1990's based on th data provided in netflix_data.csv

# Questions to answer:
# 1) What was the most frequent movie duration in the 1990s?
# 2) What's the number of short action movies released in the 1990s? A movie is considered short if it is less than 90 minutes.
# Here you will find 2 solutions: using pandas, and using numpy (in the comments below)

# Below is the description of netflix_data.csv:
# Column	Description
# show_id	The ID of the show
# type	Type of show
# title	Title of the show
# director	Director of the show
# cast	Cast of the show
# country	Country of origin
# date_added	Date added to Netflix
# release_year	Year of Netflix release
# duration	Duration of the show in minutes
# description	Description of the show
# genre	Show genre

# ----- Solution with pandas-----
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read in the Netflix CSV as a DataFrame
netflix_df = pd.read_csv("netflix_data.csv", index_col = 0)

# 1) What was the most frequent movie duration in the 1990s?
year1990plus_subset = netflix_df[netflix_df['release_year'] >= 1990]
year1900s_subset = year1990plus_subset[year1990plus_subset['release_year'] < 2000]
movies1990s_subset = year1900s_subset[year1900s_subset['type'] == 'Movie']

plt.hist(movies1990s_subset['duration'])
plt.title('Distribution of Movie Durations in the 1990s')
plt.xlabel('Duration of movies')
plt.ylabel('Number of movies')
plt.show()

# Answer 1: The most frequent movie duration in the 1990s was 100 minutes - see matplotlip plot saved separately in the current folder


# 2) What's the number of short action movies released in the 1990s? A movie is considered short if it is less than 90 minutes.
action_movies_1990s = movies1990s_subset[movies1990s_subset['genre'] == 'Action']
short_movie_count = 0

for label, row in action_movies_1990s.iterrows():    
    if row['duration'] < 90:
        short_movie_count = short_movie_count + 1
    else:
        short_movie_count = short_movie_count
print(short_movie_count)

# Answer 2: 7

# ----- Solution with NumPy -----
# action_movies_1990s = movies1990s_subset[movies1990s_subset['genre'] == 'Action']
# short_movie_count = 0

# for label, row in action_movies_1990s.iterrows():
#     if row['duration'] < 90:
#         short_movie_count = short_movie_count + 1
#     else:
#         short_movie_count = short_movie_count
# print(short_movie_count)

# # Answer 2: 7
