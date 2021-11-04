#week 6 homework 211104

#practicing skills using gapminder
#download the data using this code

library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary


#1 - First calculates mean life expectancy on each continent. 
#Then create a plot that shows how life expectancy has changed over time in each continent. 
#Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% #calculating the mean life expectancy for each continent and year
  ggplot()+
  geom_point(aes(x = year, y = mean_lifeExp, color = continent))+ #scatter plot
  geom_line(aes(x = year, y = mean_lifeExp, color = continent)) #line plot
?group_by()
## `summarise()` has grouped output by 'continent'. You can override using the `.groups` argument.


#2 - Look at the following code and answer the following questions. 
#What do you think the scale_x_log10() line of code is achieving? 
#What about the geom_smooth() line of code?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
## `geom_smooth()` using formula 'y ~ x'

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
#this version changes the size of the points based on population
#geom_smooth is creating a trend line

#3 - Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. 
#Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

countries <- c("Brazil", "China", "El Salvador", "Niger", "United States") 
#pulling countries of interest

gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot() +
  geom_jitter(alpha = 0.3, color = "blue")+
  theme_minimal() +
  ggtitle("Life Expectancy of Five Countries") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Country") + ylab("Life Expectancy") 

#%in% is saying if a certain variable pops up in a vecotr, it will return a true value
#example Zimbabwe in countries - true woula appear where Zimbabwe is
#in our code - it is returning true for any of the countries in our set
#change labels with x/ylab, change title position with just



