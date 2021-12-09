#Final Assignment - 211202

library(tidyverse)
library(lubridate)
library(gapminder)

#data is from NYC flights in 2013
#You may have to combine dataframes to answer some questions. 
#Remember our join family of functions? You should be able to use the join type we covered in class. 
#The flights dataset is the biggest one, so you should probably join the other data onto this one, meaning flights would be the first (of “left”) argument in the left join. 
#You can’t join 3 tables together at once, but you can join tables a and b to make table ab, then join ab and c to get table abc which contains the columns from all 3 original tables.

#read your data into the environment
flights <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/nyc_13_flights_small.csv")
planes <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/nyc_13_planes.csv")
weather <- read_csv("/Users/alyciadrwencke/Desktop/R_DAVIS_2021/r-davis-in-class-project-alyciadrwencke/data/nyc_13_weather.csv")

#join them together
head(flights)
head(planes)
head(weather)

fp_joined <- full_join(flights, planes, by="tailnum", keep = TRUE) %>% 
  mutate(mdh = c(month + day + hour))
fp_joined
#joined flights and planes and added a column that combines month, day, hour

weather2 <- weather %>%  mutate(mdh = c(month + day + hour))
#adding column with month, day, hour combined

#joining all 3 together
fpw_joined <-full_join(fp_joined, weather2, keep = TRUE)
#don't use the by function for this one so it doesn't try match every single thing within each frame and create exponential growth
#didn't actually need to mutate to do this
#Joining, by = c("month", "day", "origin", "hour", "time_hour", "mdh")

fpw_joined
#59707 obs and 45 variables

#Things to Include

#1. Plot the departure delay of flights against the precipitation, and include a simple regression line as part of the plot. Hint: there is a geom_ that will plot a simple y ~ x regression line for you, but you might have to use an argument to make sure it’s a regular linear model. Use ggsave to save your ggplot objects into a new folder you create called “plots”.

delay.plot <- ggplot(data = fpw_joined, mapping = aes(x = dep_delay, y = precip)) +
  geom_point(color = "mediumpurple4") + labs(y = "Precipitation (inches)", x = "Departure Delay (minutes)") +
  geom_smooth(method='lm', formula= y~x) +
  theme_bw()
# saying 11184 rows with missing values removed
delay.plot

#save to plots
install.packages("cowplot")
library(cowplot)
dir.create("plots")
ggsave("plots/delay.plot.png", plot = delay.plot, width = 6, height = 4, units = "in")

#2. Create a figure that has date on the x axis and each day’s mean departure delay on the y axis. Plot only months September through December. Somehow distinguish between airline carriers (the method is up to you). Again, save your final product into the “plot” folder.

#filter months so you get only september through december, then soft code mean departure delay, code color by airline carrier, date is on the x axis


mean.delay.plot <- ggplot(data = fpw_joined, mapping = aes(x = date, y = precip)) +
  geom_point(color = "mediumpurple4") + labs(y = "Precipitation (inches)", x = "Departure Delay (minutes)")

#3. Create a dataframe with these columns: date (year, month and day), mean_temp, where each row represents the airport, based on airport code. Save this is a new csv into you data folder called mean_temp_by_origin.csv.


#4. Make a function that can: (1) convert hours to minutes; and (2) convert minutes to hours (i.e., it’s going to require some sort of conditional setting in the function that determines which direction the conversion is going). Use this function to convert departure delay (currently in minutes) to hours and then generate a boxplot of departure delay times by carrier. Save this function into a script called “customFunctions.R” in your scripts/code folder.

#convert minutes to hours or hours to minutes
time_convert <- function(delay) {
 if (x = hour) {x*60} else {x/60}
}
 
#build in a call in the function to tell it if you are dealing with a minute or an hour

#if in hours, convert to minutes, if in hours, convert to minutes
#tell it what the number and what the form is (min or hour) and what to do with it based on that
#needs to have multiple inputs

K_to_C <- function(tempK) {
  C <- ((tempK - 273.15))
  return(C)
}

#5. Below is the plot we generated from the new data in Q4. (Base code: ggplot(df, aes(x = dep_delay_hrs, y = carrier, fill = carrier)) +   geom_boxplot()). The goal is to visualize delays by carrier. Do (at least) 5 things to improve this plot by changing, adding, or subtracting to this plot. The sky’s the limit here, remember we often reduce data to more succinctly communicate things.


