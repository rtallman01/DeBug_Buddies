# Working with date data

# read in some data
library(tidyverse)

# need to look at file first to see why it didn't read in
tempdata <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/2015_NFY_solinst.csv", skip=12)

# DATETIMES
library(lubridate)


# Formatting to Datetime --------------------------------------------------

tempdata <- tempdata %>%
  mutate(datetime = ymd_hms(paste0(Date, " ", Time)))

# everything within paste will default to a character


class(paste0(tempdata$Date, " ", tempdata$Time))



class(tempdata$Date)
class(tempdata$Time)
class(tempdata$datetime)

#POSIXct is in seconds since 1970 ( the number of seconds from January 1st, 1970). This is preferred because each date is stored as a single number. Makes it easier to compute.

unclass(tempdata$datetime[1]) 
# shows the number of seconds since January 1st, 1970.



# Working with POSIXct ----------------------------------------------------

(p1 <- tempdata[1,"datetime"]) # this is a single cell
(p1<- tempdata[1,]) # this is a single row
# "datetime" is the specific column you want to pull, referring to row 1.

# by adding parenthesis this print the value into our console


# convert P1 to POSIXlt
as.character(tempdata[1,6])
(tempdata[1,6])

p1 <- as.POSIXlt(paste0(p1$Date, " ", p1$Time))

str(p1)

unclass(p1)
# this is storing each piece of the data as its own slot

# 0 based indexing meaning that 0 is actually one. January is 0 and Feburary as 1.

# use POSIX ct becasue it will be much easier to use and can handle modeling better.




# Trying to export to specific date time format, creat new columns --------


mm <- 5
yyyy <-2015
dy <- 25

newcolumn <-paste0(year(tempdata$datetime),"/",month(tempdata$datetime),"/", day(tempdata$datetime))
# this will give you the year for every piece of data, now we can add a slash

newcolumn



# strptime base R ---------------------------------------------------------


ex1 <- "2011/05A01/T09:00"

ymd_hm(ex1) # default is with UTC time zone


as.POSIXct(ex1, format="%Y/%mA%d/T%H:%M") # time zone of my computer


# set a specific time zone ------------------------------------------------

as.POSIXct(ex1, format="%Y/%mA%d/T%H:%M", tz = "America/New_York") # the time it kept the same but the time zone has changed.


as.POSIXct(ex1, format="%Y/%mA%d/T%H:%M", tz = "America/Los_Angeles")
 