#Week 3 Homework 211013
#Homework this week will be playing with the surveys data we worked on in class. First things first, open your r-davis-in-class-project and pull. Then create a new script in your scripts folder called week_3_homework.R.
#Load your survey data frame with the read.csv() function. Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. Have this data frame only be the first 60 rows. Convert both species_id and plot_type to factors. Explore these variables and try to explain why a factor is different from a character. Remove all rows where there is an NA in the weight column.
#CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.

#setting data frame and creating the object surveys by reading in the CSV
surveys <- read.csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
head(surveys)

#load the tidyverse
library(tidyverse)

#creating a new data frame with with only the species_id, the weight, and the plot_type columns. 
surveys_base <- select(.data = surveys, species_id, weight, plot_type)
head(surveys_base)
#make the data only the first 60 rows - overriding the old data frame object 
surveys_base <- surveys_base[1:60,]
#Convert both species_id and plot_type to factors
surveys_base$species_id <- as.factor(surveys_base$species_id) 
surveys_base$plot_type <- as.factor(surveys_base$plot_type) 

#converting factor data to character
surveys_base$species_id <- as.character(surveys_base$species_id) 
surveys_base$plot_type <- as.character(surveys_base$plot_type) 

#Explore these variables and try to explain why a factor is different from a character.
typeof(surveys_base) 
#returns that it is a list?
# but also, it is a character
class(surveys_base)
#returns that it is a data frame

#why is a factor different from a character? 
### factorrs are integers so more like a number. They behave like characters though.

#selecting only the rows that have complete cases (no NAs)
surveys_base <- surveys_base[complete.cases(surveys_base), ] 

#challenge
#Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.

challenge_base <- surveys_base[c(surveys_base$weights >150)]
#error - compariosn(6) is only possible for atomic and list types? added surveys_base$ to the ()

challenge_base
#returns data frame with 0 columns and 60 rows - why are there no columns?

challenge_base <- surveys_base[(surveys_base [, 2] >150)]
#error - undefined columns selected

#simpler way to subset the data initially
surveys_base <- surveys[1:60, c(6, 9, 13)] #selecting rows 1:60 and just columns 6, 9 and 13
