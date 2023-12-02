#install.packages("sqldf")
library(sqldf)

sqldf("select * from mtcars 
      where hp >= 200
      limit 5")

sqldf(
  "select avg(hp), max(hp),
  count(*) from mtcars"
)




