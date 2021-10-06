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

