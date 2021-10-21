# week 4 homework 211020
#Create a tibble named surveys from the portal_data_joined.csv file. #use read_csv to make a tibble
library(tidyverse)
surveys <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
str(surveys)

#Subset surveys to keep rows with weight between 30 and 60, and print out the first 6 rows.
surveys %>% filter(weight >30 & weight <60)

#Create a new tibble showing the maximum weight for each species + sex combination and name it biggest_critters. 
#Sort the tibble to take a look at the biggest and smallest species + sex combinations. 
#HINT: it’s easier to calculate max if there are no NAs in the dataframe…

biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(max_weight = max(weight))
head(biggest_critters)

#group by doesn't really change anything, it is waiting for another command such as summarise
#sorting the data by max weight in decreasing order
biggest_critters %>% arrange(desc(max_weight))

#Try to figure out where the NA weights are concentrated in the data- 
#is there a particular species, taxa, plot, or whatever, where there are lots of NA values? 
#There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. 
#Maybe use tally and arrange here.

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))

#returns -
# A tibble: 24 × 2
#plot_id     n
#<int> <int>
#  1      13   160
#2      15   155
#3      14   152
#4      20   152
#5      12   144
#6      17   144
#7      11   119
#8       9   118
#9       2   117
#10      21   106
# … with 14 more rows

#tally ends a pipe - may want to use n instead
surveys %>%
  filter(is.na(hindfoot_length)) %>%
  group_by(species) %>%
  summarize(count = n(), mean = mean(weight, na.rm = T))


head(surveys)
surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(taxa) %>% 
  tally() %>% 
  arrange(desc(n))
#Returns
#A tibble: 4 × 2
#taxa        n
#<fct>   <int>
#  1 Rodent   1964
#2 Bird      450
#3 Rabbit     75
#4 Reptile    14

#Seems like a lot of NA's in the rodent taxa
head(surveys)
surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(sex) %>% 
  tally() %>% 
  arrange(desc(n))

#fairly evenly split between M/F but there are a lot of NA's with sex as blank

sum(is.not(surveys$weight)) #totals na's in that column


#Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe.
#Then get rid of all the columns except for species, sex, weight, and your new average weight column. 
#Save this tibble as surveys_avg_weight.
surveys_average_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>%
  mutate(., average_weight = mean(weight)) %>%
  select(species_id, sex, weight, average_weight)
#using piping to first filter out the na's
#then grouping by the variables we want to combine/average
#mutating the data frame to add the averagae weighr column
#then carrying over only the correct column names

surveys_average_weight

#Take surveys_avg_weight and add a new column called above_average that 
#contains logical values stating whether or not a row’s weight is above average for its species+sex combination 
#(recall the new column we made for this tibble).

surveys_average_weight <- surveys_average_weight %>%
  mutate(above_average = weight > average_weight)

surveys_average_weight

#read.csv is why there are blanks in the sex function
#should use read_csv so that it reads blanks in as an NA
