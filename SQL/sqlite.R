library(RSQLite)
library(tidyverse)

# 1. upload chinook.db
# or getwd() for PC version

## connect to sqlite.db file
## SQLite() to tell program that we using SQLite
con <- dbConnect(SQLite(),"chinook.db")

## list tables
dbListTables(con)

## list fields / columns in table
dbListFields(con,"customers")

## get data from database tables
s1 <- dbGetQuery(con, "select firstname, email from customers
           where country = 'USA' ")

## create dataframe
products <- tribble(
  ~id, ~product_name,
  1, "chocolate",
  2, "pineapple",
  3, "samsung galaxy S23"
)


## write table to database
dbWriteTable(con, "products", products)
dbListTables(con) #check updated table list

## remove table
dbRemoveTable(con,"products")
dbListTables(con) #check updated table list

## close connection
dbDisconnect(con)
