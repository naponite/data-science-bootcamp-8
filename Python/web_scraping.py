### this code is scraped from IMDB top 100 movies ###

# web scraping
# install new library on google colab
# pip => package manager in Python

!pip install gazpacho

## import function
from gazpacho import Soup
import requests

# web sraping basic
url = "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc"

html = requests.get(url)
print(html) # check status code

html.text # to view text

imdb = Soup(html.text)
print(imdb)

titles = imdb.find("h3", {"class": "lister-item-header"})
# the data collected in list data type

# basic cleaning method by for loop

"""
clean_titles = []


for title in titles:
  clean_titles.append(title.strip())
"""

# list comprehension to clean by one shot

clean_titles = [title.strip() for title in titles]

clean_titles


# clean rating
ratings = imdb.find("div", {"class": "inline-block ratings-imdb-rating"})


# list comprehension to clean by one shot
# use float to convert string to number
clean_ratings = [float(rating.strip()) for rating in ratings]

clean_ratings

# create dataframe
import pandas as pd
movie_database = pd.DataFrame(data = {
    "title" : clean_titles,
    "rating" : clean_ratings                 

})

# view first five rows
movie_database.head()

