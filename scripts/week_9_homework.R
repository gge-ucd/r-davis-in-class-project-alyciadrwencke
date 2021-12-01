#Week 9 Homework 211130
#Use the README file associated with the Mauna Loa dataset to determine in what time zone the data are reported, 
#and how missing values are reported in each column. With the mloa data.frame, 
#remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. 
#Generate a column called “datetime” using the year, month, day, hour24, and min columns. 
#Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time 
#(HINT: look at the lubridate function called with_tz()). 
#Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. 
#(HINT: Look at the lubridate functions called month() and hour()). 
#Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.

library(tidyverse)
library(lubridate)
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mloa
#Use the README file associated with the Mauna Loa dataset to determine 
#in what time zone the data are reported, and how missing values are 
#reported in each column.

#copy and paste this into the search bar
#https://github.com/gge-ucd/R-DAVIS/blob/master/data/mauna_loa_README.txt

#1
#With the mloa data.frame, remove observations with missing values in rel_humid,
#temp_C_2m, and windSpeed_m_s.

mloa_sub = mloa %>% filter(rel_humid!=-99,temp_C_2m!=-999.9,windSpeed_m_s!=-99.9)

#2
#Generate a column called “datetime” using the year, month, day, hour24, and min columns. 

#Next, create a column called “datetimeLocal” that converts the datetime
#column to Pacific/Honolulu time (HINT: look at the lubridate function 
#called with_tz()). Then, use dplyr to calculate the mean hourly 
#temperature each month using the temp_C_2m column and the datetimeLocal
#columns. (HINT: Look at the lubridate functions called month() and 
#hour()). Finally, make a ggplot scatterplot of the mean monthly 
#temperature, with points colored by local hour.

# this version pastes year month day together by row and then calls ymd
#sep=what is separating the things
#paste function will push strings together; it can help us separate things with a space or dash mark
?paste

mloa_sub %>% mutate(datetime = paste(year,month,day,sep = '-')) %>%
  mutate(datetime = ymd(datetime)) %>% select(datetime)

#this version does both actions at once in the same mutate call
mloa_sub %>% mutate(datetime = ymd(paste(year,month,day,sep = '-'))) %>% select(datetime)

#now let's add in hour24...
mloa_sub %>% mutate(datetime = ymd_h(paste(year,month,day,hour24,sep = '-'))) %>% select(datetime)


#now let's add in min..
mloa_sub %>% mutate(datetime = ymd_hm(paste(year,month,day,hour24,min,sep = '-'))) %>% select(datetime)

#now let's add in min, and we are done with this task
mloa_sub = mloa_sub %>% mutate(datetime = ymd_hm(paste(year,month,day,hour24,min,sep = '-')))

mloa_sub

#Next, create a column called “datetimeLocal” that converts the datetime
#column to Pacific/Honolulu time (HINT: look at the lubridate function 
#called with_tz()). 
?with_tz()

mloa_sub$datetimeLocal  = with_tz(time = mloa_sub$datetime,tzone = 'Pacific/Honolulu')
##mloa_sub-- use $ to call column datetimeLocal- then use with_tz

#Then, use dplyr to calculate the mean hourly temperature each month 
#using the temp_C_2m column and the datetimeLocal
#columns. (HINT: Look at the lubridate functions called month() and 
#hour()). 
#Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.

mloa_sub %>%
  # Extract month and hour from local time column
  mutate(localMon = month(datetimeLocal, label = TRUE),
         localHour = hour(datetimeLocal)) %>%
  # Group by local month and hour
  group_by(localMon, localHour) %>%
  # Calculate mean temperature
  summarize(meantemp = mean(temp_C_2m)) %>%
  # Plot
  ggplot(aes(x = localMon,
             y = meantemp)) +
  # Color points by local hour
  geom_point(aes(col = localHour)) +
  # Use a nice color ramp
  scale_color_viridis_c() +
  # Label axes, add a theme
  xlab("Month") +
  ylab("Mean temperature (degrees C)") +
  theme_classic()