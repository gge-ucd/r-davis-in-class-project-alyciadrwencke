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

#211020 - Data manipulation pt 2
library(tidyverse)
surveys <- read.csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
str(surveys)
#conditional assignment
summary(surveys$hindfoot_length)

ifelse() #condenses a longer if/else call 
#test, yes, no is the format - what to do, if it's a yes, if it's no.
ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm = T), 'small', 'big')
#returns a vector of true, falses, and NA's. NA's show up where there are NA's in the data frame
#can nest in mutate
surveys <- mutate(surveys, hindfoot_size = ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm = T), 'small', 'big'))

surveys$hindfoot_size
#returns the same vector but is now part of the data frame
#casewin is a different method but doesn't handle the NA's as well


#join
tail <- read.csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/tail_length.csv")
str(tail)
summary(tail$record_id)
summary(surveys$record_id)

#4 ways to join in the tidyverse
#innerjoin - returns rows or columns where there is a match in A and B
#left join and right join keep everything in one side and only what has a match in the other side
#example - everything in b is kept, anything with a match in A stays, but anything without a match leaves
#full_join returns NA's in spots where there aren't matches - things can get wonky if there aren't different ID's
surveys_joined <- left_join(surveys,tail, by = "record_id")
str(surveys_joined)

#sometimes if you ask it to join without specifying what to join by, it can look at see if there are any that are the same
#use extreme caution with this though!the columns may not be the same. etc.

pivot_longer()
pivot_wider() #enter data frame, columns to spread out and what to keep values

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight)) 
wide_survey <- pivot_wider(surveys_mz, names_from = 'plot_id', values_from = 'mean_weight')
dim(wide_survey)
str(wide_survey)

#switching to longer, you need to collapse some columns - needs to be more entries
surveys_long <- wide_survey %>% 
  pivot_longer(col = -genus, names_to = "plot_id", values_to = "mean_weight")

#minus sign pivot all columns except for genus
#col defines which ones to pivot (or in this case not by)
#don't forget to specify the data frame if you are not piping
head(surveys_long)

#211021 - data manipulation pt 2

#filter subset by row values
#select subset by columns
#command, shift, and m creates piping symbol
#tibble is a data frame that has certain hardwiring that is difficult to override
#can use environment or View() to create a scrollable, view-able
colnames()
rownames()
#returns a list of them

#conditional statements
library(tidyverse)
surveys <- read.csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
surveys %>% 
  filter(!is.na(weight)) %>% #gettinf rid of the NA's
  mutate(weight_cat = case_when(weight > mean(weight) ~ "big", 
                                weight < mean(weight) ~ "small")) %>% 
#assigning what you want to happen with the case win if something is true or fales
select(weight, weight_cat) %>% #select to make our view better
  tail() #looking at the bottom 6 rows

#challenge
#Using the iris data frame (this is built in to R), create a new variable that categorizes petal length into three groups:
#small (less than or equal to the 1st quartile)
#medium (between the 1st and 3rd quartiles)
#large (greater than or equal to the 3rd quartile)
#Hint: Explore the iris data using summary(iris$Petal.Length), to see the petal length distribution. 
#Then use your function of choice: ifelse() or case_when() to make a new variable named petal.length.cat based on the conditions listed above. 
#Note that in the iris data frame there are no NAs, so we don’t have to deal with them here.

data(iris)
head(iris)
str(iris)
summary(iris$Petal.Length)

iris_summary <- iris %>%  mutate(length_group = case_when(Petal.Length <= 1.6 ~ "small", 
                                                          Petal.Length > 1.6 & Petal.Length < 5.1 ~ "medium",
                                                          Petal.Length >= 5.1 ~ "large"))
iris_summary

#could also do - if else - assigns if something is one thing, assign small, if it's not, check the second one and do those 
iris %>%
  mutate(length_cat = ifelse(Petal.Length <= 1.6, "small",
                             ifelse(Petal.Length >= 5.1, "large",
                                    "medium")))

#joining
surveys = read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv")
tail_length = read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/tail_length.csv")

str(tail_length)
str(surveys)

intersect(colnames(surveys), colnames(tail_length))
#record_id is returned

combo_dateframe = left_join(surveys,tail_length)
str(combo_dateframe)


#pivot
temp_df = surveys %>% group_by(year, plot_id) %>% tally()
temp_df %>% ungroup #ungroups your data which can be helpful at times
#challenge
#Use pivot_wider on the surveys data frame with year as columns, plot_id as rows, and the number of genera per plot as the values. 
#You will need to summarize before reshaping, and use the function n_distinct() to get the number of unique genera within a particular chunk of data. 
#It’s a powerful function! See ?n_distinct for more.
surveys_wider <- pivot_wider(temp_df, names_from = 'year', values_from = 'n')

surveys_wider
# plot id is the first col, year along top row, then the values in the table are the count

#could do
pivot_wider(temp_df,id_cols = 'plot_id',names_from = 'year',values_from = 'n')

?n_distinct
surveys %>% group_by(plot_id,year) %>% summarize(distinct_genus = n_distinct(genus))
# or could do 
surveys %>% group_by(plot_id,year) %>% summarize(length(unique(genus)))


#Week 6 videos 211026 - Data visualization pt1
library(tidyverse)

surveys <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))
#reading in our data and removing all of the NA's

#ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>() 
#can add on geometric functions 
# `geom_point()` for scatter plots, dot plots, etc.
# `geom_boxplot()` for, well, boxplots!
# `geom_line()` for trend lines, time series, etc.  

#just specifying data gives you blank canvas
ggplot(data = surveys)

#two continuous variables
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))
#aes = aesthetic
#now see our canvas and see our x and y axis but no plotted points currently - GEOM does that

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()
#plots the data as point data

#you can save these as an object
base_plot <- ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))
base_plot #gives you your blank canvas

#can then add to the blank canvas
base_plot + geom_point()

#additional aesthetics that can give plots more character
#plot elements - transparency, color, fill
# color = color, transparency = alpha, infill = fill

base_plot + geom_point(alpha = 0.2)
base_plot + geom_point(color = "blue")
#there are some packages available for color in ggplot
base_plot + geom_point(color = "aquamarine") # this color worked
#R will not recognize some colors though
base_plot + geom_point(alpha = 0.5, color = "red")

#color by categorical variable - species id
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))
#you can specify aesthetics in multiple places
#have to specify mapping with the species ID

#box plots - geom_boxplot
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) + geom_boxplot()
#this one worked

boxplot2 <- ggplot(data = surveys, mapping = aes(x = species_id, y = weight))

#boxes are purple
boxplot2 + 
  geom_boxplot(color = "purple") + geom_point()

#geom_jitter - moves the dots over 
boxplot2 + 
  geom_boxplot(color = "purple") +
  geom_jitter(alpha = 0.1)

#color by variable on the points - where to color is specified makes it only the points not the box plots
boxplot2 + 
  geom_boxplot(color = "purple") +
  geom_jitter(alpha = 0.1, mapping = aes(color = species_id))

#plotting time series
yearly_counts <- surveys %>%
  count(year, species_id) 
str(yearly_counts)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line()
#this looks really bad - making a purposeful mistake
#not telling ggplot how to group things (doesn't recognize species ID here)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line()
#using group to plot a line for each species id

#adding color to each line with the species id
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = species_id)) +
  geom_line()

#faceting - wrap or grid - ploting the lines so they don't overlap
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)
# could add inside the facet brackets (nrow = x) to specify number of rows you want them on
#you could also mess with scales - fixed, free, one fixed (x or y) and one roam free

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id, scales = 'free_y')

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())

#themes - gray, classic, black, dark

#gaining access to all sorts of themes people have created
install.packages("ggthemes")
library(ggthemes)
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  theme_bw()


#211028 - week 6 class 
library(tidyverse)

#Challenge -
#Use what you just learned to create a scatter plot of weight and species_id with weight on the Y-axis, and species_id on the X-axis. 
#Have the colors be coded by plot_type. Is this a good way to show this type of data? What might be a better graph?

surveys <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))
#reading in our data and removing all of the NA's
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_point(alpha = 0.5, aes(color = plot_type))

#How can this be better?
#switched the axis and color
ggplot(data = surveys,
     mapping = aes(y = weight, x = plot_type)) +
  geom_point(alpha = 0.5, aes(color = species_id))

#Break them into different plots
ggplot(surveys, aes(x = species_id, y = weight)) +
  geom_point() +
  facet_wrap(~plot_type)

# don't like the theme
ggplot(surveys, aes(x = species_id, y = weight)) +
  geom_point() +
  theme_classic()

#box plot
ggplot(data = surveys, mapping = aes(y = weight, x = species_id)) +
  geom_boxplot() + geom_jitter(mapping = aes(color = plot_type))

ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato") #notice our color needs to be in quotations 

#challenge 2
#1 - Boxplots are useful summaries, but hide the shape of the distribution. 
#For example, if the distribution is bimodal, we would not see it in a boxplot. 
#An alternative to the boxplot is the violin plot, where the shape (of the density of points) is drawn.
#Replace the box plot with a violin plot; see geom_violin().

ggplot(data = surveys, mapping = aes(y = weight, x = species_id)) +
  geom_boxplot(color = "purple") 

ggplot(data = surveys, mapping = aes(y = weight, x = species_id)) + 
  geom_violin(aes(color = species_id)) 
#can see wider spots where there is presumably a higher concentration of values
#why did it not work when we try to do color by plot type?

#adding violin
base <- ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_violin(alpha = 0)


  
#2 - In many types of data, it is important to consider the scale of the observations. 
#For example, it may be worth changing the scale of the axis to better distribute the observations in the space of the plot. 
#Changing the scale of the axes is done similarly to adding/modifying other components (i.e., by incrementally adding commands). 
#Try making these modifications:
#Represent weight on the log10 scale; see scale_y_log10().

scaled_plot <- ggplot(data = surveys, mapping = aes(y = weight, x = species_id)) + 
  geom_violin(aes(color = species_id)) + scale_y_log10("weight")
?scale_y_log10()

scaled_plot

#adding the scale to the axis
base +
  geom_jitter(alpha = .1) +
  geom_violin() +
  scale_y_log10()
  
#3 - Make a new plot to explore the distrubtion of hindfoot_length just for species NL and PF. 
#Overlay a jitter plot of the hindfoot lengths of each species by a boxplot. 
#Then, color the datapoints according to the plot from which the sample was taken.
#Hint: Check the class for plot_id. Consider changing the class of plot_id from integer to factor. Why does this change how R makes the graph?

surveys %>%
  filter(species_id == "NL" | species_id == "PF")
#inclusive is & vs "or"
#needed to do the == rather than & so that you get values otherwise you are asking for it to return values that have both which the data does not 


surveys %>%
  filter(species_id == "NL" | species_id == "PF") %>%
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_id))

# plot is numeric but want it to be categorical
hindfoot_survey <- surveys %>%
  filter(species_id == "NL" | species_id == "PF")

hindfoot_survey$plot_factor <- as.factor(hindfoot_survey$plot_id)

ggplot(data = hindfoot_survey,
       mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_factor))

surveys %>%
  filter(species_id == "NL" | species_id == "PF") %>%
  mutate(plot_factor = as.factor(plot_id)) %>% 
ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_factor))



#how to rearrange and resize things, etc. 
# labels = labs, put them in quotes
surveys %>%
  filter(species_id == "NL" | species_id == "PF") %>%
  mutate(plot_factor = as.factor(plot_id)) %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_factor)) +
  labs(x = "Species ID", y = "Hindfoot Length", title = "Boxplot", color = "Plot ID") +
  theme_classic() + 
  theme(axis.title.x = element_text(angle = 45))


#Data visualization pt 2 211103
library(tidyverse)
data("mtcars")
str(mtcars)

library("ggthemes")
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() +
  theme_tufte()
#color is a big consideration for your plots
#use colorblin portion below to make them more accessible
ggplot(data = mtcars, aes(x = mpg, y = hp, color = as.factor(cyl))) + geom_point() +
  scale_color_colorblind()
  
#continuous value
ggplot(data = mtcars, aes(x = mpg, y = hp, color = wt)) + geom_point() + theme_bw()

# my graph does not look the same....
#ah! I still had the as.factor in there. It works when I take it out

ggplot(data = mtcars, aes(x = mpg, y = hp, color = wt)) + geom_point() + theme_bw()

ggplot(data = mtcars, aes(x = mpg, y = hp, color = wt)) + geom_point() + theme_bw() + scale_color_viridis_c() 
#tyler always uses viridis - makes a difference if you have a lot of data
ggplot(data = mtcars, aes(x = mpg, y = hp, color = wt)) + geom_point() + theme_bw() + scale_color_viridis_c(option = "B") 
#option B = the inferno pallet 

install.packages("BrailleR")
#takes a plot and turns it into a text description
library("BrailleR")

#plots for publication with cowplot()
#making random graphs
summary(diamonds)
summary(iris)
summary(mpg)

diamonds.plot <- ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5))

diamonds.plot
#did not pop up initially so ran just the item to see if that worked
#bar plot - if you give just the x variable, it will return the count has the y

mpg.plot <- ggplot(mpg, aes(cty,hwy, color = factor(cyl))) +
  geom_point(size = 2.5)
mpg.plot  

iris.plot <- ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) + 
  geom_point(alpha = 0.3)
iris.plot

install.packages("cowplot")
library(cowplot)

#use plot_grid to put multiple plots into even lines
plot_grid(diamonds.plot, mpg.plot, iris.plot, labels = c("A", "B", "C"), nrow = 1)
#labels for publication to make like figure 1 a, b, c
#making 1 row

#use ggdraw + ggplot to line up plots
ggdraw() + draw_plot(iris.plot, x = 0, y = 0, width = 1, height = 0.5) + 
  draw_plot(mpg.plot, x = 0, y = 0.5, height = 0.5, width = 0.5) +
  draw_plot(iris.plot, x = 0.5, y = 0.5, height = 0.5, width = 0.5)

#draw plot x and y arguements go from 0 - 1, 0 = bottom left
#iris will take up the bottom row, mpg will take up top left and diamond will take up top right


#ggsave
#save your plot as an object
final.plot <- ggdraw() + draw_plot(iris.plot, x = 0, y = 0, width = 1, height = 0.5) + 
  draw_plot(mpg.plot, x = 0, y = 0.5, height = 0.5, width = 0.5) +
  draw_plot(iris.plot, x = 0.5, y = 0.5, height = 0.5, width = 0.5)

getwd()
dir.create("figures")
ggsave("figures/final.plot.png", plot = final.plot, width = 6, height = 4, units = "in")

#interactive plots
install.packages("plotly")
library(plotly)

ggplotly(iris.plot)
#can hover over things and pull out specific data points etc. 
#%in% does not do recycling with the vector like concatenate does


#Videos for class week 9 - 211116
#Lubridate - dealing with dates in R
#R is y m d format for dates
library(tidyverse)
sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
sort(sample_dates_1)

as.Date(sample_dates_1)
#nothing happens because they are already in the correct format

sample_dates_1 <- as.Date(sample_dates_1)
sample_dates_1
str(sample_dates_1)
#r now understands it is a date vector rather than a character vector

sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")
#dates are in month, day, year format - not ideal for r
sample_dates_3 <-as.Date(sample_dates_2) # well that doesn't work
str(sample_dates_3)
#looks terrible - dates are all messed up

#you can read in dates and tell the function how it is currently encoded
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")
sample_dates_3<- as.Date(sample_dates_2, format = "%m-%d-%Y" ) # date code preceded by "%"
#you can use the ? to figure out how to format
sample_dates_3 #returns dates again

tm1 <- as.POSIXct("2016-07-24 23:55:26")
tm1
tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2
#Notice how POSIXct automatically uses the timezone your computer is set to. What if we collected this data in a different timezone?
# specify the time zone:
tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")
tm3

#easier way to deal with dates
install.packages('lubridate')
library(lubridate)

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
sample_dates_lub <- ymd(sample_dates_1)
lubridate::ymd(sample_dates_1)

sample_dates_2 <- c("2-01-2018", "3-21-2018", "10-05-18", "01-01-2019", "02-18-2019")
#notice that some numbers for years and months are missing

sample_dates_lub2 <- mdy(sample_dates_2) #lubridate can handle it! 

lubridate::decimal_date(ymd(sample_dates_1))
#gives you the decimal rep of where things are in a given year
#good for sorting, proportions, coveriates, etc. 

library(lubridate)
library(dplyr)
library(readr)

# read in some data and skip header lines
nfy1 <- read_csv("data/2015_NFY_solinst.csv", skip = 12)
head(nfy1) #R tried to guess for you that the first column was a date and the second a time
# import raw dataset & specify column types
nfy2 <- read_csv("data/2015_NFY_solinst.csv", col_types = "ccidd", skip=12)

glimpse(nfy1) # notice the data types in the Date.Time and datetime cols
glimpse(nfy2)

#writing functions
#functions are operations we run in R

my_sum <- function(a, b) {
  the_sum <- a + b
  return(the_sum)
}
#the environment now has an object that you can call upon and use
my_sum(a = 2, b = 2)
#returns 4

my_sum(3, 4)
#as long as you write in the same order you don't need to sepcify arguements

#you can set some defaults so you don't have to write them every time
my_sum2 <- function(a = 1, b = 2) {
  the_sum <- a + b
  return(the_sum)
}
my_sum2()
#this returns the correct value because we did not change the default
#you could overwrite those though, like this
my_sum2(10)

#Temperature conversion
#feherenheit to Calvin
F_to_K <- function(temp) {
  K <- ((temp - 32) * (5 / 9)) + 273.15
  return(K)
}
# freezing point of water
F_to_K(32)
#boiling point of water
F_to_K(212)

install.packages('gapminder')
library(gapminder)
library(tidyverse)
#average gdp over certain years in Canada
gapminder %>% 
  filter(country == "Canada", year %in% c(1950:1970)) %>% 
  summarize(mean(gdpPercap, na.rm = T))
#but what if we want to do this for a ton of different countries
# Note: try to name arguments something that do not exist as a column name, to avoid confusing yourself and R
avgGDP <- function(cntry, yr.range){
  df <- gapminder %>% 
    filter(country == cntry, year %in% yr.range)
  mean(df$gdpPercap, na.rm = T)
}

avgGDP("Iran", 1980:1985)
avgGDP("Zimbabwe", 1950:2000)
