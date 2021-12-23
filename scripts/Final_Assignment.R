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

##create a column with day month year date formats
summary(fpw_joined$day.x)
##make a day month year column
alldata <- fpw_joined %>% 
  filter(!is.na(year.x) & !is.na(month.x) & !is.na(day.x))
summary(alldata$day.x)
alldata$dmypaste <- paste(alldata$day.x, alldata$month.x, alldata$year.x, sep = " ")
class(alldata$dmypaste)
alldata$dmypaste
library(lubridate)
alldata1 <- alldata %>% 
  mutate(date_dmy = dmy(dmypaste))
class(alldata1$date_dmy)  

alldata1 <- alldata1 %>% 
  filter(!is.na(dep_delay)) %>% 
  group_by(date_dmy, carrier) %>% 
  mutate(meandelay = mean(dep_delay)) %>% 
  ungroup()
alldata1

alldata_septhrudec <- alldata1 %>% 
  filter(month.x >= 9 & month.x <= 12 )

ggplot(data = alldata_septhrudec, mapping = aes(x = date_dmy, y = meandelay)) +
  geom_point(aes(color = carrier))

ggsave(filename = "mean_delay_by_carrier_sep_dec.pdf", path = "plots")


#3. Create a dataframe with these columns: date (year, month and day), mean_temp, where each row represents the airport, based on airport code. Save this is a new csv into you data folder called mean_temp_by_origin.csv.

alldata_complete_date_temp_airport <- alldata %>% 
  filter(!is.na(temp) & !is.na(origin.x))
alldata_complete_date_temp_airport$ymdpaste <- paste(alldata_complete_date_temp_airport$year.x, alldata_complete_date_temp_airport$month.x, alldata_complete_date_temp_airport$day.x, sep = " ")

alldata2 <- alldata_complete_date_temp_airport %>% 
  mutate(date_ymd = ymd(ymdpaste))
class(alldata2$date_ymd)  
alldata2 <- alldata2 %>% 
  group_by(date_ymd, origin.x) %>% 
  mutate(mean_temp = mean(temp)) %>% 
  ungroup()
View(alldata2)  

##select just relevant columns
ymd_origin_mean_temp <- alldata2 %>% 
  group_by(origin.x, date_ymd) %>% 
  summarise(mean_temp = mean(temp))
ymd_origin_mean_temp
wide_origin_meantemp <- pivot_wider(ymd_origin_mean_temp, names_from = date_ymd, values_from = mean_temp)
write_csv(wide_origin_meantemp, file = "data/wide_origin_meantemp.csv")

#4. Make a function that can: (1) convert hours to minutes; and (2) convert minutes to hours (i.e., it’s going to require some sort of conditional setting in the function that determines which direction the conversion is going). Use this function to convert departure delay (currently in minutes) to hours and then generate a boxplot of departure delay times by carrier. Save this function into a script called “customFunctions.R” in your scripts/code folder.

x <- c(1,2)
v <- vector(length = length(x))
v
vector_making_fxn <- function(x){
  v <- rep(NA, length(x))
  print(v)
}

v8 <- c(2,4,6,8)
vector_making_fxn(v8)
m_h_conv <- function(x, start_with_minute = TRUE) {
  v <- rep(NA, length(x))
  if(start_with_minute == TRUE) {
    v <- x/60}
  else {
    v <- x*60
  }
  v}

m_h_conv(weight_g, FALSE)


save(m_h_conv, file = "scripts/customfunctions.R")

##boxplot of departure delays by carrier, in hours

data_hours <- alldata %>% 
  filter(!is.na(dep_delay) & !is.na(carrier)) %>% 
  mutate(hr_delay = m_h_conv(dep_delay)) %>% 
  group_by(carrier) %>% 
  mutate(mean_delay = mean(hr_delay)) %>% 
  mutate(med_delay = median(hr_delay))
summary(data_hours$med_delay)

data_hours

#5. Below is the plot we generated from the new data in Q4. (Base code: ggplot(df, aes(x = dep_delay_hrs, y = carrier, fill = carrier)) +   geom_boxplot()). The goal is to visualize delays by carrier. Do (at least) 5 things to improve this plot by changing, adding, or subtracting to this plot. The sky’s the limit here, remember we often reduce data to more succinctly communicate things.
##starting with:

ggplot(data_hours, mapping = aes(x = hr_delay, y = carrier, fill = carrier)) +
  geom_boxplot()
##change scale of y axis--this includes all but 33 outliers and gives a much better sense of differences in data distribution between carriers

ggplot(data_hours, mapping = aes(x = carrier, y = hr_delay, fill = carrier)) +
  geom_boxplot() +
  ylim(-0.5, 6)
##reorder by median delay of each carrier
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot() +
  ylim(-0.5, 6)
##remove lines
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot() +
  ylim(-0.5, 4) +
  theme_classic()

##adjust transparency
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot(alpha = 0.25) +
  ylim(-0.5, 4) +
  theme_classic()

##change axis labels
ggplot(data_hours, mapping = aes(x = reorder(carrier, med_delay), y = hr_delay, fill = carrier)) +
  geom_boxplot(alpha = 0.25) +
  ylim(-0.5, 4) +
  theme_classic()+
  labs( x = "Carrier",
        y = "Delay (hours)",
        title = "Delay by Carrier",
        color = "Carrier")


