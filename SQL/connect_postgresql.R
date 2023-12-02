## connect to PostgreSQL server
library(RPostgreSQL)
library(tidyverse)

## create connection
con <- dbConnect(
  PostgreSQL(),
  host = "arjuna.db.elephantsql.com",
  db = "asgyiaai",
  user = "asgyiaai",
  password = "xwgvC2Ie5M8FmAXgrTZlxxgLnr_94799",
  port = 5432 #defualt
  
)

con #check connection

## db List Tables
dbListTables(con)

dbWriteTable(con, "products", products)

## get data
df <- dbGetQuery(con,"select id, product_name 
                 from products")

dbDisconnect(con)


## HW02 - restaurant pizza SQL
## create 3-5 dataframes => write table into server