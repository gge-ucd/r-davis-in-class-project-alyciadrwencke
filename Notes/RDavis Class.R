#210930
#r davis code.com
#username = rdavis
#password = vulcans

a <- 1
#r thinks about data as objects
#vectors are a collection of things that are tied to a name in R (vector of numbers, character strings, etc.)
#create a vector of 3 numbers
number_vector = c(23, 32, 45)
number_vector[2]
#index is a way of recopying values, what do you want R to show you?
#return twice
number_vector[c(2,2)]
#return in reverse order - brackets tell R you want to index things - you want to return a value from a specific index or subset
number_vector[c(3, 2, 1)] 
#index and subset are the same things

#add a number to a vector
number_vector = c(number_vector, 54)

#creating a string (can be symbols, spaces, etc)
my_string <- c('dog', 'walrus', 'salmon')
#telling R to treat something that is not a number 

str()
#hit ? and run to get more information. This can show you what type of vector it is
class(my_string)
#dataframe = excel
data.frame(c(my_string, my_string))
#make two columns in the data frame
data.frame(first_colum = my_string, second_column = my_string)

#Lists
?list() #tells you to do whatever you want
test_list = list('first string entry into list')
#double brackets subset lists
str(test_list) # returns your list
#add another item to the list
test_list[[1]][2] <- 'add next thing'
test_list

# add a data frame to the list
data.frame(letters)
test_df <- data.frame(letters,letters) 
test_list[[3]] <- test_df
str(test_list)
#should know: make a vector and add it to a data frame or make a data frame and add it to the last
#in the current test list there is a first item and a third item, no number 2 - so it will return NULL

dir.create("scripts") #create a folder, puts it in your standard file folder, follow your working directory
getwd() #no need to close; returns your working directory (where things live)

#211006
#getting your data into R using read.csv()
#read in your data in a way that assigns your data to an object
surveys <- read.csv("desktop/R-DAVIS_2021/r-davis-inclass-project-alyciadrwencke/data/portal_data_joined.csv")
#why is this not working??
nrow()
ncol()
#use your data frame name in the parenthases
class()
#can see what it is - ie data frame, list, etc
head() #top of data
tail() #bottom of data

#look at the entire data set - either look at global environment and click the object
View() #automatically opens your object so you can view it in a separate tab, similar to excel 
str() #structure
summary() #gives a summary of each column i.e. mean, median, max, but will not do that for character vectors

#Indexing
#using square brackets to pull something out of a list or data frame
#in the brackets you would have [row, column]
#name[1,1] #would give you row and column 1 in a data frame
#class(surveys[,6]) #gives you the class of 

#preferred subset - type the name of your object followed by $ then select your desired column


#loading the tidyverse - has a lot of resources for R and early coders
install.packages("tidyverse")
library(tidyverse)
# library needs to be used to load the package into the work space and needs to be done every time

surveys_T <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
#did not load - was directing it to notes folder, not data

surveys_T
#view tibble
#gives the first 10 rows, data type under column names, 

#inspections
class(surveys_T)
#"spec_tbl_df" "tbl_df"      "tbl"         "data.frame" 

#subsetting is a little different
surveys[,1] #gives us a vector
surveys_T[,1] #gives us a tibble - still first 10 observations


#211007
#Spreadsheets
#Wide and long data: do you have a lot of rows or a lot of columns?
#readin in spreadsheets
surveys <- read.csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
head(surveys)
str(surveys)
#class of surveys = data.frame, rows =34786 ,col = 13
nrow(surveys) #confirming number of columnes and rows
ncol(surveys)
#how are character data represented in the data frame?
#how many species have been recorded during the survey
surveys$species
unique(surveys$species)
#nest functions
length(unique(surveys$species)) #return 40
table(surveys$species) #controversial

#below - reverse unique so something that is not duplicated, then sum it (can be extremely confusing)
sum(!duplicated(surveys$species))

#looking at rodent/small mammal trapping data from 1970's, multiple data types (factors, integers, characters)
head(surveys, 1) # look at the top row only, can alter the number of rows you want to see.
summary(surveys) #gives us a break down of the data set with some general stuff (min, max, etc)
#subsetting from a data frame
surveys[1,2] #need to specify two dimensions, row, column

#levels is a way to identify unique character factors, but this does not work for just characters
#starting with characters is good
levels(surveys$species)

#convert something to a factor
?factor()
species_factor <- factor(surveys$species)
#it is kind of like a number
typeof(species_factor)
# but also, it is a character
class(species_factor)
#levels usually default to alphabetical order
levels(species_factor)
#may need to reassign orders - there are some better ways to do this 

#subsetting challenge
#Create a new data frame called surveys_200 containing row 200 of the surveys dataset.
surveys_200 <- surveys[1:200, 1:13] #pull rows 1-200 and col 1-13
#could also leave it blank as surveys[200,]
head(surveys_200)
#Create a new data frame called surveys_last, which extracts only the last row in of surveys.
surveys_last <- surveys[length(tail), 1:13] #use length in case the number of rows change
surveys_last
tail(surveys) #double checking the data

#Use nrow() to identify the row that is in the middle of surveys. Subset this row and store it in a new data frame called surveys_middle.
nrow(surveys) #return 34786
34768/2
surveys_middle <- surveys[17384, 1:13]

#Reproduce the output of the head() function by using the - notation (e.g. removal) and the nrow() function, keeping just the first through 6th rows of the surveys dataset
surveyshead <- surveys[-(7:nrow(surveys)),] #you are saying you do not want rows 7 through whatever the end of the data frame is
surveyshead
#can do more easily

#Week4 lecture videos
library(tidyverse)
#dplr is a more intuitive way of working with R but you maybe don't always need it
surveys <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
dim(surveys) #shows us the number of columns and rows

#select can help subset your data but you need to tell it what to do
str(surveys)
select(.data = surveys, sex, weight, genus) #pulls those columns, knows that sex, weight, etc are column names
head(select(.data = surveys, sex, weight, genus)) #see the top 6 rows with those selected columns

#filter function - selects rows; best to use to provide rules to sort against
filter(surveys, genus == "Neotoma") #genus understands is a column, but need neotoma in quotes because it is a character value
head(filter(surveys, genus == "Neotoma")) #returning top 6 rows
#filter things out - i.e. anything that is not Neotoma <- != means do the opposite
head(filter(surveys, genus!= "Neotoma"))

surveys2 <- filter(surveys, genus != "Neotoma")
surveys3 <- select(surveys2, genus, sex, species) #selecting columns from the data frame
str(surveys3)

#can nest functions to make this less taxing
surveys_filter <- select(filter(surveys, genus != "Neotoma"), genus, sex, species) #r starts in the middle and works its way out
identical (surveys3, surveys_filter) #checks if two items are identical, so cool!

%>% #special character - piping that strings filter and select together

install.packages("dlpr")
#mutate - about creation

surveys <- surveys %>% mutate(weight_kg = weight/1000) #overriding the older surveys to add the mutated version
#can use this function with and without "piping" so you understand what is happening

installed.packages() #shows you all of the packages you already have installed on R. 

surveys <- read.csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
str(surveys)
#groups by sex then weight
surveys %>% group_by(sex) #variables in group by tells what we want to group with
surveys %>% group_by(sex) %>%summarize(mean(weight)) # returns NA values - doesn't know how to deal with NA

surveys %>% group_by(sex) %>%summarize(mean(weight, na.rm = T)) #removing na from data sets so that you get an actual value back
#dplr allows you to rename the new value 
surveys %>% group_by(sex) %>%summarize(avg_weight = mean(weight, na.rm = T))
#renames the mean weight column that was created as avg_weight
#tibble is a way that the tidy verse referes to a data frame - not a huge concern
#adding another column with the median weight
surveys %>% group_by(sex) %>%summarize(avg_weight = mean(weight, na.rm = T), med_weight = median(weight, na.rm =T))


#tally function
tally()

#211014 - reviewing the tidyverse - data manipulation pt1
library(tidyverse)
surveys <- read.csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
#keep observations only before 1995
surveys_base <- filter(surveys,surveys$year < 1995) #in tidy verse could also leave it as only year
#retain columns year, sex, and weight
surveys_base <- select(surveys_base, year, sex, weight)
str(surveys_base)

#using piping to create a surveys base option without saving an intermediate step
surveys_base <- filter(surveys, year<1995) %>% select(year, sex, weight)
#another option
surveys_base <- surveys %>% filter(year<1995) %>% select(year, sex, weight)
#could also do
surveys_base <- filter(select(surveys, year, sex, weight), year<1995) #may want to do it the oposite way sometimes

#mutate - writing a new column or changing an existing column
#recognizes names without quotes
#Create a new data frame from the surveys data that meets the following criteria: 
#contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. 
#In this hindfoot_half column, there are no NAs and all values are less than 30. 
#Name this data frame surveys_hindfoot_half.
surveys_hindfoot_half <- surveys %>% 
  filter(., !is.na(hindfoot_length)) %>% 
  mutate(., hindfoot_half = hindfoot_length/2) %>% 
  select(., species_id,hindfoot_half) %>% 
  filter(., hindfoot_half < 30)
surveys_hindfoot_half
str(surveys_hindfoot_half)
#took the surveys data frame and filtered out the NA because we said we want anything that is not an na
#then said we want a new column where we call it hindfoot half and that should be hindfoot length divided by 2
#pope into the select where we say we want these specific columns
#then we pipe into filter where we want to filter out the rows that are not less than 30


#groupby and summerize
#Use group_by() and summarize() to find the mean, min, and max hindfoot length for each species (using species_id).
#What was the heaviest animal measured in each year? Return the columns year, genus, species_id, and weight.
#You saw above how to count the number of individuals of each sex using a combination of group_by() and tally(). 
#How could you get the same result using group_by() and summarize()? Hint: see ?n.

surveys %>% filter(., !is.na(hindfoot_length)) %>% group_by(species_id) %>% 
  summarize(avg_length = mean(hindfoot_length), min(hindfoot_length), max(hindfoot_length))



