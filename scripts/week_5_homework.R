#week 5 homework 211027
### 1 
#Create a tibble named surveys from the portal_data_joined.csv file. 
#Then manipulate surveys to create a new dataframe called surveys_wide with a column for genus and 
#a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. 
#So every row has a genus and then a mean hindfoot length value for every plot type. 
#The dataframe should be sorted by values in the Control plot type column. 
#This question will involve quite a few of the functions you’ve used so far, and it may be useful to sketch out the steps to get to the final result.

library(tidyverse)
surveys <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")

surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarise(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% 
  arrange(Control)

### 2
#Using the original surveys dataframe, use the two different functions we laid out for conditional statements, 
#ifelse() and case_when(), to calculate a new weight category variable called weight_cat. For this variable, define the rodent weight into 
#three categories, where “small” is less than or equal to the 1st quartile of weight distribution, “medium” is between (but not inclusive) the 1st and 3rd quartile, 
#and “large” is any weight greater than or equal to the 3rd quartile. 
#(Hint: the summary() function on a column summarizes the distribution). 
#For ifelse() and case_when(), compare what happens to the weight values of NA, depending on how you specify your arguments.

summary(surveys$weight)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 #  4.00   20.00   37.00   42.67   48.00  280.00    2503 

#casewhen
surveys %>% 
  mutate(weight_cat = case_when(
    weight >= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",
    weight >= 48.00 ~ "large"))

#ifelse
surveys %>% 
  mutate(weight_cat = ifelse(weight >= 20.00, "small",
                             ifelse(weight > 20.00 & weight < 48.00, "medium","large")))

#soft coding
summ <- summary(surveys$weight)
surveys %>% 
  mutate(weight_cat = case_when(
    weight >= summ[[2]] ~ "small",
    weight > summ[[2]] & weight < summ[[5]] ~ "medium",
    weight >= summ[[5]] ~ "large"))
#assigning the summary function to an object in order to more easily incorporate that into a function
#then referencing the object so that it can rerun the summary item and pull the value from the designated column in brackets

