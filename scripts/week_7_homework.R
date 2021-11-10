#week 7 homework - 211104
library(tidyverse)
library("ggthemes")

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
head(gapminder)

#For week 7, we’re going to be working on 2 critical ggplot skills: 
#recreating a graph from a dataset and googling stuff.
#Our goal will be to make this final graph using the gapminder dataset:

#1 - To get the population difference between 2002 and 2007 for each country, it would probably be easiest to have a country in each row and a column for 2002 population and a column for 2007 population.

gapminder %>% filter(year %in% c(2002,2007)) %>% 
  pivot_wider(id_cols = country,names_from = year,values_from = pop) %>% 
  mutate(popDiff = `2007`-`2002`)

#%in% does not do recycling with the vector like concatenate does
#have to use the special single quote when you are trying to call a column that the name is only a number (character with tilda)

#2 - Notice the order of countries within each facet. You’ll have to look up how to order them in this way.

new_data = gapminder %>% filter(year %in% c(2002,2007)) %>% 
  pivot_wider(id_cols = c(country, continent),names_from = year,values_from = pop) %>% 
  mutate(popDiff = `2007`-`2002`) %>% 
  filter(continent!='Oceania')
#making sure we have continents, and then continent and country are not shifted when you pivot wider

ggplot(new_data %>% arrange(country)) + facet_wrap(~continent) +
  geom_bar(aes(x = country, y = popDiff),stat = 'identity')

#looks better with the scales as free
ggplot(data = new_data) + facet_wrap(~continent, scales = "free") +
  geom_bar(aes(x = reorder(country,popDiff), y = popDiff),stat = 'identity')

#3 - Also look at how the axes are different for each facet. Try looking through ?facet_wrap to see if you can figure this one out.

ggplot(data =new_data) + facet_wrap(~continent,scales = 'free_y') +
  geom_bar(aes(x = reorder(country,popDiff),y = popDiff),stat = 'identity')

# adding axis labels
ggplot(data =new_data) + facet_wrap(~continent,scales = 'free_y') +
  geom_bar(aes(x = reorder(country,popDiff),y = popDiff),stat = 'identity') +
  labs(x = 'Country',y = 'change in pop. 2002 to 2007')

#4 - The color scale is different from the default- feel free to try out other color scales, just don’t use the defaults!
 
 
#5 - The theme here is different from the default in a few ways, again, feel free to play around with other non-default themes.

#6 - The axis labels are rotated! Here’s a hint: angle = 45, hjust = 1. It’s up to you (and Google) to figure out where this code goes!
ggplot(data =new_data) + facet_wrap(~continent,scales = 'free') +
  geom_bar(aes(x = reorder(country,popDiff),y = popDiff),stat = 'identity') +
  labs(x = 'Country',y = 'change in pop. 2002 to 2007') +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "blue", angle = 45))
#changed the axis to free so that each facet will have it's own unique x and y axis
#+coord_flip() - puts the countries on the y axis so helps with readability


#7 - Is there a legend on this plot?

final_plot <- ggplot(data =new_data) + facet_wrap(~continent,scales = 'free') +
  geom_bar(aes(fill = continent, x = reorder(country,popDiff),y = popDiff), stat = 'identity') +
  labs(x = 'Country',y = 'change in pop. 2002 to 2007') +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "gray", angle = 45, hjust = 1), legend.position = "none")
final_plot
