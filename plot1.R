### FILE:     plot1.R
### PURPOSE:  Plot #1 of Household Power Consumption data 
###           also loads file into R AND tidies it up (dates and subset)
###           once, subsetted NAs are no longer an issue.
###
### LANGUAGE: R statistical programming language
###           R version 3.2.1 (2015-06-18) -- "World Famous Astronaut"
###           Copyright (C) 2015 The R Foundation for Statistical Computing
###           Platform: x86_64-w64-mingw32/x64 (64-bit)
###
### IDE:      RStudio
###           Version 0.98.1103 © 2009-2014 RStudio, Inc.
###
### PLATFORM: Microsoft Windows 7 Professional [Version 6.1.7601]

### If you comment out this specific setwd(); use the getwd() to note what directory you are in.
setwd("C:/Users/Jim/Documents/GitHub/ExData_Plotting1/.data")

### Where am I? (in the directory tree -- useful for debugging file string)
getwd()

### What is the date? (useful for bibliography: retrieved URL on date)
dateLoadedToR <- date()


# Read in file delimited with ";" and with a HEADER row
# European file, but fortunately decimal point is period and not comma.
# But, do NOT read text as factors
# The missing/NA character is "?" (see assignment documentation)
# NOTE: Date column is backwards -- bad for sort -- will need to reformat
# NOTE: Time is 24 hours (if it begins with "17")

# Determine classes for read.table() by reading just first nrows
initial <- read.table("household_power_consumption.txt", nrows = 100,
                      header = TRUE, sep=";", dec = ".", 
                      na.strings = "?", stringsAsFactors = FALSE )

classes <- sapply(initial, class)

# Read in full table
household_power_consumption <- read.table("household_power_consumption.txt", 
                                          header = TRUE, sep=";", dec = ".", 
                                          colClasses = classes,
                                          na.strings = "?", stringsAsFactors = FALSE )

### str(household_power_consumption)



## read in date info in format 'dd/mm/yyyy'
household_power_consumption$Date2 <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

household_power_consumption$DateTime <- paste(format(household_power_consumption$Date2, format = "%Y-%m-%d", usetz = FALSE),
                                              household_power_consumption$Time)

## read in time info in format 'hh:mm:ss' and ignore timezone
household_power_consumption$DateTime2 <- strptime(household_power_consumption$DateTime, "%Y-%m-%d %H:%M:%S", tz = "")

str(household_power_consumption)
### Note NAs
summary(household_power_consumption)

### SUBSET BY Date2: "We will only be using data from the dates 2007-02-01 and 2007-02-02."
### If using just dates we can be inclusive; if using date-times have to be less than next day.
DateRange <- household_power_consumption$Date2 >= "2007-02-01" &  household_power_consumption$Date2 <= "2007-02-02"
HH_Power_DateSlice <- household_power_consumption[DateRange, ]

### head(HH_Power_DateSlice)
str(HH_Power_DateSlice)
### After subsetting NAs -- no more NAs
summary(HH_Power_DateSlice)

### Ways to refer to data:   
###     attach(HH_Power_DateSlice)  --OR--  with()  --OR-- just use "$".

### Assignment: "Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels."
### PNG commands from website:     
###     http://rfunction.com/archives/812
### png("plot1.png", width=480, height=480)
### PLOT GOES HERE
### dev.off()

# restore default of one plot
par(cex = .75, mfrow = c(1, 1), mar = c(4, 4, 2, 1))

### Write plot to project directory (NOT hidden data directory)
setwd("C:/Users/Jim/Documents/GitHub/ExData_Plotting1/")
### Plot 1: Global Active Power (uncomment next line to save output in Plot1.png)
png("plot1.png", width=480, height=480)
with(HH_Power_DateSlice, 
     hist(Global_active_power, col = "red", 
          main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)" )
)

dev.off()
# restore default of one plot
par(cex = .75, mfrow = c(1, 1), mar = c(4, 4, 2, 1))

### Set directory back to hidden/.gitignore ".data" directory
setwd("C:/Users/Jim/Documents/GitHub/ExData_Plotting1/.data")

### NOTE: "plot1.png" should have been created in  /GitHub/ExData_Plotting1/
### NOTE: Need to "git add plot1.png".


### End of: plot1.R