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
