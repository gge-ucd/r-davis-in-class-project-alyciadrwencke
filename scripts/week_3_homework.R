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
#overriding the column in the data frame with the new data

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
### factors are integers so more like a number. They behave like characters though.

#selecting only the rows that have complete cases (no NAs)
surveys_base <- surveys_base[complete.cases(surveys_base), ] 
#complete.cases - returns a vector of true and false where the trues are not NA's, should still specify column to sort by

#another option to omit NA
surveys_base <- na.omit(surveys_base) #drops any NA's - so need to specify which columns you want NA to drop
surveys_base <- na.omit(surveys_base$weight) #took a vector, removed na's, and spit out the remaining - did not put data frame out
#need to do a 2 layer thing - keep data frame and then remove na in weight column

is.na(surveys_base$weight) #gives us true and false data
#can use this to tell R what to return 
!is.na(surveys_base$weight) #inverting
#need to pair with the data frame so it sorts it the way we want
surveys_base[!is.na(surveys_base$weight),] #giving you back all the rows and columns that do not have an na in weight

surveys_base %>% na.omit(surveys_base$weight) #returns a data frame because it piped in a whole data frame so it returned one
na.omit(surveys_base, surveys_base$weight) # saying you want the whole data frame but omit from weight column

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
#other option to pull columns
surveys_base <- surveys[c('species_id', 'weight', 'plot_type')] #should give you the correct columns
surveys_base <- surveys %>% select(speciess_id, weight, plot_type) #using piping - identifying that your next input is the one before

#to pull rows could also do
surveys_base <- head(x = surveys_base, 60)

surveys_base %>% str() #piping into the str to return info about the data frame
surveys_base <- head(surveys[c(6,9,13)], n = 60)

#reviewing challenge in class
challenge_base <- surveys_base[which(surveys_base$weight>150),]
summary(challenge_base$weight)
surveys_base$weight >150 #spits out trues and false and can deal with it from there
which(surveys_base$weight>150)


