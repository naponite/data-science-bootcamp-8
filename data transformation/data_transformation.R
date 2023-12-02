library(tidyverse)
library(glue)
library(lubridate)

#glue messages
my_name <- "tah"
my_age <- 35

glue("Hi my name is {my_name}. Today I'm
     {my_age} years old")

#easier than use "paste" in base R


## row name and column name
rownames(mtcars)
colnames(mtcars)

mtcars <- rownames_to_column(mtcars,"model")

# 1.select
# 2.filter
# 3.arrange
# 4.mutate => create new column
# 5.summarise

# 1.select
m1 <- select(mtcars, mpg, hp, wt)

# pipeline
m2 <- mtcars %>%
  select(mpg, hp, wt) %>%
  head(5)

# 2.filter

filter(mtcars, hp > 200)

# use AND , OR

filter(mtcars, hp > 200 & mpg >= 15)
filter(mtcars, hp > 200 | mpg >= 15)

m3 <- mtcars %>% filter(hp > 200 & mpg >= 15)

# regular expression

mtcars %>% 
  select(model, mpg, hp , wt ,am) %>%
  filter(grepl("^M",model))

# between
mtcars %>% 
  select(model, mpg, hp , wt ,am) %>%
  filter(between(hp, 150, 200))

# 3.arrange

# ascending order sort (no need to put asc)
arrange(mtcars,hp)

# for descending order
arrange(mtcars,desc(hp))

# sort multiple column
mtcars %>% 
  select(model, mpg, hp , wt ,am) %>%
  filter(between(hp, 150, 200)) %>%
  arrange(am, desc(hp))

# 4.mutate

mtcars %>%
  filter(mpg >= 20) %>%
  select(model, mpg, hp, wt) %>%
  mutate(model_upper = toupper(model),
         mpg_double = mpg*2,
         mpg_hahaha = mpg_double+10)

# mutate with condition
mtcars %>%
  filter(mpg >= 20) %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(am = if_else(am==0,"auto","manual"))

# 5.summarise, summarize
# aggregate function in SQL
mtcars %>%
  summarise(avg_mpg = mean(mpg),
            med_mpg = median(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_mpg = max(mpg),
            #spread
            var_mpg = var(mpg),
            sd_hp = sd(hp),
            n = n()) # n for count row = nrow()
  

mtcars %>%
  mutate(am = if_else(am==0,"auto","manual")) %>%
  group_by(am) %>%
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_hp = max(hp),
            n = n()) 


# Join
left_join(band_members, band_instruments, by="name")
left_join(band_members, band_instruments)

inner_join(band_members, band_instruments)

full_join(band_members, band_instruments)

# join with data manipulation
band_members %>%
  mutate(name_upper = toupper(name)) %>%
  left_join(band_instruments, by="name")

# join with different name between dataframes
m4 <- band_members %>%
  select(member_name = name,
         band_name = band) %>%
  left_join(band_instruments,
            by = c("member_name" = "name")) #specify primary key = foreign key


## random sampling
mtcars %>%
  sample_n(5) %>% #sampling 5 rows
  pull(model)

mtcars %>%
  sample_frac(0.15) %>% #sampling 15% of all rows
  summarise(avg_hp = mean(hp))


## count
mtcars <- mtcars %>%
  mutate(am = if_else(am==0, "auto", "manual"))

mtcars %>%
  count(am) %>%
  mutate(pct = n/sum(n))
