library(tidyverse)
library(ggthemes)

## how to choose visualization
## 1. number of variable
## 2. data type

## one variable + continuous (number)

ggplot(diamonds,
       aes(x = price))+
  geom_histogram()

ggplot(diamonds,
       aes(x = price))+
  geom_density()


## DRY: Do not repeat yourself
base <- ggplot(diamonds,aes(x = price))

p1 <- base + geom_histogram()
p2 <- base + geom_density()

# Boxplot
ggplot(diamonds, aes(x = price)) +
  geom_boxplot()


# Violin plot (need 2 variables)
ggplot(diamonds, aes(x = price, y = cut)) +
  geom_violin()

## one variable + discrete (factor)
ggplot(diamonds, aes(cut)) +
  geom_bar()

## If for aggregated data
## use geom_col
diamonds %>%
  count(cut) %>%
  ggplot(aes(x = cut, y = n))+
  geom_col()

## two variables: number x number
ggplot(diamonds,
       aes(x=carat, y=price))+
  geom_point()

## setting vs mapping
ggplot(diamonds,
       #mapping
       aes(x=carat, y=price, color=cut, shape=cut))+
  #setting
  geom_point(alpha=0.4, size=2)+
  theme_minimal()

## random sample to render chart faster
ggplot(sample_n(diamonds,500),
       #mapping
       aes(x=carat, y=price, color=cut))+
  #setting
  geom_point(alpha=0.4, size=2)+
  theme_minimal()

## set seed to fix random result
set.seed(24)
ggplot(sample_n(diamonds,500),
       #mapping
       aes(x=carat, y=price, color=cut))+
  #setting
  geom_point(alpha=0.4, size=2)+
  theme_minimal()


## labeling
set.seed(24)
ggplot(sample_n(diamonds,500),
       #mapping
       aes(x=carat, y=price, color=cut))+
  #setting
  geom_point(alpha=0.4, size=2)+
  theme_minimal()+
  labs(
    title="My first scatter plot",
    subtitle="Cool ggplots",
    caption="diamonds in affrica",
    y = "Price in USD",
    x = "Carat diamond"
  )


## ggthemes
set.seed(24)
ggplot(sample_n(diamonds,500),
       #mapping
       aes(x=carat, y=price, color=cut))+
  #setting
  geom_point(alpha=0.4, size=2)+
  theme_minimal()+
  labs(
    title="My first scatter plot",
    subtitle="Cool ggplots",
    caption="diamonds in affrica",
    y = "Price in USD",
    x = "Carat diamond",
  )+
  theme_excel()

## shortcut qplot()
## qplot

qplot(x = carat, data = diamonds, geom="density")
qplot(x = carat, data = diamonds, geom="histogram")
qplot(x = carat, data = diamonds, geom="bar")


## layers in ggplots
base <- ggplot(diamonds %>% sample_n(1000),
               aes(x=carat, y=price))

base +
  geom_point()+
  geom_smooth()+
  theme_minimal()

#linear line setting
base +
  geom_point()+
  geom_smooth(method="lm")+
  theme_minimal()

## filter outlier > trend line will be changed
base <- ggplot(diamonds %>% sample_n(1000) %>%
                 filter(carat <= 2.8),
               aes(x=carat, y=price))

base +
  geom_point()+
  geom_smooth()+
  theme_minimal()

base +
  geom_point()+
  geom_smooth(se=TRUE,
              color = "red",
              fill = "yellow")+  #se = standard error
  theme_minimal()

## rug
p3 <- base +
  geom_point()+
  geom_smooth()+
  geom_rug(alpha=0.2, color="red")+
  theme_minimal()

## bar plot
ggplot(diamonds, aes(cut, fill = cut))+
  geom_bar() +
  theme_minimal()

ggplot(diamonds, aes(cut, fill = clarity))+
  geom_bar() +
  theme_minimal()

## postion dodge, fill
ggplot(diamonds, aes(cut, fill = clarity))+
  geom_bar(position="dodge") +
  theme_minimal()

ggplot(diamonds, aes(cut, fill = clarity))+
  geom_bar(position="fill") +
  theme_minimal()


## How to change color
ggplot(diamonds, aes(cut, fill = cut))+
  geom_bar() +
  theme_minimal() +
  scale_fill_manual(values = c(
    "red", "blue", "green","pink","gold"
  ))

ggplot(diamonds, aes(cut, fill = cut))+
  geom_bar() +
  theme_minimal() +
  scale_fill_brewer(palette = "Accent")

## heat map color scale
ggplot(diamonds %>% sample_frac(0.1),
       aes(x=carat, y=price, color = price))+
  geom_point()+
  theme_minimal()+
  scale_color_gradient(low="blue", high="red")

## multiple sub-plots > facet
ggplot(diamonds, aes(carat,price))+
  geom_point(alpha=0.2)+
  geom_smooth()+
  theme_minimal()+
  facet_wrap(~cut, ncol=3)

ggplot(diamonds, aes(carat,price))+
  geom_point(alpha=0.2)+
  geom_smooth()+
  theme_minimal()+
  facet_wrap(clarity ~ cut)

ggplot(diamonds, aes(carat,price))+
  geom_point(alpha=0.2)+
  geom_smooth()+
  theme_minimal()+
  facet_grid(~cut)

## multiple dataframes

m1 <- mtcars %>% filter(mpg > 30)
m2 <- mtcars %>% filter(mpg <= 30)

ggplot() +
  theme_minimal()+
  geom_point(data=m1, aes(wt, mpg), color="blue")+
  geom_point(data=m2, aes(wt, mpg), color="red", size =3)


## bin2D can reduce render time
ggplot(diamonds, aes(carat, price))+
  geom_bin2d(bins=100)

## Homework
## 1. create Rmarkdown
## 2. create 5 charts
## data = mpg
